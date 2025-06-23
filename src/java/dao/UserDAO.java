package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;
import utils.DBUtil;

public class UserDAO {

    public static final UserDAO INSTANCE = new UserDAO();

    public static boolean isUsernameExist(String username) {
        String query = "SELECT 1 FROM users WHERE username = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public static boolean isEmailExist(String email) {
        String query = "SELECT 1 FROM users WHERE email = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public static boolean isPhoneExist(String phone) {
        String query = "SELECT 1 FROM users WHERE phone = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public static boolean register(User user) {
        String sql = "INSERT INTO users (username, password, name, email, phone, role, created_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, GETDATE())";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPhone());
            ps.setString(6, user.getRole());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public static User checkLogin(String usernameOrEmail, String password) {
        String sql = "SELECT * FROM users WHERE (username = ? OR email = ?) AND password = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, usernameOrEmail);
            ps.setString(2, usernameOrEmail);
            ps.setString(3, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setFullName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("phone"));
                    user.setRole(rs.getString("role"));
                    user.setCreatedAt(rs.getTimestamp("created_at"));
                    return user;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public int getUserIdByUsername(String username) {
        String sql = "SELECT user_id FROM users WHERE username = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("user_id");
            }
        } catch (Exception e) {
            e.printStackTrace(); // Hoặc dùng Logger như các hàm khác
        }
        return -1; // Không tìm thấy hoặc có lỗi
    }

    public boolean updateProfile(String username, String fullName, String email, String phone, String address) {
        String sql = "UPDATE users SET name = ?, email = ?, phone = ?, address = ? WHERE username = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, phone != null && !phone.isEmpty() ? phone : null);
            ps.setString(4, address != null && !address.isEmpty() ? address : null);
            ps.setString(5, username);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
            return false;
        }
    }

    public boolean updatePassword(String username, String newPassword) {
        String sql = "UPDATE users SET password = ? WHERE username = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setString(2, username);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
            return false;
        }
    }

    public boolean deleteAccount(String username) {
        String sql = "DELETE FROM users WHERE username = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
            return false;
        }
    }

    public List<User> getAllUsersExcept(int currentUserId) throws SQLException, Exception {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE user_id != ?";

        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, currentUserId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                System.out.println(">>> Found user: " + rs.getString("username")); // Debug dòng in ra username
                User u = new User(
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("username"),
                        rs.getString("password"),
                        null, // 🔄 address không tồn tại
                        rs.getString("role")
                );
                u.setUserId(rs.getInt("user_id")); // 🟢 FIX QUAN TRỌNG
                users.add(u);
            }
        }
        return users;
    }

    public List<User> searchUsersExcept(int currentUserId, String keyword) throws SQLException, Exception {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE user_id != ? AND (username LIKE ? OR name LIKE ?)"; // 🔄 full_name → name

        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, currentUserId);
            ps.setString(2, "%" + keyword + "%");
            ps.setString(3, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                System.out.println(">>> Found user (search): " + rs.getString("username")); // Debug
                User u = new User(
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("username"),
                        rs.getString("password"),
                        null, // 🔄 address không tồn tại
                        rs.getString("role")
                );
                u.setUserId(rs.getInt("user_id"));  // ✅ thêm userId
                users.add(u);
            }
        }
        return users;
    }

    public User getUserById(int id) {
    String query = "SELECT * FROM users WHERE user_id = ?"; // ✅ FIXED
    try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            User user = new User(
                rs.getString("name"),
                rs.getString("email"),
                rs.getString("phone"),
                rs.getString("username"),
                rs.getString("password"),
                null, // 🔄 address không tồn tại
                rs.getString("role")
            );
            user.setUserId(rs.getInt("user_id")); // ✅ bắt buộc
            return user;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return null;
}

    public User getUserByUsername(String username) throws SQLException, Exception {
    String sql = "SELECT * FROM users WHERE username = ?";
    try (Connection con = DBUtil.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            User user = new User(
                rs.getString("name"),
                rs.getString("email"),
                rs.getString("phone"),
                rs.getString("username"),
                rs.getString("password"),
                null, // 🔄 address không tồn tại
                rs.getString("role")
            );
            user.setUserId(rs.getInt("user_id")); // ✅ THÊM DÒNG NÀY
            return user;
        }
    }
    return null;
}

}
