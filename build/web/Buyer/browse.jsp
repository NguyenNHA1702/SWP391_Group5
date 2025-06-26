<%-- 
    Document   : browse
    Created on : May 24, 2025, 9:45:40 PM
    Author     : admin
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Campaign" %>
<%@ page import="model.Product" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title> AgriRescue - Support Our Farmers </title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </head>
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
            backdrop-filter: blur(8px);
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
            border: 1px solid #4b5632;
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

        .footer {
            margin-top: 40px;
            padding: 20px;
            background-color: #a8d5ba;
            text-align: center;
            color: #2e7031;
            position: static;
        }
        .btn-green {
            background-color: #4caf50;
            color: white;
        }
        form.mb-3.d-flex.gap-2 {
            flex-wrap: wrap;
        }

        .input-group-text.bg-white {
            border-right: none;
        }

        .form-control {
            border-left: none;
        }

        .btn-success i {
            font-size: 1.1rem;
        }

        /* Hiệu ứng hover cho bảng */
        table.table-hover tbody tr:hover {
            background-color: #e9f5ff;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn-primary:hover, .btn-success:hover {
            filter: brightness(110%);
            transition: filter 0.3s ease;
        }

        .pagination .page-item .page-link {
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .pagination .page-item.active .page-link {
            background-color: #0d6efd !important;
            border-color: #0d6efd !important;
            color: white !important;
        }

        .pagination .page-item:hover:not(.active) .page-link {
            background-color: #cfe2ff;
            color: #0d6efd;
            cursor: pointer;
        }

        .table-responsive {
            border-radius: 6px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgb(0 0 0 / 0.1);
        }

        .card:hover {
            box-shadow: 0 8px 20px rgb(0 0 0 / 0.15);
            transition: box-shadow 0.3s ease;
        }

        .input-group-text i {
            color: #0d6efd;
        }

        .form-control:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 6px #0d6efd99;
        }

        form.mb-3.d-flex.flex-wrap.gap-2.align-items-center {
            gap: 12px;
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
                    <option value="en">English</option>
                    <option value="vi">Tiếng Việt</option>
                </select>
            </div>
            <div class="header-title">AgriRescue</div>
                 <%
        String ctx = request.getContextPath();
        String homeLink = (user != null) ? ctx + "/home" : ctx + "/index.jsp";
                %>
            <a href=<%= homeLink %> class="home-btn">Home Page</a>
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


    <%
        List<Campaign> campaigns = (List<Campaign>) request.getAttribute("campaigns");
        List<Product> products = (List<Product>) request.getAttribute("products");
        NumberFormat currencyFormat = NumberFormat.getInstance(new Locale("vi", "VN"));
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    %>

    <!-- 
     Hiển thị Chiến dịch hoạt động
     - Form tìm kiếm và sắp xếp chiến dịch theo tiêu đề và mục tiêu
     - Bảng danh sách các chiến dịch
     - Phân trang chiến dịch
    -->
    <div class="card shadow-sm mb-4">
        <div class="card-header bg-primary text-white d-flex align-items-center gap-2">
            <i class="bi bi-megaphone-fill fs-4"></i>
            <h2 id="campaignSectionTitle" class="m-0 fs-4" style="color: black;">Chiến dịch hoạt động</h2>

        </div>
        <div class="card-body">
            <!-- FORM LỌC CHIẾN DỊCH THEO TIÊU ĐỀ VÀ SẮP XẾP THEO MỤC TIÊU -->
            <form method="get" action="browse" class="mb-3 d-flex flex-wrap gap-2 align-items-center">
                <div class="input-group" style="max-width: 320px;">
                    <span class="input-group-text bg-white border-end-0"><i class="bi bi-search"></i></span>
                    <input type="text" name="campaignTitle" id="campaignTitleInput" class="form-control border-start-0"
                           placeholder="Tìm tiêu đề chiến dịch"
                           value="<%= request.getParameter("campaignTitle") != null ? request.getParameter("campaignTitle") : "" %>">
                </div>

                <select name="campaignSort" id="campaignSortSelect" class="form-select" style="max-width: 220px;">
                    <option value="">-- Sắp xếp theo mục tiêu --</option>
                    <option value="asc" <%= "asc".equals(request.getParameter("campaignSort")) ? "selected" : "" %>>Mục tiêu thấp đến cao</option>
                    <option value="desc" <%= "desc".equals(request.getParameter("campaignSort")) ? "selected" : "" %>>Mục tiêu cao đến thấp</option>
                </select>

                <button type="submit" id="campaignFilterButton" class="btn btn-primary d-flex align-items-center gap-1">
                    <i class="bi bi-filter"></i> <span id="campaignFilterButtonText">Tìm</span>
                </button>
            </form>


            <div class="table-responsive">
                <table class="table table-hover align-middle" id="campaignTable">
                    <thead class="table-primary">
                        <tr>
                            <th>Tiêu đề chiến dịch</th>
                            <th>Mô tả</th>
                            <th>Mục tiêu (VND)</th>
                            <th>Đã huy động (VND)</th>
                            <th>Ngày bắt đầu</th>
                            <th>Ngày kết thúc</th>
                        </tr>
                    </thead>
                    <tbody id="campaignTbody">
                        <%-- Hiển thị từng chiến dịch từ danh sách campaigns --%>
                        <% if (campaigns != null) {
            for (Campaign c : campaigns) { %>
                        <tr class="campaign-row">
                            <td><%= c.getTitle() %></td>
                            <td><%= c.getDescription() %></td>
                            <td><%= currencyFormat.format(c.getGoalAmount()) %></td>
                            <td><%= currencyFormat.format(c.getCurrentAmount()) %></td>
                            <td><%= sdf.format(c.getStartDate()) %></td>
                            <td><%= sdf.format(c.getEndDate()) %></td>
                        </tr>
                        <%  } } %>
                    </tbody>
                </table>
            </div>

            <nav>
                <ul class="pagination justify-content-center" id="campaignPagination"></ul>
            </nav>
        </div>
    </div>

    <!-- 
          Hiển thị Sản phẩm có sẵn
         - Form tìm kiếm và sắp xếp sản phẩm
         - Bảng danh sách các sản phẩm
         - Phân trang sản phẩm -->
    <!-- Products -->
    <div class="card shadow-sm mb-4">
        <div class="card-header bg-success text-white d-flex align-items-center gap-2">
            <i class="bi bi-basket3-fill fs-4"></i>
            <h2 id="productSectionTitle" class="m-0 fs-4" style="color: black;">Sản phẩm có sẵn</h2>
        </div>

        <div class="card-body">
            <form method="get" action="browse" class="mb-3 d-flex flex-wrap gap-2 align-items-center">

                <div style="max-width: 320px;" class="input-group">
                    <span class="input-group-text bg-white border-end-0"><i class="bi bi-search"></i></span>
                    <input type="text" name="productName" id="productNameInput" class="form-control border-start-0" placeholder="Tìm tên sản phẩm"
                           value="<%= request.getParameter("productName") != null ? request.getParameter("productName") : "" %>">
                </div>

                <select name="productSort" id="productSortSelect" class="form-select" style="max-width: 220px;">
                    <option value="">-- Sắp xếp theo giá --</option>
                    <option value="asc" <%= "asc".equals(request.getParameter("productSort")) ? "selected" : "" %>>Giá thấp đến cao</option>
                    <option value="desc" <%= "desc".equals(request.getParameter("productSort")) ? "selected" : "" %>>Giá cao đến thấp</option>
                </select>

                <button type="submit" id="productFilterButton" class="btn btn-success d-flex align-items-center gap-1">
                    <i class="bi bi-filter"></i> <span id="productFilterButtonText">Tìm</span>
                </button>

            </form>


            <div class="table-responsive">
                <table class="table table-hover align-middle" id="productTable">
                    <thead class="table-success">
                        <tr>
                            <th>Tên sản phẩm</th>
                            <th>Mô tả</th>
                            <th>Giá (VND)</th>
                            <th>Số lượng</th>
                        </tr>
                    </thead>
                    <%-- Hiển thị từng sản phẩm từ danh sách products --%>
                    <tbody id="productTbody">
                        <% if (products != null) {
            for (Product p : products) { %>
                        <tr class="product-row">
                            <td><%= p.getName() %></td>
                            <td><%= p.getDescription() %></td>
                            <td><%= currencyFormat.format(p.getPrice()) %></td>
                            <td><%= p.getQuantity() %>kg</td>
                        </tr>
                        <%  } } %>
                    </tbody>
                </table>
            </div>
            <!-- PHÂN TRANG SẢN PHẨM -->
            <nav>
                <ul class="pagination justify-content-center" id="productPagination"></ul>
            </nav>
        </div>
    </div>


    <script>
    

        const rowsPerPage = 6;
        function paginateTableWithEllipsis(tableId, rowClass, paginationId) {
            const rows = Array.from(document.querySelectorAll('#' + tableId + ' tbody tr.' + rowClass));
            const pagination = document.getElementById(paginationId);
            let currentPage = 1;
            const totalPages = Math.ceil(rows.length / rowsPerPage);

            function createPageItem(page, text = null, disabled = false, active = false) {
                let li = document.createElement('li');
                li.classList.add('page-item');
                if (disabled)
                    li.classList.add('disabled');
                if (active)
                    li.classList.add('active');

                let a = document.createElement('a');
                a.classList.add('page-link');
                a.href = "#";
                a.textContent = text || page;

                if (!disabled && !active) {
                    a.addEventListener('click', function (e) {
                        e.preventDefault();
                        showPage(page);
                    });
                }

                li.appendChild(a);
                return li;
            }

            function getPagesToShow(current, total) {
                const delta = 2;
                const range = [];
                const pages = [];
                let l;

                for (let i = 1; i <= total; i++) {
                    if (i === 1 || i === total || (i >= current - delta && i <= current + delta)) {
                        range.push(i);
                    }
                }
                for (let i of range) {
                    if (l) {
                        if (i - l === 2) {
                            pages.push(l + 1);
                        } else if (i - l !== 1) {
                            pages.push('...');
                        }
                    }
                    pages.push(i);
                    l = i;
                }
                return pages;
            }

            function showPage(page) {
                currentPage = page;
                rows.forEach(r => r.style.display = 'none');

                let start = (page - 1) * rowsPerPage;
                let end = start + rowsPerPage;
                rows.slice(start, end).forEach(r => r.style.display = '');
                pagination.innerHTML = '';

                if (totalPages <= 1)
                    return;
                pagination.appendChild(createPageItem(page - 1, 'Prev', page === 1));

                const pagesToShow = getPagesToShow(page, totalPages);
                pagesToShow.forEach(p => {
                    if (p === '...') {
                        let li = document.createElement('li');
                        li.classList.add('page-item', 'disabled');
                        li.innerHTML = `<a class="page-link">...</a>`;
                        pagination.appendChild(li);
                    } else {
                        pagination.appendChild(createPageItem(p, null, false, p === page));
                    }
                });

                pagination.appendChild(createPageItem(page + 1, 'Next', page === totalPages));
            }

            showPage(1);
        }

        paginateTableWithEllipsis('campaignTable', 'campaign-row', 'campaignPagination');
        paginateTableWithEllipsis('productTable', 'product-row', 'productPagination');

    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
