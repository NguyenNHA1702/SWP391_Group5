package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;
import java.sql.*;

public class LoginServlet extends HttpServlet {

    // Nếu cần thiết cho thống kê tin nhắn chưa đọc
    private static final String DB_URL = "jdbc:sqlserver://localhost:1433;databaseName=AgriRescue_DB2";
    private static final String DB_USER = "sa";
    private static final String DB_PASSWORD = "123";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain;charset=UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            response.getWriter().print("missing");
            return;
        }

        // Xử lý chuẩn hóa email
        email = email.trim().toLowerCase();

        try {
            User user = UserDAO.checkLogin(email, password);

            if (user != null) {
                if (!Boolean.TRUE.equals(user.getApproved())) {
                    response.getWriter().print("not_approved");
                    return;
                }

                HttpSession session = request.getSession(true);

                session.setAttribute("user", user.getUsername());
                session.setAttribute("displayName", user.getFullName());
                session.setAttribute("role", user.getRole());
                session.setAttribute("userId", user.getUserId());
                session.setAttribute("account", user);

                // ✅ Nếu cần: set số tin nhắn chưa đọc
                int unreadMessages = getUnreadMessagesCount(user.getUserId());
                session.setAttribute("unreadMessages", unreadMessages);

                response.getWriter().print("success:" + user.getRole().toLowerCase());
            } else {
                response.getWriter().print("incorrect");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().print("error:server_error");
        }
    }

    private int getUnreadMessagesCount(int userId) {
        int unreadCount = 0;
        String sql = "SELECT COUNT(*) AS count FROM messages WHERE receiver_id = ? AND is_read = 0";

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                unreadCount = rs.getInt("count");
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Có thể log lỗi
        }

        return unreadCount;
    }
}
