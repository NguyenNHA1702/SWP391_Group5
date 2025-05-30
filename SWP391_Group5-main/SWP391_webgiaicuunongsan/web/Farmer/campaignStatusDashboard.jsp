<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Campaign" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Campaign Status Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    body {
        background: #ffffff; /* Nền trắng */
        min-height: 100vh;
        font-family: 'Poppins', sans-serif;
        margin: 0;
        padding: 0;
    }
    .container {
        background: rgba(255, 255, 255, 0.95);
        border-radius: 20px;
        padding: 40px;
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        margin-top: 30px;
        margin-bottom: 30px;
        max-width: 900px;
    }
    h1 {
        color: #2c3e50; /* màu đen xám đậm */
        font-weight: 700;
        text-align: center;
        margin-bottom: 30px;
        text-transform: uppercase;
        letter-spacing: 1.5px;
    }
        .back-button {
       background: linear-gradient(to right, #2e7d32, #66bb6a); /* Xanh lá cây tươi */
       color: white;
       font-weight: bold;
       padding: 15px 30px;
       border-radius: 30px;
       border: none;
       cursor: pointer;
       font-size: 18px;
     }
    .status-table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0;
        background: #ffffff;
        border-radius: 15px;
        overflow: hidden;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
    }
        /* Tiêu đề bảng */
        .status-table th {
          background-color: #2e7d32; /* Xanh lá cây tươi */
          color: white;
          padding: 15px 20px;
          text-align: left;
          font-weight: 600;
          text-transform: uppercase;
          letter-spacing: 1px;
        }

        /* Bo góc cho hai đầu tiêu đề */
        .status-table th:first-child {
          border-top-left-radius: 20px;
        }

        .status-table th:last-child {
          border-top-right-radius: 20px;
        }

    .status-table td {
        padding: 15px 20px;
        border-bottom: 1px solid #ecf0f1;
        transition: background 0.3s, transform 0.2s;
    }
    .status-table tr:hover {
        background: #e8f5e9; /* xanh lá nhạt khi hover */
        transform: scale(1.01);
    }
    .status-pending, .status-approved, .status-rejected {
        display: inline-flex;
        align-items: center;
        padding: 6px 12px;
        border-radius: 15px;
        font-size: 0.9em;
        font-weight: 500;
        transition: transform 0.2s;
    }
    .status-pending:hover, .status-approved:hover, .status-rejected:hover {
        transform: scale(1.05);
    }
    .status-pending {
        background: #fef8e7;
        color: #f39c12;
    }
    .status-pending i {
        color: #f39c12;
        margin-right: 5px;
    }
    .status-approved {
        background: #e0f5ec;
        color: #2ecc71;
    }
    .status-approved i {
        color: #2ecc71;
        margin-right: 5px;
    }
    .status-rejected {
        background: #fae3e3;
        color: #e74c3c;
    }
    .status-rejected i {
        color: #e74c3c;
        margin-right: 5px;
    }
    .no-data {
        text-align: center;
        color: #7f8c8d;
        padding: 30px;
        font-style: italic;
    }
</style>

</head>
<body>
    <div class="container">
        <h1>Campaign Status Dashboard</h1>
        <a href="<%= request.getContextPath() %>/campaigns" class="btn btn-primary mb-4">Quay lại My Campaigns</a>
        <%
            List<Campaign> campaigns = (List<Campaign>) request.getAttribute("campaigns");
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
        %>
        <table class="status-table">
            <thead>
                <tr>
                    <th>CAMPAIGN NAME</th>
                    <th>SUBMISSION DATE</th>
                    <th>STATUS</th>
                </tr>
            </thead>
            <tbody>
                <% if (campaigns != null && !campaigns.isEmpty()) {
                    for (Campaign c : campaigns) {
                        String adminStatus = c.getAdminStatus() != null ? c.getAdminStatus().toLowerCase() : "pending";
                        String statusClass = "status-" + adminStatus;
                        String submissionDate = c.getCreatedAt() != null ? sdf.format(c.getCreatedAt()) : "";
                %>
                <tr>
                    <td><%= c.getTitle() %></td>
                    <td><%= submissionDate %></td>
                    <td>
                        <span class="<%= statusClass %>">
                            <% if (adminStatus.equals("pending")) { %>
                                <i class="fas fa-hourglass-half"></i>
                            <% } else if (adminStatus.equals("approved")) { %>
                                <i class="fas fa-check-circle"></i>
                            <% } else if (adminStatus.equals("rejected")) { %>
                                <i class="fas fa-times-circle"></i>
                            <% } %>
                            <%= adminStatus %>
                        </span>
                    </td>
                </tr>
                <% 
                    }
                } else {
                %>
                <tr>
                    <td colspan="3" class="no-data">Không có chiến dịch nào để hiển thị.</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>