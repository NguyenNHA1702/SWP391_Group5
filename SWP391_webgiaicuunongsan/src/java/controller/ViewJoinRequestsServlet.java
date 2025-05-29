/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.JoinRequestDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.JoinRequest;

public class ViewJoinRequestsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession();

        String role = (String) session.getAttribute("role");
        Integer userId = (Integer) session.getAttribute("userId"); // 

        if (userId == null || (!"farmer".equals(role) && !"admin".equals(role))) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<JoinRequest> joinRequests = JoinRequestDAO.getPendingRequestsByUserId(userId);
        request.setAttribute("joinRequests", joinRequests);

        // Chuyển tiếp đến trang JSP hiển thị danh sách yêu cầu
        request.getRequestDispatcher("/Farmer/viewJoinRequests.jsp").forward(request, response);
    }
}



