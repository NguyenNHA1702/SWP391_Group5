package controller.farmer;

import dao.ProductDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.Product;
import model.User;

import java.io.IOException;

public class EditProductServlet extends HttpServlet {

    // GET: Hiển thị form sửa sản phẩm
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");

        try {
            int id = Integer.parseInt(idStr);
            Product product = ProductDAO.getProductById(id);

            if (product == null) {
                response.sendRedirect("farmer/inventory");
                return;
            }

            request.setAttribute("product", product);
            request.getRequestDispatcher("/Farmer/editProduct.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("farmer/inventory");
        }
    }

    // POST: Lưu lại dữ liệu đã sửa
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String idStr = request.getParameter("productId");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String quantityStr = request.getParameter("quantity");
        String language = request.getParameter("language");
        String campaignId = request.getParameter("campaignId");
        try {
            int id = Integer.parseInt(idStr);
            double price = Double.parseDouble(priceStr);
            int quantity = Integer.parseInt(quantityStr);

            Product product = new Product();
            product.setProductId(id);
            product.setName(name);
            product.setDescription(description);
            product.setPrice(price);
            product.setQuantity(quantity);
            product.setLanguage(language);
            ProductDAO.updateProduct(product); // cần có hàm này
            response.sendRedirect("farmer/inventory?campaignId=" + campaignId);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Thông tin không hợp lệ.");
            Product fallback = ProductDAO.getProductById(Integer.parseInt(idStr));
            request.setAttribute("product", fallback);
            request.getRequestDispatcher("/Farmer/editProduct.jsp").forward(request, response);
        }
    }
}
