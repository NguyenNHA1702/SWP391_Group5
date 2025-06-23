/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.buyer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.CartItem;
import model.Product;
import dao.ProductDAO;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");

        if (role == null || !role.equals("buyer")) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity  = Integer.parseInt(request.getParameter("quantity"));
            // Đọc campaignId từ form
            String campaignId = request.getParameter("campaignId");

            Product product = ProductDAO.getProductById(productId);
            if (product == null || product.getProductId() <= 0) {
                response.sendRedirect(request.getContextPath() + "/error.jsp");
                return;
            }

            // Lấy cart hiện tại từ session hoặc tạo mới
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            if (cart == null) {
                cart = new ArrayList<>();
            }

            boolean found = false;
            for (CartItem item : cart) {
                if (item.getProduct().getProductId() == productId) {
                    item.setQuantity(item.getQuantity() + quantity);
                    found = true;
                    break;
                }
            }

            if (!found) {
                cart.add(new CartItem(product, quantity));
            }

            session.setAttribute("cart", cart);

            //xu li nut back
            String cp = request.getContextPath();
            String target = cp + "/Buyer/cart.jsp";
            if (campaignId != null && !campaignId.isEmpty()) {
                target += "?campaignId=" + campaignId;
            }
            response.sendRedirect(target);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid input format");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }
}


