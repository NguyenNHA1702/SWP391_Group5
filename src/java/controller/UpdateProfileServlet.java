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
    if (userIdObj == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    int userId;
    try {
        userId = Integer.parseInt(userIdObj.toString());
    } catch (NumberFormatException e) {
        response.sendRedirect("userprofile.jsp?error=" + URLEncoder.encode("Invalid userId format.", StandardCharsets.UTF_8));
        return;
    }

    String fullName = request.getParameter("fullName"); // Dữ liệu từ form
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");

    String currentEmail = null;
    String currentPhone = null;

    try (Connection conn = DBUtil.getConnection()) {
        // Lấy thông tin hiện tại của người dùng
        String sqlSelect = "SELECT email, phone FROM users WHERE user_id = ?";
        try (PreparedStatement psSelect = conn.prepareStatement(sqlSelect)) {
            psSelect.setInt(1, userId);
            try (ResultSet rs = psSelect.executeQuery()) {
                if (rs.next()) {
                    currentEmail = rs.getString("email");
                    currentPhone = rs.getString("phone");
                } else {
                    response.sendRedirect("userprofile.jsp?error=" + URLEncoder.encode("User not found.", StandardCharsets.UTF_8));
                    return;
                }
            }
        }

        // Kiểm tra email và phone rỗng
        if (fullName == null || fullName.trim().isEmpty() || email == null || email.trim().isEmpty()) {
            response.sendRedirect("userprofile.jsp?error=" + URLEncoder.encode("Full name and email are required.", StandardCharsets.UTF_8));
            return;
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
        String sqlUpdate = "UPDATE users SET name = ?, email = ?, phone = ? WHERE user_id = ?"; // Sử dụng cột 'name'
        try (PreparedStatement psUpdate = conn.prepareStatement(sqlUpdate)) {
            psUpdate.setString(1, fullName); // Gán fullName vào cột name
            psUpdate.setString(2, email);
            psUpdate.setString(3, phone != null ? phone : ""); // Đặt giá trị mặc định nếu phone null
            psUpdate.setInt(4, userId);
            int rowsAffected = psUpdate.executeUpdate();
            System.out.println("Update attempt for userId: " + userId + ", rowsAffected: " + rowsAffected);
            if (rowsAffected > 0) {
                response.sendRedirect("userprofile.jsp?success=" + URLEncoder.encode("Profile updated successfully.", StandardCharsets.UTF_8));
            } else {
                response.sendRedirect("userprofile.jsp?error=" + URLEncoder.encode("Failed to update profile. Check database structure or userId.", StandardCharsets.UTF_8));
            }
        }
    } catch (SQLException e) {
        response.sendRedirect("userprofile.jsp?error=" + URLEncoder.encode("Database error: " + e.getMessage(), StandardCharsets.UTF_8));
    } catch (Exception e) {
        response.sendRedirect("userprofile.jsp?error=" + URLEncoder.encode("Unexpected error: " + e.getMessage(), StandardCharsets.UTF_8));
    }
}
}