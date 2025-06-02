package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import dao.UserDAO;
import utils.DBUtil;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Xử lý userId từ session
        Object userIdObj = session.getAttribute("userId");
        String userId = null;
        if (userIdObj instanceof Integer) {
            userId = String.valueOf(userIdObj);
        } else if (userIdObj instanceof String) {
            userId = (String) userIdObj;
        }

        // Kiểm tra đăng nhập
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String username = null;
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        String currentEmail = null;
        String currentPhone = null;

        try (Connection conn = DBUtil.getConnection()) {
            // Lấy thông tin hiện tại của người dùng (username, email, phone)
            String sql = "SELECT username, email, phone FROM users WHERE user_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, Integer.parseInt(userId));
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        username = rs.getString("username");
                        currentEmail = rs.getString("email");
                        currentPhone = rs.getString("phone");
                    } else {
                        response.sendRedirect("userprofile.jsp?error=" + URLEncoder.encode("User not found.", StandardCharsets.UTF_8));
                        return;
                    }
                }
            }

            // Kiểm tra email trùng lặp
            if (!email.equals(currentEmail)) {
                if (UserDAO.INSTANCE.isEmailExist(email)) {
                    response.sendRedirect("userprofile.jsp?error=" + URLEncoder.encode("Email already exists.", StandardCharsets.UTF_8));
                    return;
                }
            }

            // Kiểm tra số điện thoại trùng lặp
            if (phone != null && !phone.trim().isEmpty() && !phone.equals(currentPhone)) {
                if (UserDAO.INSTANCE.isPhoneExist(phone)) {
                    response.sendRedirect("userprofile.jsp?error=" + URLEncoder.encode("Phone number already exists.", StandardCharsets.UTF_8));
                    return;
                }
            }

            // Cập nhật thông tin người dùng
            boolean updated = UserDAO.INSTANCE.updateProfile(username, fullName, email, phone, null);
            if (updated) {
                response.sendRedirect("userprofile.jsp?success=" + URLEncoder.encode("Profile updated successfully.", StandardCharsets.UTF_8));
            } else {
                response.sendRedirect("userprofile.jsp?error=" + URLEncoder.encode("Failed to update profile.", StandardCharsets.UTF_8));
            }
        } catch (SQLException e) {
            response.sendRedirect("userprofile.jsp?error=" + URLEncoder.encode("Database error: " + e.getMessage(), StandardCharsets.UTF_8));
        } catch (Exception e) {
            response.sendRedirect("userprofile.jsp?error=" + URLEncoder.encode("Unexpected error: " + e.getMessage(), StandardCharsets.UTF_8));
        }
    }
}