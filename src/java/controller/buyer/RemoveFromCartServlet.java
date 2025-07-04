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

@WebServlet("/remove-from-cart")
public class RemoveFromCartServlet extends HttpServlet {
  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
      HttpSession session = request.getSession();
      List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

      
      String productIdStr = request.getParameter("productId");
      String campaignId  = request.getParameter("campaignId");

      if (cart != null && productIdStr != null) {
          try {
              int productId = Integer.parseInt(productIdStr);
              cart.removeIf(item -> item.getProduct().getProductId() == productId);
              session.setAttribute("cart", cart);
          } catch (NumberFormatException ignored) { }
      }

     
      String cp     = request.getContextPath();              
      String target = cp + "/Buyer/cart.jsp";
      if (campaignId != null && !campaignId.isEmpty()) {
          target += "?campaignId=" + campaignId;
      }
      response.sendRedirect(target);
  }
}
