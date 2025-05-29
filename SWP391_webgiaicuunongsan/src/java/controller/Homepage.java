package controller;

import dao.CampaignDAO;
import model.Campaign;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;
import dao.JoinRequestDAO;

public class Homepage extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        CampaignDAO dao = new CampaignDAO();
        List<Campaign> campaigns = dao.getApprovedActiveCampaigns();
        request.setAttribute("campaigns", campaigns);

          HttpSession session = request.getSession(false);
    if (session != null && "farmer".equals(session.getAttribute("role"))) {
        String username = (String) session.getAttribute("user");
        int pending = JoinRequestDAO.countPendingRequestsForFarmer(username);
        request.setAttribute("pendingJoinRequests", pending);
    }

    request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
