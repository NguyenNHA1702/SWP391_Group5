package dao;

import java.sql.*;
import java.util.*;
import model.Conversation;
import model.Message;
import model.UserInfo;
import utils.DBUtil;

public class MessageDAO {

    private static final String DB_URL = "jdbc:sqlserver://localhost:1433;databaseName=AgriRescue_DB1";
    private static final String DB_USER = "sa";
    private static final String DB_PASSWORD = "123";

    public List<Conversation> getConversations(int userId) throws SQLException {
    List<Conversation> conversations = new ArrayList<>();
    String sql =
    "SELECT " +
    "  t.other_user_id, " +
    "  u.username AS other_username, " +
    "  SUM(CASE WHEN m.receiver_id = ? AND m.is_read = 0 THEN 1 ELSE 0 END) AS unread_count " +
    "FROM messages m " +
    "JOIN ( " +
    "  SELECT message_id, " +
    "         CASE WHEN sender_id = ? THEN receiver_id ELSE sender_id END AS other_user_id " +
    "  FROM messages " +
    "  WHERE sender_id = ? OR receiver_id = ? " +
    ") t ON t.message_id = m.message_id " +
    "JOIN users u ON u.user_id = t.other_user_id " +
    "GROUP BY t.other_user_id, u.username";

    try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
         PreparedStatement ps = conn.prepareStatement(sql)) {
        for (int i = 1; i <= 4; i++) {
            ps.setInt(i, userId);
        }
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                conversations.add(new Conversation(
                    rs.getInt("other_user_id"),
                    rs.getString("other_username"),
                    rs.getInt("unread_count")
                ));
            }
        }
    }
    return conversations;
}

    public List<Map<String, Object>> getMessages(int userId, int otherUserId) throws SQLException {
        List<Map<String, Object>> messages = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD); PreparedStatement stmt = conn.prepareStatement(
                "SELECT m.message_id, m.sender_id, m.receiver_id, m.content, m.language, m.is_read, m.sent_time, u.username AS sender_username "
                + "FROM messages m "
                + "JOIN users u ON m.sender_id = u.user_id "
                + "WHERE (m.sender_id = ? AND m.receiver_id = ?) OR (m.sender_id = ? AND m.receiver_id = ?) "
                + "ORDER BY m.sent_time ASC")) {
            stmt.setInt(1, userId);
            stmt.setInt(2, otherUserId);
            stmt.setInt(3, otherUserId);
            stmt.setInt(4, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> message = new HashMap<>();
                    message.put("messageId", rs.getInt("message_id"));
                    message.put("senderId", rs.getInt("sender_id"));
                    message.put("receiverId", rs.getInt("receiver_id"));
                    message.put("content", rs.getString("content"));
                    message.put("language", rs.getString("language"));
                    message.put("isRead", rs.getBoolean("is_read"));
                    message.put("sentTime", rs.getTimestamp("sent_time").toString());
                    message.put("senderUsername", rs.getString("sender_username"));
                    messages.add(message);
                }
            }
        }
        return messages;
    }

    public void markAsRead(int userId, int otherUserId) throws SQLException {
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD); PreparedStatement stmt = conn.prepareStatement(
                "UPDATE messages SET is_read = 1 WHERE receiver_id = ? AND sender_id = ? AND is_read = 0")) {
            stmt.setInt(1, userId);
            stmt.setInt(2, otherUserId);
            stmt.executeUpdate();
        }
    }

    public List<UserInfo> getUsers(int userId) throws SQLException {
        List<UserInfo> users = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD); PreparedStatement stmt = conn.prepareStatement(
                "SELECT user_id, username FROM users WHERE user_id != ?")) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    users.add(new UserInfo(rs.getInt("user_id"), rs.getString("username")));
                }
            }
        }
        return users;
    }

    public void sendMessage(Message message) throws SQLException {
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD); PreparedStatement stmt = conn.prepareStatement(
                "INSERT INTO messages (sender_id, receiver_id, content, language, is_read, sent_time) VALUES (?, ?, ?, ?, 0, GETDATE())")) {
            stmt.setInt(1, message.getSenderId());
            stmt.setInt(2, message.getReceiverId());
            stmt.setString(3, message.getContent());
            stmt.setString(4, message.getLanguage());
            stmt.executeUpdate();
        }
    }

    public int getUnreadCount(int userId) throws SQLException {
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD); PreparedStatement stmt = conn.prepareStatement(
                "SELECT COUNT(*) AS count FROM messages WHERE receiver_id = ? AND is_read = 0")) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("count");
                }
            }
        }
        return 0;
    }
}
