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
     * - Kiểm tra đăng nhập và vai trò người dùng. - Lấy danh sách chiến dịch
     * theo tiêu đề . - Kiểm tra và cập nhật trạng thái "completed" cho chiến
     * dịch. - Gửi danh sách campaign và quyền chỉnh sửa về trang JSP.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Kiểm tra đăng nhập và vai trò người dùng.
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
        //Lấy danh sách chiến dịch theo tiêu đề (nếu có)
        String title = request.getParameter("title");
        if (title == null) {
            title = "";
        }
        CampaignDAO dao = new CampaignDAO();
        List<Campaign> campaigns = campaignDAO.getCampaignsByTitle(userId, title);
        //Kiểm tra xem chiến dịch đã hoàn thành chưa (completed), bằng cách:
        //So sánh số tiền gây quỹ hiện tại với mục tiêu.
        //Kiểm tra xem ngày kết thúc đã qua chưa.
        for (Campaign c : campaigns) {
            checkAndUpdateCampaignStatus(c);
            String status = c.getStatus() != null ? c.getStatus().toLowerCase() : "";
            boolean canEdit = false;
            if ("pending".equals(status) || "news".equals(status)) {
                canEdit = true;
            }
            request.setAttribute("canEdit_" + c.getCampaignId(), canEdit);
        }
        //Gửi danh sách campaign và quyền chỉnh sửa về trang JSP.
        request.setAttribute("campaigns", campaigns);
        request.getRequestDispatcher("/Farmer/campaignList.jsp").forward(request, response);

    }

    /**
     * - Kiểm tra đăng nhập. - Nhận dữ liệu JSON chiến dịch từ client. - Kiểm
     * tra tính hợp lệ: tiêu đề, số tiền, ngày bắt đầu/kết thúc - Gọi DAO để
     * thêm mới hoặc cập nhật chiến dịch. - Trả về "success" hoặc thông báo lỗi
     * phù hợp.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain;charset=UTF-8");
        //  Kiểm tra đăng nhập.
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.getWriter().write("unauthorized");
            return;
        }

        // đọc dữ liệu JSON được gửi từ client và chuyển đổi nó thành một đối tượng JsonObject
        StringBuilder sb = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        }
        Gson gson = new Gson();
        JsonObject jsonObj = gson.fromJson(sb.toString(), JsonObject.class);

        //Kiểm tra tính hợp lệ: tiêu đề, số tiền, ngày bắt đầu/kết thúc...
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

            if (title.isEmpty() || goalAmountStr.isEmpty() || startDateStr.isEmpty() || endDateStr.isEmpty()) {
                response.getWriter().write("error: Vui lòng điền đầy đủ các trường bắt buộc.");
                return;
            }

            double goalAmount = Double.parseDouble(goalAmountStr);
            if (goalAmount <= 100000) {
                response.getWriter().write("error: Mục tiêu phải lớn hơn 100000");
                return;
            }

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date startDate = sdf.parse(startDateStr);
            Date endDate = sdf.parse(endDateStr);

            if (!endDate.after(startDate)) {
                response.getWriter().write("error: Ngày kết thúc phải sau ngày bắt đầu.");
                return;
            }
            // Tạo mới 1 đối tượng campaign bằng dữ liệu lấy từ JSON
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

            Integer userId = (Integer) session.getAttribute("userId");
            campaign.setUserId(userId);
            //Gọi DAO để thêm mới hoặc cập nhật chiến dịch
            boolean result;
            if (campaignId > 0) {
                result = campaignDAO.updateCampaign(campaign);
            } else {
                result = campaignDAO.addCampaign(campaign);
            }

            //Trả về "success" hoặc thông báo lỗi phù hợp
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

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    /**
     * Kiểm tra và cập nhật trạng thái chiến dịch thành 'completed' nếu: - Số
     * tiền hiện tại đạt mục tiêu. - Ngày kết thúc đã qua.
     */
    private void checkAndUpdateCampaignStatus(Campaign campaign) {
        String currentStatus = campaign.getStatus();
        if ("completed".equalsIgnoreCase(currentStatus)) {
            return;
        }
        //Số tiền hiện tại đạt mục tiêu
        boolean shouldComplete = false;
        if (campaign.getCurrentAmount() >= campaign.getGoalAmount()) {
            shouldComplete = true;
        }
        // Kiếm tra xem ngày kết thúc đã qua
        Date now = new Date();
        if (campaign.getEndDate() != null && !campaign.getEndDate().after(now)) {
            shouldComplete = true;
        }
        // Nếu thỏa mãn gọi DAO cập nhật status camaign
        if (shouldComplete) {
            campaignDAO.updateCampaignStatus(campaign.getCampaignId(), "completed");
            campaign.setStatus("completed");
        }
    }
}


