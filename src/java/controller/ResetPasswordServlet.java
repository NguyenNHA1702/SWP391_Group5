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
import model.User;
import utils.DBUtil;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {
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

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        String message = null;
        try (Connection conn = DBUtil.getConnection()) {
            // Lấy thông tin người dùng từ userId
            String sql = "SELECT username, email FROM users WHERE user_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, Integer.parseInt(userId));
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        String username = rs.getString("username");
                        String email = rs.getString("email");

                        // Kiểm tra đăng nhập với email và mật khẩu hiện tại
                        User currentUser = UserDAO.INSTANCE.checkLogin(email, currentPassword);
                        if (currentUser == null) {
                            message = "Current password is incorrect.";
                        } else if (!newPassword.equals(confirmPassword)) {
                            message = "New passwords do not match.";
                        } else if (newPassword.length() < 6) {
                            message = "New password must be at least 6 characters.";
                        } else {
                            // Cập nhật mật khẩu mới (không mã hóa)
                            boolean updated = UserDAO.INSTANCE.updatePassword(username, newPassword);
                            if (updated) {
                                message = "Password reset successfully.";
                            } else {
                                message = "Failed to reset password.";
                            }
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

        // Chuẩn bị thông số chuyển hướng
        String successParam = message != null && message.contains("successfully") 
            ? URLEncoder.encode(message, StandardCharsets.UTF_8) 
            : "";
        String errorParam = message != null && !message.contains("successfully") 
            ? URLEncoder.encode(message, StandardCharsets.UTF_8) 
            : "";

        // Chuyển hướng về userprofile.jsp để hiển thị thông báo
        response.sendRedirect("userprofile.jsp?success=" + successParam + "&error=" + errorParam);
    }
}