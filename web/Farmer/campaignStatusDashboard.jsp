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
            color: #2c3e50; /* Màu đen xám đậm */
            font-weight: 700;
            text-align: center;
            margin-bottom: 30px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
        }
        .control-section {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 30px;
            align-items: center;
        }
        .back-button {
            background: linear-gradient(to right, #0288d1, #4fc3f7); /* Xanh dương nhẹ */
            color: white;
            font-weight: bold;
            padding: 12px 25px;
            border-radius: 25px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            transition: transform 0.2s, box-shadow 0.3s;
        }
        .back-button:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(2, 136, 209, 0.4);
        }
        .search-box, .filter-box {
            flex: 1;
            min-width: 200px;
        }
        .search-box input {
            width: 100%;
            padding: 10px 15px 10px 40px;
            border: 1px solid #2e7d32;
            border-radius: 20px;
            font-size: 0.9em;
            outline: none;
            transition: border-color 0.3s;
        }
        .search-box input:focus {
            border-color: #66bb6a;
            box-shadow: 0 0 5px rgba(46, 125, 50, 0.3);
        }
        .search-box i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #2e7d32;
        }
        .filter-box select,
        .filter-box input[type="date"] {
            padding: 10px;
            border: 1px solid #2e7d32;
            border-radius: 20px;
            font-size: 0.9em;
            outline: none;
            transition: border-color 0.3s;
        }
        .filter-box select {
            width: 100%;
        }
        .filter-box input[type="date"] {
            width: 150px; /* Chiều rộng cố định để ngắn lại */
        }
        .filter-box select:focus,
        .filter-box input[type="date"]:focus {
            border-color: #66bb6a;
            box-shadow: 0 0 5px rgba(46, 125, 50, 0.3);
        }
        .filter-box label {
            font-size: 0.9em;
            color: #2c3e50;
            margin-right: 8px;
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
        .status-table th {
            background-color: #2e7d32; /* Xanh lá cây tươi */
            color: white;
            padding: 15px 20px;
            text-align: left;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
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
            background: #e8f5e9; /* Xanh lá nhạt khi hover */
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
        <div class="control-section">
            <a href="<%= request.getContextPath() %>/campaigns" class="back-button">Quay lại My Campaigns</a>
            <div class="search-box" style="position: relative; flex: 2;">
                <i class="fas fa-search"></i>
                <input type="text" id="searchInput" placeholder="Tìm kiếm theo tiêu đề..." onkeypress="if(event.keyCode === 13) filterTable()">
            </div>
            <div class="filter-box" style="flex: 1;">
                <select id="statusFilter" onchange="filterTable()">
                    <option value="">Tất cả trạng thái</option>
                    <option value="pending">Pending</option>
                    <option value="approved">Approved</option>
                    <option value="rejected">Rejected</option>
                </select>
            </div>
            <div class="filter-box" style="flex: 1; display: flex; align-items: center;">
                <label for="submissionDate">Lọc theo ngày gửi:</label>
                <input type="date" id="submissionDate" onchange="filterTable()">
            </div>
        </div>

        <%
            List<Campaign> campaigns = (List<Campaign>) request.getAttribute("campaigns");
            SimpleDateFormat sdfData = new SimpleDateFormat("dd/MM/yyyy"); // Định dạng cho data-date
            SimpleDateFormat sdfDisplay = new SimpleDateFormat("dd/MM/yyyy HH:mm"); // Định dạng hiển thị
        %>
        <table class="status-table" id="campaignTable">
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
                        String dataDate = c.getCreatedAt() != null ? sdfData.format(c.getCreatedAt()) : "";
                        String displayDate = c.getCreatedAt() != null ? sdfDisplay.format(c.getCreatedAt()) : "";
                %>
                <tr data-title="<%= c.getTitle().toLowerCase() %>" data-status="<%= adminStatus %>" data-date="<%= dataDate %>">
                    <td><%= c.getTitle() %></td>
                    <td><%= displayDate %></td>
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
    <script>
        function filterTable() {
            const searchInput = document.getElementById("searchInput").value.toLowerCase();
            const statusFilter = document.getElementById("statusFilter").value.toLowerCase();
            const submissionDate = document.getElementById("submissionDate").value;

            const rows = document.querySelectorAll("#campaignTable tbody tr");

            rows.forEach(row => {
                const title = row.getAttribute("data-title");
                const status = row.getAttribute("data-status");
                const dateStr = row.getAttribute("data-date");

                // Chuyển đổi ngày từ định dạng "dd/MM/yyyy" sang đối tượng Date
                let date = null;
                if (dateStr) {
                    const [day, month, year] = dateStr.split("/");
                    date = new Date(year, month - 1, day); // month - 1 vì tháng trong JavaScript bắt đầu từ 0
                    if (isNaN(date.getTime())) {
                        date = null; // Nếu ngày không hợp lệ, đặt lại thành null
                    }
                }

                // Kiểm tra điều kiện tìm kiếm và lọc
                const matchesSearch = searchInput === "" || title.includes(searchInput);
                const matchesStatus = statusFilter === "" || status === statusFilter;
                let matchesDate = true;

                if (submissionDate) {
                    const filterDate = new Date(submissionDate);
                    filterDate.setHours(0, 0, 0, 0);
                    if (date) {
                        date.setHours(0, 0, 0, 0);
                        matchesDate = date.getTime() === filterDate.getTime(); // So sánh thời gian Unix
                    } else {
                        matchesDate = false;
                    }
                }

                // Hiển thị hoặc ẩn hàng
                if (matchesSearch && matchesStatus && matchesDate) {
                    row.style.display = "";
                } else {
                    row.style.display = "none";
                }
            });

            // Kiểm tra nếu không có hàng nào hiển thị
            const visibleRows = document.querySelectorAll("#campaignTable tbody tr:not([style*='display: none'])");
            const noDataRow = document.querySelector(".no-data");
            if (visibleRows.length === 0 && !noDataRow) {
                const tbody = document.querySelector("#campaignTable tbody");
                const newRow = document.createElement("tr");
                newRow.innerHTML = '<td colspan="3" class="no-data">Không có chiến dịch nào để hiển thị.</td>';
                tbody.appendChild(newRow);
            } else if (visibleRows.length > 0 && noDataRow) {
                noDataRow.parentElement.removeChild(noDataRow);
            }
        }
    </script>
</body>
</html>