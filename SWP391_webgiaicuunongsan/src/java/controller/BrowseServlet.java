/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CampaignDAO;
import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Campaign;
import model.Product;

/**
 *
 * @author admin
 */
@WebServlet(name = "BrowseServlet", urlPatterns = {"/browse"})
public class BrowseServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Lấy session hiện tại và lấy giá trị role của người dùng
        HttpSession session = request.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;

        if (role == null || !"buyer".equals(role)) {
            response.sendRedirect("login.jsp");
            return;
        }
        //Lấy các tham số tìm kiếm và sắp xếp từ request

       String productName = request.getParameter("productName");
        String productSort = request.getParameter("productSort");
        // Tìm kiếm và sắp xếp chiến dịch theo tiêu đề và tiêu chí sắp xếp
        String campaignTitle = request.getParameter("campaignTitle");
        String campaignSort = request.getParameter("campaignSort");
        //Gọi các hàm DAO để tìm kiếm và sắp xếp danh sách sản phẩm và chiến dịch dựa trên các tiêu chí người dùng nhập.
        List<Product> products = ProductDAO.searchAndSortProducts(productName, productSort);
        List<Campaign> campaigns = CampaignDAO.searchAndSortCampaigns(campaignTitle, campaignSort);

        request.setAttribute("products", products);
        request.setAttribute("campaigns", campaigns);
        //Chuyển tiếp sang trang Buyer/browse.jsp để hiển thị kết quả
        request.getRequestDispatcher("Buyer/browse.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
