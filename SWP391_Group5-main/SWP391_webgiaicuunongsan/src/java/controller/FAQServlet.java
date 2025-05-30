package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/faq")
public class FAQServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Get the session
        HttpSession session = request.getSession(false); // Do not create a new session if it doesn't exist
        Integer farmerId = (Integer) session.getAttribute("userId");

        // Check if farmerId exists, redirect to login if not
        if (farmerId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Forward to faq.jsp if authenticated
        request.getRequestDispatcher("/FAQ.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Handle POST requests if needed, or redirect to doGet
        doGet(request, response);
    }
}