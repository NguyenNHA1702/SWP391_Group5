package controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dao.UserDAO;
import utils.DBUtil;

@WebServlet("/DeleteAccountServlet")
public class DeleteAccountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        HttpSession session = request.getSession();
        Object userIdObj = session.getAttribute("userId");

        // Kiểm tra và xử lý userId
        String userId = null;
        if (userIdObj instanceof Integer) {
            userId = String.valueOf((Integer) userIdObj);
        } else if (userIdObj instanceof String) {
            userId = (String) userIdObj;
        }

        // Kiểm tra đăng nhập dựa trên userId
        if (userId == null) {
            response.sendRedirect("login.jsp?error=" + URLEncoder.encode("Please login first.", StandardCharsets.UTF_8));
            return;
        }

        String message = null;
        try (Connection conn = DBUtil.getConnection()) {
            // Lấy username từ userId
            String sql = "SELECT username FROM users WHERE user_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, Integer.parseInt(userId));
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        String username = rs.getString("username");

                        // Xóa tài khoản
                        boolean deleted = UserDAO.INSTANCE.deleteAccount(username);
                        if (deleted) {
                            // Hủy session sau khi xóa tài khoản
                            session.invalidate();
                            message = "Account deleted successfully. You have been logged out.";
                            response.sendRedirect("login.jsp?success=" + URLEncoder.encode(message, StandardCharsets.UTF_8));
                            return;
                        } else {
                            message = "Failed to delete account.";
                        }
                    } else {
                        message = "User not found.";
                    }
                }
            }
        } catch (NumberFormatException e) {
            message = "Invalid user ID format.";
        } catch (SQLException e) {
            message = "Database error: " + e.getMessage();
        } catch (Exception e) {
            message = "Unexpected error: " + e.getMessage();
        }

        // Chuyển hướng về userprofile.jsp nếu có lỗi
        response.sendRedirect("userprofile.jsp?error=" + URLEncoder.encode(message, StandardCharsets.UTF_8));
    }
}