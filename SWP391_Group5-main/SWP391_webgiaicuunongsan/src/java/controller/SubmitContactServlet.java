package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;

@WebServlet("/submitContact")
public class SubmitContactServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:sqlserver://localhost:1433;databaseName=AgriRescue;encrypt=true;trustServerCertificate=true";
    private static final String DB_USER = "sa";
    private static final String DB_PASSWORD = "123";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(
                     "INSERT INTO contact_requests (user_id, name, email, subject, message) VALUES (?, ?, ?, ?, ?)")) {

            pstmt.setInt(1, userId);
            pstmt.setString(2, name);
            pstmt.setString(3, email);
            pstmt.setString(4, subject);
            pstmt.setString(5, message);
            pstmt.executeUpdate();

            response.sendRedirect("Contact.jsp?success=true");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi gửi yêu cầu.");
            request.getRequestDispatcher("Contact.jsp").forward(request, response);
        }
    }
}