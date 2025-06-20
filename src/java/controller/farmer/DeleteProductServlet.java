/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.farmer;

import dao.ProductDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class DeleteProductServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String productIdStr = request.getParameter("productId");
        String campaignId = request.getParameter("campaignId");

        try {
            int productId = Integer.parseInt(productIdStr);
            ProductDAO.deleteProduct(productId);
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Quay lại inventory.jsp với campaignId nếu có
        if (campaignId != null) {
            response.sendRedirect("farmer/inventory?campaignId=" + campaignId);
        } else {
            response.sendRedirect("farmer/inventory");
        }
    }
}

