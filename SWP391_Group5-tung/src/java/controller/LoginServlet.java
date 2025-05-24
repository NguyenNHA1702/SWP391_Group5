package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;

public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String usernameOrEmail = request.getParameter("user");
        String password = request.getParameter("pass");

        User user = UserDAO.checkLogin(usernameOrEmail, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user_name", user.getFullName());
            session.setAttribute("user_role", user.getRole());
            session.setAttribute("user_id", user.getId());

            if ("farmer".equals(user.getRole())) {
                session.setAttribute("farmerId", user.getId()); // ✅ Thêm dòng này để fix lỗi
                response.sendRedirect("farmer-dashboard.jsp");
            } else if ("buyer".equals(user.getRole())) {
                response.sendRedirect("buyer-dashboard.jsp");
            } else if ("admin".equals(user.getRole())) {
                response.sendRedirect("admin-dashboard.jsp");
            } else {
                response.sendRedirect("index.jsp");
            }
        } else {
            request.setAttribute("error", "Sai email hoặc mật khẩu.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
