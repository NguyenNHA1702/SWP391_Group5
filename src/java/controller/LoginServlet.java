package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginServlet extends HttpServlet {

    // Database connection details (update with your credentials)
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

        // Input validation
        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            response.getWriter().print("error:missing_fields");
            return;
        }

        // Sanitize email to prevent injection (basic example, consider more robust sanitization)
        email = email.trim().toLowerCase();

        try {
            User user = UserDAO.checkLogin(email, password);

            if (user != null) {
                HttpSession session = request.getSession(true); // Create new session if none exists

                // Set session attributes
                session.setAttribute("user", user.getUsername());
                session.setAttribute("displayName", user.getFullName());
                session.setAttribute("role", user.getRole());
                session.setAttribute("userId", user.getUserId());
                session.setAttribute("account", user);

                // Set unread messages count
                int unreadMessages = getUnreadMessagesCount(user.getUserId());
                session.setAttribute("unreadMessages", unreadMessages);

                // Return success with role
                response.getWriter().print("success:" + user.getRole().toLowerCase());
            } else {
                response.getWriter().print("error:invalid_credentials");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().print("error:server_error");
        }
    }

    // Method to count unread messages
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
            e.printStackTrace();
            // Log error but don't expose details to client
        }
        return unreadCount;
    }
}