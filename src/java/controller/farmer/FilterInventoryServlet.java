/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.farmer;

import dao.ProductDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Product;

import java.io.IOException;
import java.util.List;

@WebServlet("/filter-inventory")
public class FilterInventoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("name");
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");
        String inStockStr = request.getParameter("inStock");

        Double minPrice = null, maxPrice = null;
        Boolean inStock = null;

        try {
            if (minPriceStr != null && !minPriceStr.isEmpty()) {
                minPrice = Double.parseDouble(minPriceStr);
            }
            if (maxPriceStr != null && !maxPriceStr.isEmpty()) {
                maxPrice = Double.parseDouble(maxPriceStr);
            }
            if ("true".equals(inStockStr)) {
                inStock = true;
            }
        } catch (NumberFormatException e) {
            e.printStackTrace(); // Log lỗi nếu có
        }

        ProductDAO dao = new ProductDAO();
        List<Product> filteredProducts = dao.filterProducts(keyword, minPrice, maxPrice, inStock);

        request.setAttribute("products", filteredProducts);
        String campaignId = request.getParameter("campaignId");
        StringBuilder redirectUrl = new StringBuilder("farmer/inventory?");

        if (campaignId != null) {
            redirectUrl.append("campaignId=").append(campaignId).append("&");
        }
        if (keyword != null) {
            redirectUrl.append("name=").append(keyword).append("&");
        }
        if (minPrice != null) {
            redirectUrl.append("minPrice=").append(minPrice).append("&");
        }
        if (maxPrice != null) {
            redirectUrl.append("maxPrice=").append(maxPrice).append("&");
        }
        if (inStock != null && inStock) {
            redirectUrl.append("inStock=true");
        }

        response.sendRedirect(redirectUrl.toString());

    }
}
