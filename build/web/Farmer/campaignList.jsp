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
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <!-- Thêm link CSS Bootstrap và Bootstrap Icons trong <head> của trang JSP -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f9f9f5;
                color: #2e3a23;
                margin: 0;
                padding: 0 20px 40px 20px;
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: rgba(34, 197, 94, 0.9);
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
            .status-active {
                color: #198754;
                font-weight: 600;
            }
            .status-completed {
                color: #0d6efd;
                font-weight: 600;
            }
            .status-cancelled {
                color: #dc3545;
                font-weight: 600;
            }
            .btnEditCampaign {
                text-decoration: none;
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
                <%
       String ctx = request.getContextPath();
       String homeLink = (user != null) ? ctx + "/home" : ctx + "/index.jsp";
                %>
                <a href="<%= homeLink %>" class="home-btn">Home Page</a>
            </div>
            <div class="header-actions">
                <%
                    if (user == null) {
                %>
                <a href="login.jsp" class="login inline-flex items-center gap-2 bg-yellow-400 text-green-900 font-semibold px-4 py-2 rounded-lg hover:bg-yellow-500 shadow-md transition-all duration-200">
                    <i class="bi bi-box-arrow-in-right"></i> Login
                </a>
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
            <a href="<%= request.getContextPath() %>/campaignStatusDashboard" class="btn btn-info mb-3 ms-2">Campaign Status Dashboard</a>

            <!-- Form tìm kiếm với icon Bootstrap -->
            <form method="get" action="campaigns" class="input-group mb-4 w-50">
                <span class="input-group-text" id="search-icon">
                    <i class="bi bi-search"></i>
                </span>
                <input 
                    type="text" 
                    name="title" 
                    class="form-control" 
                    placeholder="Nhập tiêu đề chiến dịch" 
                    aria-label="Nhập tiêu đề chiến dịch"
                    aria-describedby="search-icon"
                    >
                <button type="submit" class="btn btn-primary">Tìm kiếm</button>
            </form>

            <%
                 // Lấy danh sách chiến dịch từ request attribute
                // Format số tiền và ngày tháng cho hiển thị
                List<Campaign> campaigns = (List<Campaign>) request.getAttribute("campaigns");
                NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            %>

            <!-- Bảng hiển thị danh sách chiến dịch -->
            <table class="table table-bordered table-hover">
                <thead class="table-dark">
                    <tr>
                        <th style="width:3%;">STT</th> 
                        <th style="width:20%;">Tiêu đề</th>
                        <th style="width:20%;">Mô tả chi tiết</th>
                        <th style="width:10%;">Mục tiêu (VNĐ)</th>
                        <th style="width:10%;">Thực Thu (VNĐ)</th>
                        <th style="width:10%;">Ngày bắt đầu</th>
                        <th style="width:10%;">Ngày kết thúc</th>
                        <th style="width:17%;">Trạng thái</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        // Duyệt qua từng chiến dịch để hiển thị thông tin lên bảng
                        // Bao gồm trạng thái chiến dịch, điều kiện cho phép sửa đổi
                        if (campaigns != null && !campaigns.isEmpty()) {
                            for (int i = 0; i < campaigns.size(); i++) {
                                Campaign c = campaigns.get(i);
                                // Xác định trạng thái chiến dịch và phân loại CSS để hiển thị màu sắc phù hợp
                                String status = c.getStatus() != null ? c.getStatus().toLowerCase() : "";
                                String statusClass = "";
                                String statusText = "...";

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
                                 // Lấy thông tin quyền chỉnh sửa chiến dịch (do servlet đặt vào request attribute)
                                Boolean canEdit = (Boolean) request.getAttribute("canEdit_" + c.getCampaignId());
                                if (canEdit == null) canEdit = false;
                    %>
                    <!-- Hiển thị từng dòng chiến dịch -->
                    <tr data-description="<%= c.getDescription() != null ? c.getDescription().replace("\"", "&quot;") : "" %>">
                        <td><%= i + 1 %></td>
                        <td class="title-cell" data-full="<%= c.getTitle() %>">
                            <%= c.getTitle().length() > 30 ? c.getTitle().substring(0, 30) + "..." : c.getTitle() %>
                            <% if (c.getTitle().length() > 30) { %>
                            <a href="#" class="toggle-text"></a>
                            <% } %>
                        </td>

                        <td class="desc-cell" data-full="<%= c.getDescription() != null ? c.getDescription() : "" %>">
                            <%
                                String desc = c.getDescription() != null ? c.getDescription() : "";
                                if (desc.length() > 50) {
                                    out.print(desc.substring(0, 50) + "...");
                            %>
                            <a href="#" class="toggle-text"></a>
                            <%
                                } else {
                                    out.print(desc);
                                }
                            %>
                        </td>

                        <td><%= String.format("%,.0f", c.getGoalAmount()) %></td>
                        <td><%= String.format("%,.0f", c.getCurrentAmount()) %></td>
                        <td data-start="<%= c.getStartDate() != null ? new SimpleDateFormat("yyyy-MM-dd").format(c.getStartDate()) : "" %>">
                            <%= c.getStartDate() != null ? new SimpleDateFormat("dd/MM/yyyy").format(c.getStartDate()) : "-" %>
                        </td>
                        <td data-end="<%= c.getEndDate() != null ? new SimpleDateFormat("yyyy-MM-dd").format(c.getEndDate()) : "" %>">
                            <%= c.getEndDate() != null ? new SimpleDateFormat("dd/MM/yyyy").format(c.getEndDate()) : "-" %>
                        </td>

                        <td data-status="<%= status %>">
                            <span class="status-indicator <%= statusClass %>"><%= statusText %></span>
                        </td>

                        <td>
                            <% if (canEdit) { %>
                            <a href="#" class="btnEditCampaign btn btn-warning btn-sm" data-id="<%= c.getCampaignId() %>">Sửa</a>
                            <% } else { %>
                            <span>Không được sửa</span>
                            <% } %>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <!-- Thông báo nếu không có chiến dịch nào -->
                    <tr>
                        <td colspan="9" class="text-center">Bạn chưa có chiến dịch nào.</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>

        <!-- Form sửa và thêm Campaign -->
        <div class="modal fade" id="campaignModal" tabindex="-1" aria-labelledby="campaignModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <form id="campaignForm">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="campaignModalLabel" data-mode="">...</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" id="campaignId" name="campaignId" value="">
                            <div class="mb-3">
                                <label for="title" class="form-label">Tiêu đề*</label>
                                <input type="text" class="form-control" id="title" name="title" required>
                            </div>
                            <div class="mb-3">
                                <label for="description" class="form-label">Mô tả*</label>
                                <textarea class="form-control" id="description" name="description" rows="3"></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="goalAmount" class="form-label">Mục tiêu (VNĐ)*</label>
                                <input type="number" class="form-control" id="goalAmount" name="goalAmount" required min="0" step="0.01">
                            </div>
                            <div class="mb-3">
                                <label for="startDate" class="form-label">Ngày bắt đầu*</label>
                                <input type="date" class="form-control" id="startDate" name="startDate" required>
                            </div>
                            <div class="mb-3">
                                <label for="endDate" class="form-label">Ngày kết thúc*</label>
                                <input type="date" class="form-control" id="endDate" name="endDate" required>
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
            // Đảm bảo script chỉ chạy sau khi toàn bộ DOM đã được load
            // Phân trang 7 dữu liệu trong 1 trang
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
                // Hàm tạo các nút phân trang và xử lý sự kiện khi click
                function renderPagination() {
                    // Xóa nội dung phân trang cũ
                    paginationContainer.innerHTML = "";
                    for (let i = 1; i <= pageCount; i++) {
                        const span = document.createElement("span");
                        span.textContent = i;
                        span.style.margin = "0 5px";
                        span.style.padding = "2px 6px";
                        span.style.border = "1px solid #007bff";
                        span.style.borderRadius = "4px";
                        // Đánh dấu trang hiện tại
                        span.style.color = (i === currentPage) ? "#fff" : "#007bff";
                        span.style.backgroundColor = (i === currentPage) ? "#007bff" : "transparent";
                        span.style.fontWeight = (i === currentPage) ? "bold" : "normal";

                        span.addEventListener("click", () => {
                            showPage(i);
                        });

                        paginationContainer.appendChild(span);// Thêm nút vào container
                    }
                }

                showPage(1);
            });
        </script>

        <script>
            let currentLanguage = 'vi';
            const translations = {
                vi: {
                    headerTitle: 'AgriRescue',
                    homeBtn: 'Trang chủ',
                    login: 'Đăng nhập',
                    welcome: user => `Chào mừng, ${user}!`,
                    logout: 'Đăng xuất',
                    pageTitle: 'Chiến dịch của tôi',
                    addCampaignBtn: 'Tạo chiến dịch mới',
                    tableHeaders: [
                        'STT',
                        'Tiêu đề',
                        'Mô tả chi tiết',
                        'Mục tiêu (VNĐ)',
                        'Thực Thu (VNĐ)',
                        'Ngày bắt đầu',
                        'Ngày kết thúc',
                        'Trạng thái',
                        ''
                    ],
                    modalTitleAdd: 'Tạo chiến dịch mới',
                    modalTitleEdit: 'Sửa chiến dịch',
                    formLabels: {
                        title: 'Tiêu đề',
                        description: 'Mô tả',
                        goalAmount: 'Mục tiêu (VNĐ)',
                        startDate: 'Ngày bắt đầu',
                        endDate: 'Ngày kết thúc',
                    },
                    submitBtn: 'Lưu',
                    closeBtn: 'Đóng',
                    editBtn: 'Sửa',
                    emptyMessage: 'Bạn chưa có chiến dịch nào.'
                },
                en: {
                    headerTitle: 'AgriRescue',
                    homeBtn: 'Home Page',
                    login: 'Login',
                    welcome: user => `Welcome, ${user}!`,
                    logout: 'Logout',
                    pageTitle: 'My Campaigns',
                    addCampaignBtn: 'Create New Campaign',
                    tableHeaders: [
                        'No.',
                        'Title',
                        'Description',
                        'Goal (VND)',
                        'Current (VND)',
                        'Start Date',
                        'End Date',
                        'Status',
                        ''
                    ],
                    modalTitleAdd: 'Create New Campaign',
                    modalTitleEdit: 'Edit Campaign',
                    formLabels: {
                        title: 'Title',
                        description: 'Description',
                        goalAmount: 'Goal (VND)',
                        startDate: 'Start Date',
                        endDate: 'End Date',
                    },
                    submitBtn: 'Save',
                    closeBtn: 'Close',
                    editBtn: 'Edit',
                    emptyMessage: 'You have no campaigns yet.'
                }
            };


            // Hàm chuyển đổi chuỗi tiền  sang số
            function parseCurrencyToNumber(str) {
                if (!str)
                    return NaN;
                str = str.trim().replace(/[^\d.,]/g, '');
                str = str.replace(/,/g, '');
                return parseFloat(str);
            }
            // Khởi tạo modal Bootstrap cho chiến dịch
            document.addEventListener('DOMContentLoaded', function () {
                const campaignModal = new bootstrap.Modal(document.getElementById('campaignModal'), {
                    keyboard: false
                });
                // Xử lý khi nhấn nút "Tạo chiến dịch mới"
                document.getElementById('btnAddCampaign').addEventListener('click', () => {
                    document.getElementById('campaignForm').reset();
                    document.getElementById('campaignId').value = '';
                    const modalLabel = document.getElementById('campaignModalLabel');
                    modalLabel.setAttribute('data-mode', 'add');
                    modalLabel.textContent = translations[currentLanguage].modalTitleAdd;

                    campaignModal.show();
                });


                // Xử lý nút sửa
                document.querySelectorAll('a.btnEditCampaign').forEach(button => {
                    button.addEventListener('click', function (event) {
                        event.preventDefault();

                        try {
                            const row = this.closest('tr');
                            const id = this.getAttribute('data-id');

                            const rawStartDate = row.cells[5].getAttribute('data-start');
                            const rawEndDate = row.cells[6].getAttribute('data-end');
                            const formattedStartDate = formatDateForInput(rawStartDate);
                            const formattedEndDate = formatDateForInput(rawEndDate);

                            let goalAmountText = row.cells[3].innerText || "";
                            const goalAmount = parseCurrencyToNumber(goalAmountText);

                            if (isNaN(goalAmount)) {
                                alert('Không thể đọc giá trị Mục tiêu (VNĐ). Không thể sửa chiến dịch này.');
                                return;
                            }
                            // Đổ dữ liệu vào form modal
                            document.getElementById('startDate').value = formattedStartDate || '';
                            document.getElementById('endDate').value = formattedEndDate || '';
                            const modalLabel = document.getElementById('campaignModalLabel');
                            modalLabel.setAttribute('data-mode', 'edit');
                            modalLabel.textContent = translations[currentLanguage].modalTitleEdit;
                            document.getElementById('campaignId').value = id || '';
                            document.getElementById('description').value = row.getAttribute('data-description') || '';
                            document.getElementById('title').value = row.cells[1].getAttribute('data-full') || '';
                            document.getElementById('goalAmount').value = goalAmount;

                            campaignModal.show();
                        } catch (error) {
                            console.error('Lỗi khi mở modal sửa chiến dịch:', error);
                            alert('Có lỗi xảy ra khi mở modal sửa chiến dịch. Vui lòng thử lại.');
                        }
                    });
                });

                // Xử lý sự kiện submit form chiến dịch
                document.getElementById('campaignForm').addEventListener('submit', function (event) {
                    event.preventDefault();

                    const title = document.getElementById('title').value.trim();
                    const description = document.getElementById('description').value.trim();
                    const goalAmount = parseFloat(document.getElementById('goalAmount').value);
                    const startDate = document.getElementById('startDate').value;
                    const endDate = document.getElementById('endDate').value;
                    // Kiểm tra các trường bắt buộc
                    if (!title || !goalAmount || !startDate || !endDate || !description) {
                        alert("Vui lòng điền đầy đủ các trường bắt buộc.");
                        return;
                    }

                    if (goalAmount <= 100000) {
                        alert("Mục tiêu phải lớn hơn 100000");
                        return;
                    }

                    if (new Date(endDate) <= new Date(startDate)) {
                        alert("Ngày kết thúc phải sau ngày bắt đầu.");
                        return;
                    }

                    // Tạo object dữ liệu từ form
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
                // Hàm chuyển đổi định dạng ngày (dd/mm/yyyy -> yyyy-mm-dd)
                function formatDateForInput(dateStr) {
                    if (!dateStr || dateStr.trim() === '-' || dateStr.trim() === '') {
                        return '';
                    }
                    dateStr = dateStr.trim();
                    dateStr = dateStr.replace(/\u00A0/g, '');

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
                                // Đảm bảo ngày kết thúc không nhỏ hơn ngày bắt đầu
                                const startDateInput = document.getElementById('startDate');
                                const endDateInput = document.getElementById('endDate');

                                startDateInput.addEventListener('change', () => {
                                    if (startDateInput.value) {
                                        endDateInput.min = startDateInput.value; // Thiết lập min cho ngày kết thúc
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

