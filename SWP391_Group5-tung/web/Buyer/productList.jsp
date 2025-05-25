<%-- 
    Document   : productList
    Created on : May 24, 2025, 10:49:39 PM
    Author     : admin
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Campaign" %>
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

    </head>
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
        .header-left {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .header-title {
            font-size: 24px;
            font-weight: bold;
            color: #fff;
        }
        .language-switch select {
            padding: 5px;
            border-radius: 5px;
            background-color: #fff;
            border: 1px solid #ccc;
            cursor: pointer;
        }
        .home-btn {
            color: #fff;
            text-decoration: none;
            padding: 8px 15px;
            border-radius: 5px;
            background-color: #1b5e20;
            transition: background-color 0.3s;
        }
        .home-btn:hover {
            background-color: #124116;
        }
        .header-actions {
            display: flex;
            gap: 10px;
        }
        .header-actions a, .header-actions span {
            color: #fff;
            text-decoration: none;
            padding: 8px 15px;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .header-actions a.login {
            background-color: #ffeb3b;
            color: #2e7d32;
        }
        .header-actions a.login:hover {
            background-color: #fdd835;
        }
        .header-actions a.signup {
            background-color: #1b5e20;
        }
        .header-actions a.signup:hover {
            background-color: #124116;
        }
        .header-actions a.logout {
            background-color: #d32f2f;
        }
        .header-actions a.logout:hover {
            background-color: #b71c1c;
        }
        .content {
            padding: 20px;
            min-height: calc(100vh - 120px);
            background-color: rgba(255, 255, 255, 0.8);
            margin: 10px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .content h1 {
            color: #2e7d32;
            text-align: center;
        }
        .content p {
            color: #555;
            line-height: 1.6;
            text-align: center;
        }
        .banner {
            text-align: center;
            margin: 20px 0;
        }
        .banner img {
            max-width: 100%;
            border-radius: 10px;
        }
        .features {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
            margin: 20px 0;
        }
        .feature-card {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            width: 200px;
            text-align: center;
            transition: transform 0.3s;
            cursor: pointer;
        }
        .feature-card:hover {
            transform: translateY(-5px);
        }
        .feature-card h3 {
            color: #2e7d32;
            margin: 10px 0;
        }
        .feature-card p {
            color: #777;
            font-size: 14px;
        }
        .footer {
            position: fixed;
            bottom: 0;
            width: 100%;
            display: flex;
            justify-content: space-between;
            padding: 10px 20px;
            background-color: rgba(46, 125, 50, 0.8);
            color: #fff;
        }
        .footer .contact-help {
            font-size: 14px;
        }
        .footer .faq {
            font-size: 14px;
            display: flex;
            align-items: center;
        }
        .faq-circle {
            width: 20px;
            height: 20px;
            background-color: #fff;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-left: 10px;
            color: #2e7d32;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .faq-circle:hover {
            background-color: #ffeb3b;
        }
        table.table-bordered,
        table.table-bordered th,
        table.table-bordered td {
            border: 2px solid #7b9a44;
        }

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
    </style>
</head>
<body>
    <%
    String user = (String) session.getAttribute("user_name");
    String role = (String) session.getAttribute("user_role"); 
    if (user == null || !"buyer".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }
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
            <a href="buyer-dashboard.jsp" class="home-btn">Home Page</a>
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


    <%
            List<Product> products = (List<Product>) request.getAttribute("products");
            NumberFormat currencyFormat = NumberFormat.getInstance(new Locale("vi", "VN"));
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    %>

    <h2>Danh sách sản phẩm </h2>

    <div class="table-responsive">
        <form method="get" action="productList" class="mb-3 d-flex gap-2">
            <input type="text" name="name" placeholder="Nhập tên sản phẩm"
                   value="<%= request.getParameter("name") != null ? request.getParameter("name") : "" %>">

            <select name="sort">
                <option value="">-- Sắp xếp theo giá --</option>
                <option value="desc" <%= "desc".equals(request.getParameter("sort")) ? "selected" : "" %>>Giá cao đến thấp</option>
                <option value="asc" <%= "asc".equals(request.getParameter("sort")) ? "selected" : "" %>>Giá thấp đến cao</option>
            </select>

            <button type="submit">Tìm kiếm</button>
        </form>


        <table id="productTable" class="table table-bordered table-striped">
            <thead class="table-success">
                <tr>
                    <th style="width:5%;">ID</th>
                    <th style="width:30%;">Tên sản phẩm</th>
                    <th style="width:15%;">Giá (VNĐ)</th>
                    <th style="width:10%;">Số lượng còn</th>
                    <th style="width:15%;">Ngôn ngữ</th>
                    <th style="width:15%;">Ngày tạo</th>
                    <th style="width:10%;">Chi tiết</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (products != null && !products.isEmpty()) {
                        for (Product p : products) {
                %>
                <tr class="product-row">
                    <td><%= p.getProductId() %></td>
                    <td><%= p.getName() %></td>
                    <td><%= currencyFormat.format(p.getPrice()) %></td>
                    <td><%= p.getQuantity() %></td>
                    <td><%= p.getLanguage() %></td>
                    <td><%= sdf.format(p.getCreatedAt()) %></td>
                    <td><a href="productDetail?id=<%= p.getProductId() %>" class="btn-detail">Xem chi tiết</a></td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr><td colspan="7">Không có sản phẩm nào</td></tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>

    <nav aria-label="Page navigation">
        <ul id="productPagination" class="pagination"></ul>
    </nav>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>

                    function changeLanguage(lang) {
                        if (lang === 'vi') {
                            document.querySelector('.home-btn').textContent = 'Trang chủ';
                            document.querySelector('.header-title').textContent = 'AgriRescue';

                            if (document.querySelector('.header-actions a.login')) {
                                document.querySelector('.header-actions a.login').textContent = 'Đăng nhập';
                            }
                            if (document.querySelector('.header-actions a.logout')) {
                                document.querySelector('.header-actions a.logout').textContent = 'Đăng xuất';
                            }
                            if (document.querySelector('.header-actions span')) {
                                const userName = '<%= user != null ? user : "" %>';
                                document.querySelector('.header-actions span').textContent = 'Chào mừng, ' + userName + '!';
                            }

                            document.querySelector('h2').textContent = 'Danh sách sản phẩm';

                            const headers = document.querySelectorAll('#productTable thead th');
                            if (headers.length >= 7) {
                                headers[0].textContent = 'ID';
                                headers[1].textContent = 'Tên sản phẩm';
                                headers[2].textContent = 'Giá (VNĐ)';
                                headers[3].textContent = 'Số lượng còn';
                                headers[4].textContent = 'Ngôn ngữ';
                                headers[5].textContent = 'Ngày tạo';
                                headers[6].textContent = 'Chi tiết';
                            }

                            document.querySelectorAll('.btn-detail').forEach(btn => {
                                btn.textContent = 'Xem chi tiết';
                            });

                            const noProductRow = document.querySelector('tbody tr td[colspan="7"]');
                            if (noProductRow) {
                                noProductRow.textContent = 'Không có sản phẩm nào';
                            }

                        } else {
                            document.querySelector('.home-btn').textContent = 'Home Page';
                            document.querySelector('.header-title').textContent = 'AgriRescue';

                            if (document.querySelector('.header-actions a.login')) {
                                document.querySelector('.header-actions a.login').textContent = 'Login';
                            }
                            if (document.querySelector('.header-actions a.logout')) {
                                document.querySelector('.header-actions a.logout').textContent = 'Logout';
                            }
                            if (document.querySelector('.header-actions span')) {
                                const userName = '<%= user != null ? user : "" %>';
                                document.querySelector('.header-actions span').textContent = 'Welcome, ' + userName + '!';
                            }

                            document.querySelector('h2').textContent = 'Product List';

                            const headers = document.querySelectorAll('#productTable thead th');
                            if (headers.length >= 7) {
                                headers[0].textContent = 'ID';
                                headers[1].textContent = 'Product Name';
                                headers[2].textContent = 'Price (VND)';
                                headers[3].textContent = 'Quantity Left';
                                headers[4].textContent = 'Language';
                                headers[5].textContent = 'Created At';
                                headers[6].textContent = 'Detail';
                            }

                            document.querySelectorAll('.btn-detail').forEach(btn => {
                                btn.textContent = 'View Detail';
                            });

                            const noProductRow = document.querySelector('tbody tr td[colspan="7"]');
                            if (noProductRow) {
                                noProductRow.textContent = 'No products available';
                            }
                        }
                    }

                    // Optional: Load saved language from localStorage
                    window.onload = function () {
                        const savedLang = localStorage.getItem('lang') || 'en';
                        document.querySelector('.language-switch select').value = savedLang;
                        changeLanguage(savedLang);
                    };

                    // Save language choice to localStorage
                    document.querySelector('.language-switch select').addEventListener('change', function () {
                        localStorage.setItem('lang', this.value);
                    });

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

                    paginateTableWithEllipsis('productTable', 'product-row', 'productPagination');
    </script>

</body>
</html>

