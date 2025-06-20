package controller.farmer;

import dao.CampaignDAO;
import dao.ProductDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.Campaign;
import model.Product;
import model.User;

import java.io.IOException;
import java.util.List;

public class MyInventoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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

        List<Product> products;
        String campaignIdStr = request.getParameter("campaignId");

        if (campaignIdStr != null && !campaignIdStr.isEmpty()) {
            try {
                int campaignId = Integer.parseInt(campaignIdStr);
                System.out.println("🔍 Filtering products by campaignId = " + campaignId);
                products = productDAO.getProductsByCampaign(campaignId);
            } catch (NumberFormatException e) {
                System.out.println("⚠️ Invalid campaignId: " + campaignIdStr);
                products = List.of(); // hoặc bạn có thể redirect về error page
            }
        } else {
            products = productDAO.getProductsByUser(userId);
        }

        // Lấy danh sách campaign đã tạo (dành riêng cho farmer, nhưng dùng chung để tránh null)
        List<Campaign> myApprovedCampaigns = campaignDAO.getApprovedActiveCampaignsByFarmer(username);

        System.out.println("📦 Products returned: " + products.size());
        for (Product p : products) {
            System.out.println("➡️ " + p.getProductId() + " - " + p.getName());
        }

        request.setAttribute("products", products);
        request.setAttribute("campaigns", myApprovedCampaigns);
        request.getRequestDispatcher("/Farmer/inventory.jsp").forward(request, response);
    }
}
