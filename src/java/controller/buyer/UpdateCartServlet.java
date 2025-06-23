/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.buyer;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.CartItem;

import java.io.IOException;
import java.util.List;

@WebServlet("/update-cart")
public class UpdateCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart != null) {
            for (int i = 0; i < cart.size(); i++) {
                String quantityStr = request.getParameter("quantity_" + i);
                if (quantityStr != null) {
                    try {
                        int quantity = Integer.parseInt(quantityStr);
                        if (quantity > 0) {
                            cart.get(i).setQuantity(quantity);
                        }
                    } catch (NumberFormatException ignored) {

                    }
                }
            }
        }

        String campaignId = request.getParameter("campaignId");
        response.sendRedirect(request.getContextPath() + "/Buyer/cart.jsp?campaignId=" + campaignId);


    }
}
