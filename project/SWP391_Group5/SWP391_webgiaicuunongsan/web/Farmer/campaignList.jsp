<%-- 
    Document   : campaignList
    Created on : May 24, 2025, 11:48:47 PM
    Author     : admin
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.List, model.Campaign" %>
<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AgriRescue - Support Our Farmers</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f9f9f5; /* màu nền nhẹ nhàng như đất sáng */
            color: #2e3a23; /* màu chữ xanh đậm, tự nhiên */
            margin: 0;
            padding: 0 20px 40px 20px;
        }

        /* Header */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #567d46; /* xanh rừng */
            padding: 15px 20px;
            color: #f0f7e6;
            box-shadow: 0 2px 5px rgba(0,0,0,0.15);
            border-radius: 8px;
            margin-bottom: 25px;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .language-switch select {
            padding: 5px 10px;
            border-radius: 5px;
            border: 1.5px solid #a2b29f;
            background-color: #f0f7e6;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .language-switch select:hover {
            border-color: #3e5a22;
        }

        .header-title {
            font-size: 1.8rem;
            font-weight: 700;
            font-family: 'Georgia', serif;
            color: #f0f7e6;
            user-select: none;
        }

        .home-btn {
            padding: 8px 15px;
            background-color: #a6c48a;
            color: #2e3a23;
            font-weight: 600;
            border-radius: 6px;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }
        .home-btn:hover {
            background-color: #8bb05c;
            color: white;
        }

        .header-actions a, .header-actions span {
            font-weight: 600;
            color: #f0f7e6;
            margin-left: 15px;
            text-decoration: none;
        }
        .header-actions a:hover {
            text-decoration: underline;
        }

        /* Tiêu đề h2 */
        h2 {
            font-family: 'Georgia', serif;
            font-weight: 700;
            font-size: 1.7rem;
            color: #567d46;
            margin-bottom: 20px;
        }

        /* Bảng sản phẩm */
        .table-responsive {
            overflow-x: auto;
            margin-bottom: 40px;
        }

        table.table {
            width: 100%;
            border-collapse: collapse;
            background-color: #ffffff;
            box-shadow: 0 3px 10px rgb(0 0 0 / 0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        table thead {
            background-color: #a6c48a;
            color: #2e3a23;
            font-weight: 700;
        }

        table thead th {
            padding: 12px 15px;
            border-right: 1px solid #88a055;
            text-align: left;
        }

        table thead th:last-child {
            border-right: none;
        }

        table tbody td {
            padding: 12px 15px;
            border-bottom: 1px solid #e0e5d8;
            color: #4b5632;
            vertical-align: middle;
        }

        table tbody tr:nth-child(even) {
            background-color: #f7f9f2;
        }

        /* Các đường viền bảng đậm hơn */
        table.table-bordered,
        table.table-bordered th,
        table.table-bordered td {
            border: 2px solid #7b9a44;
        }

        /* Button chi tiết */
        .btn-detail {
            display: inline-block;
            padding: 6px 14px;
            background-color: #567d46;
            color: #f0f7e6;
            border-radius: 5px;
            font-weight: 600;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .btn-detail:hover {
            background-color: #3e5a22;
        }

        /* Phân trang */
        .pagination {
            justify-content: center;
            margin-top: 10px;
        }

        .pagination li a {
            color: #567d46;
            font-weight: 600;
        }

        .pagination li a:hover {
            background-color: #a6c48a;
            color: white;
        }

        /* Responsive */
        @media screen and (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 10px;
                text-align: center;
            }
            .header-left {
                justify-content: center;
                gap: 10px;
            }
            table thead th, table tbody td {
                font-size: 14px;
                padding: 8px 10px;
            }
            h2 {
                font-size: 1.4rem;
            }
        }

        .status-indicator {
            display: inline-block;
            width: 12px;
            height: 12px;
            border-radius: 50%;
            margin-right: 10px;
            vertical-align: middle;
        }

        td:nth-child(8) {
            min-width: 120px;
            white-space: nowrap;
            vertical-align: middle;
        }

        .status-active {
            background-color: #28a745;
        }

        .status-completed {
            background-color: #007bff;
        }

        .status-cancelled {
            background-color: #dc3545;
        }

        td:nth-child(8) {
            white-space: nowrap;
            vertical-align: middle;
        }

        /* Cải tiến giao diện Modal */
        .modal-content {
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
            border: none;
        }

        .modal-header {
            background-color: #567d46;
            color: #f0f7e6;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
            padding: 15px 20px;
        }

        .modal-title {
            font-family: 'Georgia', serif;
            font-weight: 700;
            font-size: 1.5rem;
        }

        .modal-body {
            padding: 25px;
            background-color: #fff;
        }

        .modal-footer {
            padding: 15px 20px;
            border-bottom-left-radius: 10px;
            border-bottom-right-radius: 10px;
            background-color: #f9f9f5;
        }

        .form-label {
            font-weight: 600;
            color: #2e3a23;
            margin-bottom: 8px;
        }

        .form-control, .form-select {
            border: 1px solid #a2b29f;
            border-radius: 5px;
            padding: 10px;
            font-size: 14px;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: #567d46;
            box-shadow: 0 0 5px rgba(86, 125, 70, 0.3);
            outline: none;
        }

        .form-control::placeholder {
            color: #a2b29f;
        }

        textarea.form-control {
            resize: vertical;
            height: 100px;
        }

        .mb-3 {
            margin-bottom: 20px !important;
        }

        .btn-primary {
            background-color: #567d46;
            border: none;
            padding: 10px 20px;
            font-weight: 600;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #3e5a22;
        }

        .btn-secondary {
            background-color: #a6c48a;
            border: none;
            color: #2e3a23;
            padding: 10px 20px;
            font-weight: 600;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .btn-secondary:hover {
            background-color: #8bb05c;
        }

        .modal-backdrop {
            background-color: rgba(0, 0, 0, 0.5);
        }
    </style>
</head>
<body>
    <%
        String user = (String) session.getAttribute("user");
        String role = (String) session.getAttribute("role"); 
    %>
    <div class="header">
        <div class="header-left">
            <div class="language-switch">
                <select onchange="changeLanguage(this.value)">
                    <option value="vi">Tiếng Việt</option>
                    <option value="en">English</option>        
                </select>
            </div>
            <div class="header-title">AgriRescue</div>
            <a href="index.jsp" class="home-btn">Home Page</a>
        </div>
        <div class="header-actions">
            <%
                if (user == null) {
            %>
            <a href="login.jsp" class="login">Login</a>
            <%
                } else {
            %>
            <span>Welcome, <%= user %>!</span>
            <a href="LogoutServlet" class="logout">Logout</a>
            <%
                }
            %>
        </div>
    </div>

    <div class="container mt-4">
        <h1>Chiến dịch của tôi</h1>
        <a href="#" id="btnAddCampaign" class="btn btn-success mb-3">Tạo chiến dịch mới</a>
        <%
            List<Campaign> campaigns = (List<Campaign>) request.getAttribute("campaigns");
            NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        %>
        <table class="table table-bordered table-hover">
            <thead class="table-dark">
                <tr>
                    <th>STT</th> 
                    <th>Tiêu đề</th>
                    <th>Mô tả chi tiết</th>
                    <th>Mục tiêu (VNĐ)</th>
                    <th>Thực Thu (VNĐ)</th>
                    <th>Ngày bắt đầu</th>
                    <th>Ngày kết thúc</th>
                    <th>Trạng thái</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <% if (campaigns != null && !campaigns.isEmpty()) {
                    for (int i = 0; i < campaigns.size(); i++) {
                        Campaign c = campaigns.get(i);
                %>
                <tr data-description="<%= c.getDescription() != null ? c.getDescription().replace("\"", "&quot;") : "" %>">
                    <td><%= i + 1 %></td> 
                    <td class="title-cell" data-full="<%= c.getTitle() %>">
                        <%= c.getTitle().length() > 30 ? c.getTitle().substring(0, 30) + "..." : c.getTitle() %>
                        <% if (c.getTitle().length() > 30) { %>
                        <a href="#" class="toggle-text">(Xem thêm)</a>
                        <% } %>
                    </td>

                    <td class="desc-cell" data-full="<%= c.getDescription() != null ? c.getDescription() : "" %>">
                        <%
                            String desc = c.getDescription() != null ? c.getDescription() : "";
                            if (desc.length() > 50) {
                                out.print(desc.substring(0, 50) + "...");
                        %>
                        <a href="#" class="toggle-text">(Xem thêm)</a>
                        <%
                            } else {
                                out.print(desc);
                            }
                        %>
                    </td>

                    <td><%= String.format("%,.2f", c.getGoalAmount()) %></td>
                    <td><%= String.format("%,.2f", c.getCurrentAmount()) %></td>
                    <td data-start="<%= c.getStartDate() != null ? new SimpleDateFormat("yyyy-MM-dd").format(c.getStartDate()) : "" %>">
                        <%= c.getStartDate() != null ? sdf.format(c.getStartDate()) : "-" %>
                    </td>
                    <td data-end="<%= c.getEndDate() != null ? new SimpleDateFormat("yyyy-MM-dd").format(c.getEndDate()) : "" %>">
                        <%= c.getEndDate() != null ? sdf.format(c.getEndDate()) : "-" %>
                    </td>

                    <%
                        String status = c.getStatus() != null ? c.getStatus().toLowerCase() : "";
                        String statusClass = "";
                        String statusText = "-";

                        if ("active".equals(status)) {
                            statusClass = "status-active";
                            statusText = "Hoạt động";
                        } else if ("completed".equals(status)) {
                            statusClass = "status-completed";
                            statusText = "Hoàn thành";
                        } else if ("cancelled".equals(status)) {
                            statusClass = "status-cancelled";
                            statusText = "Đã huỷ";
                        }
                    %>

                    <td data-status="<%= status %>">
                        <span class="status-indicator <%= statusClass %>"></span>
                        <%= statusText %>
                    </td>
                    <td>
                        <a href="#" class="btn btn-primary btn-sm btnEditCampaign" data-id="<%= c.getCampaignId() %>">Sửa</a>
                    </td>
                </tr>
                <% }
                } else { %>
                <tr>
                    <td colspan="9" class="text-center">Bạn chưa có chiến dịch nào.</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <!-- Modal Add/Edit Campaign -->
    <div class="modal fade" id="campaignModal" tabindex="-1" aria-labelledby="campaignModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <form id="campaignForm">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="campaignModalLabel">Thêm / Sửa chiến dịch</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" id="campaignId" name="campaignId" value="">
                        <div class="mb-3">
                            <label for="title" class="form-label">Tiêu đề</label>
                            <input type="text" class="form-control" id="title" name="title" required>
                        </div>
                        <div class="mb-3">
                            <label for="description" class="form-label">Mô tả</label>
                            <textarea class="form-control" id="description" name="description" rows="3"></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="goalAmount" class="form-label">Mục tiêu (VNĐ)</label>
                            <input type="number" class="form-control" id="goalAmount" name="goalAmount" required min="0" step="0.01">
                        </div>
                        <div class="mb-3">
                            <label for="startDate" class="form-label">Ngày bắt đầu</label>
                            <input type="date" class="form-control" id="startDate" name="startDate" required>
                        </div>
                        <div class="mb-3">
                            <label for="endDate" class="form-label">Ngày kết thúc</label>
                            <input type="date" class="form-control" id="endDate" name="endDate" required>
                        </div>
                        <div class="mb-3">
                            <label for="status" class="form-label">Trạng thái</label>
                            <select class="form-select" id="status" name="status" required>
                                <option value="" selected disabled>-- Chọn trạng thái --</option>
                                <option value="active">Đang hoạt động</option>
                                <option value="completed">Hoàn thành</option>
                                <option value="cancelled">Đã huỷ</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Lưu</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const rowsPerPage = 7;
            const table = document.querySelector("table.table-bordered");
            const tbody = table.querySelector("tbody");
            const rows = Array.from(tbody.querySelectorAll("tr"));
            const paginationContainer = document.createElement("div");
            paginationContainer.id = "pagination";
            paginationContainer.style.cursor = "pointer";
            paginationContainer.style.marginTop = "10px";
            paginationContainer.style.userSelect = "none";
            table.parentNode.insertBefore(paginationContainer, table.nextSibling);

            const pageCount = Math.ceil(rows.length / rowsPerPage);
            let currentPage = 1;

            function showPage(page) {
                currentPage = page;
                const start = (page - 1) * rowsPerPage;
                const end = start + rowsPerPage;

                rows.forEach((row, index) => {
                    row.style.display = (index >= start && index < end) ? "" : "none";
                });

                renderPagination();
            }

            function renderPagination() {
                paginationContainer.innerHTML = "";
                for (let i = 1; i <= pageCount; i++) {
                    const span = document.createElement("span");
                    span.textContent = i;
                    span.style.margin = "0 5px";
                    span.style.padding = "2px 6px";
                    span.style.border = "1px solid #007bff";
                    span.style.borderRadius = "4px";
                    span.style.color = (i === currentPage) ? "#fff" : "#007bff";
                    span.style.backgroundColor = (i === currentPage) ? "#007bff" : "transparent";
                    span.style.fontWeight = (i === currentPage) ? "bold" : "normal";

                    span.addEventListener("click", () => {
                        showPage(i);
                    });

                    paginationContainer.appendChild(span);
                }
            }

            showPage(1);
        });
    </script>

    <script>
        function changeLanguage(lang) {
            if (lang === 'vi') {
                // Header
                document.querySelector('.header-title').textContent = 'AgriRescue';
                document.querySelector('.home-btn').textContent = 'Trang chủ';
                if (document.querySelector('.header-actions a.login')) {
                    document.querySelector('.header-actions a.login').textContent = 'Đăng nhập';
                }
                if (document.querySelector('.header-actions span')) {
                    document.querySelector('.header-actions span').textContent = 'Chào mừng, ' + '<%= user != null ? user : "" %>' + '!';
                }
                if (document.querySelector('.header-actions a.logout')) {
                    document.querySelector('.header-actions a.logout').textContent = 'Đăng xuất';
                }

                // Main content
                document.querySelector('h2').textContent = 'Chiến dịch của tôi';
                document.querySelector('#btnAddCampaign').textContent = 'Tạo chiến dịch mới';

                // Table headers
                const ths = document.querySelectorAll('table thead th');
                if (ths.length >= 9) {
                    ths[0].textContent = 'STT';
                    ths[1].textContent = 'Tiêu đề';
                    ths[2].textContent = 'Mô tả chi tiết';
                    ths[3].textContent = 'Mục tiêu (VNĐ)';
                    ths[4].textContent = 'Thực Thu (VNĐ)';
                    ths[5].textContent = 'Ngày bắt đầu';
                    ths[6].textContent = 'Ngày kết thúc';
                    ths[7].textContent = 'Trạng thái';
                    ths[8].textContent = ''; // nút sửa
                }

                // Modal
                document.getElementById('campaignModalLabel').textContent = 'Thêm / Sửa chiến dịch';
                document.querySelector('label[for="title"]').textContent = 'Tiêu đề';
                document.querySelector('label[for="description"]').textContent = 'Mô tả';
                document.querySelector('label[for="goalAmount"]').textContent = 'Mục tiêu (VNĐ)';
                document.querySelector('label[for="startDate"]').textContent = 'Ngày bắt đầu';
                document.querySelector('label[for="endDate"]').textContent = 'Ngày kết thúc';
                document.querySelector('label[for="status"]').textContent = 'Trạng thái';

                const statusOptions = document.querySelectorAll('#status option');
                statusOptions[0].textContent = '-- Chọn trạng thái --';
                statusOptions[1].textContent = 'Đang hoạt động';
                statusOptions[2].textContent = 'Hoàn thành';
                statusOptions[3].textContent = 'Đã huỷ';

                document.querySelector('#campaignForm button[type="submit"]').textContent = 'Lưu';
                document.querySelector('#campaignForm button.btn-secondary').textContent = 'Đóng';

                // Button edit text
                document.querySelectorAll('.btnEditCampaign').forEach(btn => btn.textContent = 'Sửa');

                // Nếu không có chiến dịch, thay đổi text dòng thông báo
                const emptyRow = document.querySelector('tbody tr td.text-center');
                if (emptyRow) {
                    emptyRow.textContent = 'Bạn chưa có chiến dịch nào.';
                }

            } else {
                // English
                document.querySelector('.header-title').textContent = 'AgriRescue';
                document.querySelector('.home-btn').textContent = 'Home Page';
                if (document.querySelector('.header-actions a.login')) {
                    document.querySelector('.header-actions a.login').textContent = 'Login';
                }
                if (document.querySelector('.header-actions span')) {
                    document.querySelector('.header-actions span').textContent = 'Welcome, ' + '<%= user != null ? user : "" %>' + '!';
                }
                if (document.querySelector('.header-actions a.logout')) {
                    document.querySelector('.header-actions a.logout').textContent = 'Logout';
                }

                document.querySelector('h2').textContent = 'My Campaigns';
                document.querySelector('#btnAddCampaign').textContent = 'Create New Campaign';

                const ths = document.querySelectorAll('table thead th');
                if (ths.length >= 9) {
                    ths[0].textContent = 'No.';
                    ths[1].textContent = 'Title';
                    ths[2].textContent = 'Description';
                    ths[3].textContent = 'Goal (VND)';
                    ths[4].textContent = 'Current (VND)';
                    ths[5].textContent = 'Start Date';
                    ths[6].textContent = 'End Date';
                    ths[7].textContent = 'Status';
                    ths[8].textContent = '';
                }

                document.getElementById('campaignModalLabel').textContent = 'Add / Edit Campaign';
                document.querySelector('label[for="title"]').textContent = 'Title';
                document.querySelector('label[for="description"]').textContent = 'Description';
                document.querySelector('label[for="goalAmount"]').textContent = 'Goal (VND)';
                document.querySelector('label[for="startDate"]').textContent = 'Start Date';
                document.querySelector('label[for="endDate"]').textContent = 'End Date';
                document.querySelector('label[for="status"]').textContent = 'Status';

                const statusOptions = document.querySelectorAll('#status option');
                statusOptions[0].textContent = '-- Select status --';
                statusOptions[1].textContent = 'Active';
                statusOptions[2].textContent = 'Completed';
                statusOptions[3].textContent = 'Cancelled';

                document.querySelector('#campaignForm button[type="submit"]').textContent = 'Save';
                document.querySelector('#campaignForm button.btn-secondary').textContent = 'Close';

                document.querySelectorAll('.btnEditCampaign').forEach(btn => btn.textContent = 'Edit');

                const emptyRow = document.querySelector('tbody tr td.text-center');
                if (emptyRow) {
                    emptyRow.textContent = 'You have no campaigns yet.';
                }
            }
        }

        document.addEventListener('DOMContentLoaded', function () {
            const campaignModal = new bootstrap.Modal(document.getElementById('campaignModal'), {
                keyboard: false
            });

            document.getElementById('btnAddCampaign').addEventListener('click', () => {
                document.getElementById('campaignForm').reset();
                document.getElementById('campaignId').value = '';
                document.getElementById('campaignModalLabel').innerText = 'Tạo chiến dịch mới';
                campaignModal.show();
            });

            document.querySelectorAll('a.btnEditCampaign').forEach(button => {
                button.addEventListener('click', function (event) {
                    event.preventDefault();
                    const row = this.closest('tr');
                    const id = this.getAttribute('data-id');

                    const rawStartDate = row.cells[5].getAttribute('data-start');
                    const rawEndDate = row.cells[6].getAttribute('data-end');
                    document.getElementById('startDate').value = rawStartDate;
                    document.getElementById('endDate').value = rawEndDate;

                    const formattedStartDate = formatDateForInput(rawStartDate);
                    const formattedEndDate = formatDateForInput(rawEndDate);

                    console.log('Raw startDate:', rawStartDate);
                    console.log('Formatted startDate:', formattedStartDate);
                    console.log('Raw endDate:', rawEndDate);
                    console.log('Formatted endDate:', formattedEndDate);

                    document.getElementById('campaignModalLabel').innerText = 'Sửa chiến dịch';
                    document.getElementById('campaignId').value = id;
                    document.getElementById('description').value = row.getAttribute('data-description') || '';
                    document.getElementById('title').value = row.cells[1].getAttribute('data-full');
                    let goalAmountRaw = row.cells[3].innerText.trim().replace(/[^0-9.]/g, '');
                    document.getElementById('goalAmount').value = goalAmountRaw;
                    document.getElementById('status').value = row.cells[7].getAttribute('data-status');
                    campaignModal.show();
                });
            });

            document.getElementById('campaignForm').addEventListener('submit', function (event) {
                event.preventDefault();

                const title = document.getElementById('title').value.trim();
                const goalAmount = parseFloat(document.getElementById('goalAmount').value);
                const startDate = document.getElementById('startDate').value;
                const endDate = document.getElementById('endDate').value;
                const status = document.getElementById('status').value;

                if (!title || !goalAmount || !startDate || !endDate || !status) {
                    alert("Vui lòng điền đầy đủ các trường bắt buộc.");
                    return;
                }

                if (goalAmount <= 10) {
                    alert("Mục tiêu phải lớn hơn 10.");
                    return;
                }

                if (new Date(endDate) <= new Date(startDate)) {
                    alert("Ngày kết thúc phải sau ngày bắt đầu.");
                    return;
                }

                if (!status) {
                    alert("Vui lòng chọn trạng thái.");
                    return;
                }

                const formData = new FormData(this);
                const data = {};
                formData.forEach((value, key) => {
                    data[key] = value;
                });

                fetch('campaigns', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify(data)
                }).then(response => response.text())
                    .then(text => {
                        if (text === 'success') {
                            alert('Lưu chiến dịch thành công!');
                            location.reload();
                        } else {
                            alert('Lỗi khi lưu chiến dịch: ' + text);
                        }
                    }).catch(err => {
                        alert('Lỗi mạng hoặc server!');
                    });
            });

            function formatDateForInput(dateStr) {
                if (!dateStr || dateStr.trim() === '-' || dateStr.trim() === '') {
                    return '';
                }

                dateStr = dateStr.trim();
                dateStr = dateStr.replace(/\u00A0/g, ''); // non-breaking space

                const dmyRegex = /^(\d{1,2})\/(\d{1,2})\/(\d{4})$/;
                const matchDMY = dateStr.match(dmyRegex);
                if (matchDMY) {
                    const dd = matchDMY[1].padStart(2, '0');
                    const mm = matchDMY[2].padStart(2, '0');
                    const yyyy = matchDMY[3];
                    return `${yyyy}-${mm}-${dd}`;
                }

                const ymdRegex = /^(\d{4})-(\d{2})-(\d{2})$/;
                if (ymdRegex.test(dateStr)) {
                    return dateStr;
                }

                return '';
            }

            const startDateInput = document.getElementById('startDate');
            const endDateInput = document.getElementById('endDate');

            startDateInput.addEventListener('change', () => {
                if (startDateInput.value) {
                    endDateInput.min = startDateInput.value;
                    if (endDateInput.value && endDateInput.value < startDateInput.value) {
                        endDateInput.value = '';
                    }
                } else {
                    endDateInput.min = '';
                }
            });
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>