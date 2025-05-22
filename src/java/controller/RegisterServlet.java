package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

import java.io.IOException;

public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String username = request.getParameter("user");
        String password = request.getParameter("pass");
        String address = request.getParameter("address");

        if (UserDAO.INSTANCE.isUsernameExist(username)) {
            request.setAttribute("error", "Username already exists!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else if (UserDAO.INSTANCE.isEmailExist(email)) {
            request.setAttribute("error", "Email already exists!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else if (UserDAO.INSTANCE.isPhoneExist(phone)) {
            request.setAttribute("error", "Phone number already exists!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else {
            User newUser = new User(fullName, email, phone, username, password, address);
            boolean success = UserDAO.INSTANCE.register(newUser);
            if (success) {
                request.setAttribute("ms1", "Account successfully created!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Failed to create account. Please try again later.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        }
    }
}
