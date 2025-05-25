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

        HttpSession session = request.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("user_role") : null;

        if (role == null || !"buyer".equals(role)) {
            response.sendRedirect("login.jsp");
            return;
        }
        String productName = request.getParameter("productName");
        String productSort = request.getParameter("productSort");

        String campaignTitle = request.getParameter("campaignTitle");
        String campaignSort = request.getParameter("campaignSort");

        List<Product> products = ProductDAO.searchAndSortProducts(productName, productSort);
        List<Campaign> campaigns = CampaignDAO.searchAndSortCampaigns(campaignTitle, campaignSort);

        request.setAttribute("products", products);
        request.setAttribute("campaigns", campaigns);

        request.getRequestDispatcher("Buyer/browse.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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
