package controller;

import dao.CampaignDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.Campaign;

public class CampaignStatusDashboardServlet extends HttpServlet {

    private final CampaignDAO campaignDAO = new CampaignDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra đăng nhập và vai trò
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

        // Lấy danh sách chiến dịch của farmer
        List<Campaign> campaigns = campaignDAO.getCampaignsByUserId(userId);
        if (campaigns == null) {
            campaigns = List.of(); // Tránh null pointer trong JSP
        }

        // Đặt dữ liệu vào request và forward đến JSP
        request.setAttribute("campaigns", campaigns);
        request.getRequestDispatcher("/Farmer/campaignStatusDashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Tạm thời chuyển hướng POST về GET
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for displaying campaign status dashboard";
    }
}