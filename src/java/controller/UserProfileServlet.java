package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet("/UserProfileServlet")
public class UserProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Object userObj = session.getAttribute("user");

        // Kiểm tra và ép kiểu an toàn
        User user = null;
        if (userObj instanceof User) {
            user = (User) userObj;
        } else {
            // Nếu user trong session không phải là model.User (có thể là String từ phiên bản cũ), hủy session và yêu cầu đăng nhập lại
            session.invalidate();
            response.sendRedirect("login.jsp?error=Session invalid. Please login again.");
            return;
        }

        String role = (String) session.getAttribute("role");

        // Kiểm tra đăng nhập
        if (user == null || role == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Lưu thông tin người dùng vào request để JSP sử dụng
        request.setAttribute("username", user.getUsername());
        request.setAttribute("fullName", user.getFullName());
        request.setAttribute("email", user.getEmail());
        request.setAttribute("phone", user.getPhone());
        request.setAttribute("role", role);
        request.setAttribute("createdAt", user.getCreatedAt() != null ? user.getCreatedAt().toString() : "Not specified");

        // Chuyển tiếp đến userprofile.jsp để hiển thị
        request.getRequestDispatcher("userprofile.jsp").forward(request, response);
    }
}