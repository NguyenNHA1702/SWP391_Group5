package controller.farmer;

import dao.ProductDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.Product;
import model.User;

import java.io.IOException;

public class EditProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        String campaignId = request.getParameter("campaignId");     

        try {
            int id = Integer.parseInt(idStr);
            Product product = ProductDAO.getProductById(id);

            if (product == null) {
                // redirect vẫn kèm campaignId nếu có
                String cp = request.getContextPath();
                if (campaignId != null && !campaignId.isEmpty()) {
                    response.sendRedirect(cp + "/farmer/inventory?campaignId=" + campaignId);
                } else {
                    response.sendRedirect(cp + "/farmer/inventory");
                }
                return;
            }

            // set attribute cả product và campaignId
            request.setAttribute("product", product);
            request.setAttribute("campaignId", campaignId);

            // forward sang JSP
            request.getRequestDispatcher("/Farmer/editProduct.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            String cp = request.getContextPath();
            if (campaignId != null && !campaignId.isEmpty()) {
                response.sendRedirect(cp + "/farmer/inventory?campaignId=" + campaignId);
            } else {
                response.sendRedirect(cp + "/farmer/inventory");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        // 1) Lấy các param
        int id = Integer.parseInt(req.getParameter("productId"));
        String campaignId = req.getParameter("campaignId");
        String name = req.getParameter("name");
        String desc = req.getParameter("description");
        double price = Double.parseDouble(req.getParameter("price"));
        int qty = Integer.parseInt(req.getParameter("quantity"));
        String lang = req.getParameter("language");

        // 2) Update object và DB
        try {
            Product p = ProductDAO.getProductById(id);
            p.setName(name);
            p.setDescription(desc);
            p.setPrice(price);
            p.setQuantity(qty);
            p.setLanguage(lang);
            ProductDAO.updateProduct(p);
        } catch (Exception e) {
            e.printStackTrace();
            // bạn có thể forward lại với error nếu muốn
        }

        // 3) Redirect về inventory giống AddProductServlet
        String cp = req.getContextPath();
        String target = cp + "/farmer/inventory";
        if (campaignId != null && !campaignId.isEmpty()) {
            target += "?campaignId=" + campaignId;
        }
        resp.sendRedirect(target);
    }
}
