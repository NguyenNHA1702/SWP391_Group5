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


    <%
        List<Campaign> campaigns = (List<Campaign>) request.getAttribute("campaigns");
        List<Product> products = (List<Product>) request.getAttribute("products");
        NumberFormat currencyFormat = NumberFormat.getInstance(new Locale("vi", "VN"));
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    %>

    <div class="container mt-4">
        <div class="row">
            <!-- Campaigns -->
            <div class="col-12 mb-4">
                <h2 id="campaignTitle">Chiến dịch hoạt động</h2>

                <div class="table-container">
                    <table class="table table-bordered table-striped" id="campaignTable">
                        <thead class="table-success">
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

            <!-- Products -->
            <div class="">
                <h2 id="productTitle">Sản phẩm có sẵn</h2>
                <div class="table-container">
                    <table class="table table-bordered table-striped" id="productTable">
                        <thead class="table-success">
                            <tr>
                                <th>Tên sản phẩm</th>
                                <th>Mô tả</th>
                                <th>Giá (VND)</th>
                                <th>Số lượng</th>
                            </tr>
                        </thead>
                        <tbody id="productTbody">
                            <% if (products != null) {
                        for (Product p : products) { %>
                            <tr class="product-row">
                                <td><%= p.getName() %></td>
                                <td><%= p.getDescription() %></td>
                                <td><%= currencyFormat.format(p.getPrice()) %></td>
                                <td><%= p.getQuantity() %></td>
                            </tr>
                            <%  } } %>
                        </tbody>
                    </table>
                </div>
                <nav>
                    <ul class="pagination justify-content-center" id="productPagination"></ul>
                </nav>
            </div>
        </div>
    </div>

    <script>

        function changeLanguage(lang) {
            // Header
            const homeBtn = document.querySelector('.home-btn');
            const headerTitle = document.querySelector('.header-title');
            const loginLink = document.querySelector('.header-actions a.login');
            const logoutLink = document.querySelector('.header-actions a.logout');
            const welcomeSpan = document.querySelector('.header-actions span');

            if (lang === 'vi') {
                if (homeBtn)
                    homeBtn.textContent = 'Trang chủ';
                if (headerTitle)
                    headerTitle.textContent = 'AgriRescue';
                if (loginLink)
                    loginLink.textContent = 'Đăng nhập';
                if (logoutLink)
                    logoutLink.textContent = 'Đăng xuất';
                if (welcomeSpan) {
                    const userName = '<%= user != null ? user : "" %>';
                    welcomeSpan.textContent = 'Chào mừng, ' + userName + '!';
                }

                const campaignTitle = document.getElementById('campaignTitle');
                const productTitle = document.getElementById('productTitle');

                if (lang === 'vi') {
                    if (campaignTitle)
                        campaignTitle.textContent = 'Chiến dịch hoạt động';
                    if (productTitle)
                        productTitle.textContent = 'Sản phẩm có sẵn';
                } else {
                    if (campaignTitle)
                        campaignTitle.textContent = 'Active Campaigns';
                    if (productTitle)
                        productTitle.textContent = 'Available Products';
                }

                // Campaign table headers
                const campaignHeaders = document.querySelectorAll('#campaignTable thead th');
                if (campaignHeaders.length === 6) {
                    campaignHeaders[0].textContent = 'Tiêu đề chiến dịch';
                    campaignHeaders[1].textContent = 'Mô tả';
                    campaignHeaders[2].textContent = 'Mục tiêu (VND)';
                    campaignHeaders[3].textContent = 'Đã huy động (VND)';
                    campaignHeaders[4].textContent = 'Ngày bắt đầu';
                    campaignHeaders[5].textContent = 'Ngày kết thúc';
                }

                // Product table headers
                const productHeaders = document.querySelectorAll('#productTable thead th');
                if (productHeaders.length === 4) {
                    productHeaders[0].textContent = 'Tên sản phẩm';
                    productHeaders[1].textContent = 'Mô tả';
                    productHeaders[2].textContent = 'Giá (VND)';
                    productHeaders[3].textContent = 'Số lượng';
                }

            } else {
                if (homeBtn)
                    homeBtn.textContent = 'Home Page';
                if (headerTitle)
                    headerTitle.textContent = 'AgriRescue';
                if (loginLink)
                    loginLink.textContent = 'Login';
                if (logoutLink)
                    logoutLink.textContent = 'Logout';
                if (welcomeSpan) {
                    const userName = '<%= user != null ? user : "" %>';
                    welcomeSpan.textContent = 'Welcome, ' + userName + '!';
                }

                // Section titles
                const campaignTitle = document.getElementById('campaignTitle');
                const productTitle = document.getElementById('productTitle');

                if (lang === 'vi') {
                    if (campaignTitle)
                        campaignTitle.textContent = 'Chiến dịch hoạt động';
                    if (productTitle)
                        productTitle.textContent = 'Sản phẩm có sẵn';
                } else {
                    if (campaignTitle)
                        campaignTitle.textContent = 'Active Campaigns';
                    if (productTitle)
                        productTitle.textContent = 'Available Products';
                }

                // Campaign table headers
                const campaignHeaders = document.querySelectorAll('#campaignTable thead th');
                if (campaignHeaders.length === 6) {
                    campaignHeaders[0].textContent = 'Campaign Title';
                    campaignHeaders[1].textContent = 'Description';
                    campaignHeaders[2].textContent = 'Goal (VND)';
                    campaignHeaders[3].textContent = 'Raised (VND)';
                    campaignHeaders[4].textContent = 'Start Date';
                    campaignHeaders[5].textContent = 'End Date';
                }

                // Product table headers
                const productHeaders = document.querySelectorAll('#productTable thead th');
                if (productHeaders.length === 4) {
                    productHeaders[0].textContent = 'Product Name';
                    productHeaders[1].textContent = 'Description';
                    productHeaders[2].textContent = 'Price (VND)';
                    productHeaders[3].textContent = 'Quantity';
                }
            }
        }

        window.onload = function () {
            const savedLang = localStorage.getItem('lang') || 'vi';
            const langSelect = document.querySelector('.language-switch select');
            if (langSelect) {
                langSelect.value = savedLang;
            }
            changeLanguage(savedLang);
        };

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

        paginateTableWithEllipsis('campaignTable', 'campaign-row', 'campaignPagination');
        paginateTableWithEllipsis('productTable', 'product-row', 'productPagination');

    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>


    <div class="footer">
        <div class="contact-help">
            <a href="#" onclick="navigate('Contact / Help Center')">Contact / Help Center</a>
        </div>
        <div class="faq">
            <a href="#" onclick="navigate('FAQs')">FAQs</a>
            <div class="faq-circle" onclick="navigate('FAQs')">?</div>
        </div>
    </div>
</body>
</html>

