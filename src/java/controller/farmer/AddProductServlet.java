/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.farmer;

import dao.ProductDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.Product;
import model.User;

import java.io.IOException;
import java.sql.Timestamp;

public class AddProductServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("account");

        if (user == null || !"farmer".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String quantityStr = request.getParameter("quantity");
        String language = request.getParameter("language");
        String campaignIdStr = request.getParameter("campaignId");

        // Kiểm tra dữ liệu trống
        if (name == null || name.isEmpty()
                || description == null || description.isEmpty()
                || priceStr == null || priceStr.isEmpty()
                || quantityStr == null || quantityStr.isEmpty()
                || language == null || language.isEmpty()
                || campaignIdStr == null || campaignIdStr.isEmpty()) {

            // Giữ lại dữ liệu đã nhập
            request.setAttribute("name", name);
            request.setAttribute("description", description);
            request.setAttribute("price", priceStr);
            request.setAttribute("quantity", quantityStr);
            request.setAttribute("language", language);
            request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ thông tin mặt hàng.");

            request.getRequestDispatcher("/Farmer/createProduct.jsp").forward(request, response);

            return;
        }

        try {
            double price = Double.parseDouble(priceStr);
            int quantity = Integer.parseInt(quantityStr);
            int campaignId = Integer.parseInt(campaignIdStr);

            Product p = new Product();
            p.setUserId(user.getUserId());
            p.setName(name);
            p.setDescription(description);
            p.setPrice(price);
            p.setQuantity(quantity);
            p.setLanguage(language);
            p.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            p.setCampaignId(campaignId);

            ProductDAO.insertProduct(p);
            response.sendRedirect("farmer/inventory?campaignId=" + campaignId);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Giá và số lượng phải là số hợp lệ.");
            request.setAttribute("name", name);
            request.setAttribute("description", description);
            request.setAttribute("price", priceStr);
            request.setAttribute("quantity", quantityStr);
            request.setAttribute("language", language);
            request.setAttribute("campaignId", campaignIdStr);
            request.getRequestDispatcher("/Farmer/createProduct.jsp").forward(request, response);

        }
    }
}
