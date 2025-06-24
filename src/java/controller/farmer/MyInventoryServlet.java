package controller.farmer;

import dao.CampaignDAO;
import dao.OrderDAO;
import dao.ProductDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.Campaign;
import model.Product;
import model.User;

import java.io.IOException;
import java.util.List;
import java.util.Map;

public class MyInventoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            if (session == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            String role = (String) session.getAttribute("role");
            if (!List.of("farmer", "buyer", "admin").contains(role)) {
                response.sendRedirect("login.jsp");
                return;
            }

            User user = (User) session.getAttribute("account");
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            int userId = user.getUserId();
            String username = user.getUsername();
            System.out.println("✅ Logged in userId: " + userId + " | username: " + username + " | role: " + role);

            ProductDAO productDAO = new ProductDAO();
            CampaignDAO campaignDAO = new CampaignDAO();

            // 👉 Lấy các tham số lọc từ request
            String name = request.getParameter("name");
            String minPriceStr = request.getParameter("minPrice");
            String maxPriceStr = request.getParameter("maxPrice");
            String inStockStr = request.getParameter("inStock");
            String campaignIdStr = request.getParameter("campaignId");

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
                System.out.println("⚠️ Invalid price filter");
            }

            List<Product> products;

            // 👉 Lọc theo chiến dịch hoặc theo người dùng
            if (campaignIdStr != null && !campaignIdStr.isEmpty()) {
                try {
                    int campaignId = Integer.parseInt(campaignIdStr);
                    products = productDAO.filterProductsByCampaign(campaignId, name, minPrice, maxPrice, inStock);
                } catch (NumberFormatException e) {
                    products = List.of(); // nếu campaignId lỗi
                }
            } else {
                products = productDAO.filterProductsByUser(userId, name, minPrice, maxPrice, inStock);
            }

            // 👉 Tính số lượng đã bán
            Map<Integer, Integer> soldMap = OrderDAO.getSoldQuantityMap();
            for (Product p : products) {
                p.setSoldQty(soldMap.getOrDefault(p.getProductId(), 0));
            }

            List<Campaign> myApprovedCampaigns = campaignDAO.getApprovedActiveCampaignsByFarmer(username);

            request.setAttribute("products", products);
            request.setAttribute("campaigns", myApprovedCampaigns);
            request.getRequestDispatcher("/Farmer/inventory.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Something went wrong.");
        }
    }
}
