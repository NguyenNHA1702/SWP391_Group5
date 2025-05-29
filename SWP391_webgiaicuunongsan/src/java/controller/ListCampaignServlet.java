/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CampaignDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import model.Campaign;
import model.User;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.io.BufferedReader;

/**
 *
 * @author admin
 */
@WebServlet(name = "ListCampaignServlet", urlPatterns = {"/campaigns"})
public class ListCampaignServlet extends HttpServlet {

    private CampaignDAO campaignDAO = new CampaignDAO();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ListCampaignServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListCampaignServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String fullName = (String) session.getAttribute("user");

        if (fullName == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String role = (String) session.getAttribute("role");
        Integer userId = (Integer) session.getAttribute("userId");
        if (role == null || !role.equals("farmer") || userId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        CampaignDAO dao = new CampaignDAO();
        List<Campaign> campaigns = dao.getCampaignsByUserId(userId);
        request.setAttribute("campaigns", campaigns);
        request.getRequestDispatcher("/Farmer/campaignList.jsp").forward(request, response);

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain;charset=UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.getWriter().write("unauthorized");
            return;
        }

        StringBuilder sb = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        }

        Gson gson = new Gson();
        JsonObject jsonObj = gson.fromJson(sb.toString(), JsonObject.class);

        try {
            int campaignId = jsonObj.has("campaignId") && !jsonObj.get("campaignId").getAsString().isEmpty()
                    ? Integer.parseInt(jsonObj.get("campaignId").getAsString())
                    : 0;

            String title = jsonObj.has("title") ? jsonObj.get("title").getAsString().trim() : "";
            String description = jsonObj.has("description") ? jsonObj.get("description").getAsString().trim() : "";
            String goalAmountStr = jsonObj.has("goalAmount") ? jsonObj.get("goalAmount").getAsString().trim() : "";
            String startDateStr = jsonObj.has("startDate") ? jsonObj.get("startDate").getAsString().trim() : "";
            String endDateStr = jsonObj.has("endDate") ? jsonObj.get("endDate").getAsString().trim() : "";
            String language = jsonObj.has("language") ? jsonObj.get("language").getAsString().trim() : "vi";
            String status = jsonObj.has("status") ? jsonObj.get("status").getAsString().trim().toLowerCase() : "active";

            if (title.isEmpty() || goalAmountStr.isEmpty() || startDateStr.isEmpty() || endDateStr.isEmpty()) {
                response.getWriter().write("error: Vui lòng điền đầy đủ các trường bắt buộc.");
                return;
            }

            double goalAmount = Double.parseDouble(goalAmountStr);
            if (goalAmount <= 10000) {
                response.getWriter().write("error: Mục tiêu phải lớn hơn 10.");
                return;
            }

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date startDate = sdf.parse(startDateStr);
            Date endDate = sdf.parse(endDateStr);

            if (!endDate.after(startDate)) {
                response.getWriter().write("error: Ngày kết thúc phải sau ngày bắt đầu.");
                return;
            }

            Campaign campaign = new Campaign();
            if (campaignId > 0) {
                campaign.setCampaignId(campaignId);
            }
            campaign.setTitle(title);
            campaign.setDescription(description);
            campaign.setGoalAmount(goalAmount);
            campaign.setStartDate(startDate);
            campaign.setEndDate(endDate);
            campaign.setLanguage(language);
            campaign.setStatus(status);

            Integer userId = (Integer) session.getAttribute("userId");
            campaign.setUserId(userId);

            boolean result;
            if (campaignId > 0) {
                result = campaignDAO.updateCampaign(campaign);
            } else {
                result = campaignDAO.addCampaign(campaign);
            }

            if (result) {
                response.getWriter().write("success");
            } else {
                response.getWriter().write("fail");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("error: " + e.getMessage());
        }
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
