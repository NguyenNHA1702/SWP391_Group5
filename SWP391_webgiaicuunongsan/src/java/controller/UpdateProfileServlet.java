package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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

        String username = request.getParameter("username");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        String currentEmail = null;
        String currentPhone = null;

        try (Connection conn = DBUtil.getConnection()) {
            // Lấy thông tin hiện tại của người dùng
            String sql = "SELECT email, phone FROM users WHERE user_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(userId));
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                currentEmail = rs.getString("email");
                currentPhone = rs.getString("phone");
            } else {
                response.sendRedirect("userprofile.jsp?error=User not found.");
                return;
            }

            // Kiểm tra email trùng lặp
            if (!email.equals(currentEmail)) {
                sql = "SELECT COUNT(*) FROM users WHERE email = ? AND user_id != ?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, email);
                ps.setInt(2, Integer.parseInt(userId));
                rs = ps.executeQuery();
                if (rs.next() && rs.getInt(1) > 0) {
                    response.sendRedirect("userprofile.jsp?error=Email already exists.");
                    return;
                }
            }

            // Kiểm tra số điện thoại trùng lặp
            if (phone != null && !phone.trim().isEmpty() && !phone.equals(currentPhone)) {
                sql = "SELECT COUNT(*) FROM users WHERE phone = ? AND user_id != ?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, phone);
                ps.setInt(2, Integer.parseInt(userId));
                rs = ps.executeQuery();
                if (rs.next() && rs.getInt(1) > 0) {
                    response.sendRedirect("userprofile.jsp?error=Phone number already exists.");
                    return;
                }
            }

            // Cập nhật thông tin người dùng
            String sqlUpdate = "UPDATE users SET name = ?, email = ?, phone = ? WHERE user_id = ?";
            PreparedStatement psUpdate = conn.prepareStatement(sqlUpdate);
            psUpdate.setString(1, fullName);
            psUpdate.setString(2, email);
            psUpdate.setString(3, phone != null && !phone.trim().isEmpty() ? phone : null);
            psUpdate.setInt(4, Integer.parseInt(userId));
            psUpdate.executeUpdate();

            response.sendRedirect("userprofile.jsp?success=Profile updated successfully.");
        } catch (SQLException e) {
            response.sendRedirect("userprofile.jsp?error=Error updating profile: " + e.getMessage());
        } catch (Exception e) {
            response.sendRedirect("userprofile.jsp?error=Unexpected error: " + e.getMessage());
        }
    }
}