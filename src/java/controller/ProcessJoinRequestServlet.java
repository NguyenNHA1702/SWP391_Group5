/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.JoinRequestDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class ProcessJoinRequestServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        try {
            int requestId = Integer.parseInt(request.getParameter("requestId"));
            String action = request.getParameter("action");

            // Ghi log kiểm tra
            System.out.println("🔧 ProcessJoinRequest: ID = " + requestId + ", Action = " + action);

            String status = null;
            if ("approve".equalsIgnoreCase(action)) {
                status = "approved";
            } else if ("reject".equalsIgnoreCase(action)) {
                status = "rejected";
            }

            if (status != null) {
                boolean updated = JoinRequestDAO.updateRequestStatus(requestId, status);
                if (updated) {
                    System.out.println("✅ Update thành công với status: " + status);
                } else {
                    System.out.println("❌ Update thất bại trong DAO.");
                }
            } else {
                System.out.println("⚠️ Action không hợp lệ: " + action);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Sau khi xử lý xong, quay lại trang danh sách
        response.sendRedirect("ViewJoinRequestsServlet");
    }
}




