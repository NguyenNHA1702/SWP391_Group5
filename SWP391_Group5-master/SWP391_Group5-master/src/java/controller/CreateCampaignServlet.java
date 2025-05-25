package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/CreateCampaignServlet")
public class CreateCampaignServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:sqlserver://localhost:1433;databaseName=AgriRescue;encrypt=true;trustServerCertificate=true";
    private static final String DB_USER = "sa";
    private static final String DB_PASSWORD = "123";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Integer userId = (Integer) session.getAttribute("user_id");
        System.out.println("User ID in session: " + userId);

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Lấy dữ liệu từ form
        String title = request.getParameter("title");
        String goalAmountStr = request.getParameter("goalAmount");
        String description = request.getParameter("description");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        String language = request.getParameter("language");

        // Kiểm tra dữ liệu bắt buộc
        if (title == null || goalAmountStr == null || startDateStr == null ||
            endDateStr == null || language == null ||
            title.trim().isEmpty() || goalAmountStr.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "Vui lòng điền đầy đủ các trường bắt buộc.");
            request.getRequestDispatcher("createCampaign.jsp").forward(request, response);
            return;
        }

        if (!language.equals("vi") && !language.equals("en")) {
            request.setAttribute("errorMessage", "Ngôn ngữ không hợp lệ.");
            request.getRequestDispatcher("createCampaign.jsp").forward(request, response);
            return;
        }

        try {
            double goalAmount = Double.parseDouble(goalAmountStr.trim());
            Date startDate = Date.valueOf(startDateStr.trim());
            Date endDate = Date.valueOf(endDateStr.trim());

            if (endDate.before(startDate)) {
                request.setAttribute("errorMessage", "Ngày kết thúc phải sau ngày bắt đầu.");
                request.getRequestDispatcher("createCampaign.jsp").forward(request, response);
                return;
            }

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement(
                    "INSERT INTO campaigns (user_id, title, description, goal_amount, start_date, end_date, language, status) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?)")) {

                stmt.setInt(1, userId);
                stmt.setString(2, title.trim());
                stmt.setString(3, description != null ? description.trim() : "");
                stmt.setDouble(4, goalAmount);
                stmt.setDate(5, startDate);
                stmt.setDate(6, endDate);
                stmt.setString(7, language);
                stmt.setString(8, "active");

                stmt.executeUpdate();
                response.sendRedirect("campaignSuccess.jsp");

            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Lỗi cơ sở dữ liệu. Vui lòng thử lại sau.");
                request.getRequestDispatcher("createCampaign.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Dữ liệu không hợp lệ.");
            request.getRequestDispatcher("createCampaign.jsp").forward(request, response);
        }
    }
}
