/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.CampaignDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Campaign;
/**
 *
 * @author HP
 */
public class EditCampaignServlet extends HttpServlet {
   
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    int id = Integer.parseInt(request.getParameter("id"));
    Campaign campaign = CampaignDAO.getCampaignById(id);
    request.setAttribute("campaign", campaign);
    request.getRequestDispatcher("editCampaign.jsp").forward(request, response);
}



    @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    int id = Integer.parseInt(request.getParameter("campaignId"));
    String title = request.getParameter("title");
    String description = request.getParameter("description");
    double goalAmount = Double.parseDouble(request.getParameter("goalAmount"));
    String endDate = request.getParameter("endDate");

    Campaign updated = new Campaign(id, title, description, goalAmount, endDate);
    boolean success = CampaignDAO.updateCampaign(updated);

    if (success) {
        response.sendRedirect("farmer-dashboard.jsp");
    } else {
        request.setAttribute("error", "Update failed!");
        request.getRequestDispatcher("editCampaign.jsp").forward(request, response);
    }
}
}

