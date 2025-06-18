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

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain;charset=UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            response.getWriter().print("missing");
            return;
        }

        User user = UserDAO.checkLogin(email, password);

        if (user != null) {
            HttpSession session = request.getSession();

            session.setAttribute("user", user.getUsername());
            session.setAttribute("displayName", user.getFullName());
            session.setAttribute("role", user.getRole());
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("account", user);

            // ✅ Trả về dạng "success:buyer" hoặc "success:admin"
            response.getWriter().print("success:" + user.getRole().toLowerCase());
        } else {
            response.getWriter().print("incorrect");
        }
    }
}
