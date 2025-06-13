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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    </head>
    <style>
        body {
            background: #f8f9fa;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
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
        .header {
            background: #28a745;
            color: white;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }
        .header h1 {
            margin: 0;
            font-weight: 700;
        }
        .header-left {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        .language-switch select {
            border-radius: 4px;
            padding: 0.25rem 0.5rem;
            border: none;
            font-weight: 600;
        }
        .home-btn, .login, .logout {
            color: white;
            text-decoration: none;
            font-weight: 600;
            padding: 0.3rem 0.6rem;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        .home-btn:hover, .login:hover, .logout:hover {
            background: rgba(255, 255, 255, 0.25);
        }
        form.d-flex input[type="text"], form.d-flex select {
            border-radius: 4px;
            border: 1px solid #ced4da;
            padding: 0.4rem 0.6rem;
        }
        form.d-flex button {
            background-color: #28a745;
            border: none;
            color: white;
            font-weight: 600;
            padding: 0.4rem 1rem;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        form.d-flex button:hover {
            background-color: #218838;
        }
        table thead {
            background-color: #d4edda;
        }
        table#productTable tbody tr.product-row:hover {
            background-color: #e9f5ec;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn-detail {
            display: inline-block;
            background-color: #198754;
            color: white;
            padding: 0.3rem 0.6rem;
            border-radius: 4px;
            text-decoration: none;
            font-weight: 600;
            transition: background-color 0.3s;
        }
        .btn-detail:hover {
            background-color: #0f5132 !important;
            box-shadow: 0 0 10px #0f5132aa;
            transform: scale(1.05);
            transition: all 0.3s ease;
        }

        form.d-flex button:hover {
            box-shadow: 0 0 10px #218838cc;
            transform: scale(1.05);
            transition: all 0.3s ease;
        }

        .pagination .page-item .page-link:hover {
            background-color: #28a745;
            color: white;
            box-shadow: 0 0 8px #28a745cc;
            transition: all 0.3s ease;
        }
        .pagination .page-item .page-link {
            cursor: pointer;
        }
        @media (max-width: 600px) {
            .header {
                flex-direction: column;
                text-align: center;
            }
            form.d-flex {
                flex-direction: column;
                gap: 0.5rem;
            }
        }
    </style>

</head>
<body>
    <%
        // Lấy thông tin người dùng và vai trò từ session
        String user = (String) session.getAttribute("user");
        String role = (String) session.getAttribute("role"); 
        
    %>
    <!-- HEADER GIAO DIỆN CHÍNH: logo, nút home, login/logout, chuyển ngôn ngữ -->
    <div class="header">
        <div class="header-left">
            <div class="language-switch">
                <select onchange="changeLanguage(this.value)">
                    <option value="en">English</option>
                    <option value="vi">Tiếng Việt</option>
                </select>
            </div>
            <h1 class="text-2xl font-bold text-white header-title">AgriRescue</h1>
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
                // Lấy danh sách sản phẩm được truyền từ servlet
            List<Product> products = (List<Product>) request.getAttribute("products");
            NumberFormat currencyFormat = NumberFormat.getInstance(new Locale("vi", "VN"));
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    %>

    <h2 class="text-black p-3 rounded shadow d-inline-flex align-items-center gap-2">
        <i class="bi bi-box-seam"></i> Danh sách sản phẩm
    </h2>
    <div class="table-responsive">
        <!-- FORM TÌM KIẾM VÀ SẮP XẾP SẢN PHẨM -->
        <form method="get" action="productList" class="mb-3 d-flex gap-2 align-items-center">
            <div class="input-group">
                <span class="input-group-text bg-white"><i class="bi bi-search"></i></span>
                <input type="text" name="name" class="form-control" placeholder="Nhập tên sản phẩm"
                       value="<%= request.getParameter("name") != null ? request.getParameter("name") : "" %>">
            </div>
            <select name="sort" class="form-select" style="max-width: 200px;">
                <option value="">-- Sắp xếp theo giá --</option>
                <option value="desc" <%= "desc".equals(request.getParameter("sort")) ? "selected" : "" %>>Giá cao đến thấp</option>
                <option value="asc" <%= "asc".equals(request.getParameter("sort")) ? "selected" : "" %>>Giá thấp đến cao</option>
            </select>
            <!-- NÚT TÌM KIẾM -->
            <button type="submit" class="btn btn-success d-flex align-items-center gap-1">
                <i class="bi bi-filter"></i> Tìm kiếm
            </button>
        </form>

        <table id="productTable" class="table table-bordered table-striped">
            <thead class="table-success">
                <tr>
                    <th style="width:5%;">#</th>
                    <th style="width:35%;">Tên sản phẩm</th>
                    <th style="width:15%;">Giá (VNĐ)</th>
                    <th style="width:10%;">Số lượng còn</th>
                    <th style="width:15%;">Ngày tạo</th>
                    <th style="width:5%;">Chi tiết</th>
                </tr>
            </thead>
            <tbody>
                <% 
    // KIỂM TRA CÓ DỮ LIỆU SẢN PHẨM HAY KHÔNG
    if (products != null && !products.isEmpty()) {
        int i = 1;
        for (Product p : products) {
                %>
                <tr class="product-row">
                    <td><%= i++ %></td>
                    <td><%= p.getName() %></td>
                    <td><%= currencyFormat.format(p.getPrice()) %></td>
                    <td><%= p.getQuantity() %>kg</td>
                    <td><%= sdf.format(p.getCreatedAt()) %></td>
                    <td>
                        <!-- NÚT XEM CHI TIẾT -->
                        <a href="productDetail?id=<%= p.getProductId() %>" class="btn-detail">
                            <i class="bi bi-eye-fill"></i> Xem chi tiết
                        </a>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <!-- TRƯỜNG HỢP KHÔNG CÓ SẢN PHẨM -->
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
                        try {
                            document.querySelector('.home-btn').textContent = lang === 'vi' ? 'Trang chủ' : 'Home Page';

                            const title = document.querySelector('.header-title');
                            if (title)
                                title.textContent = 'AgriRescue';

                            const loginBtn = document.querySelector('.header-actions a.login');
                            if (loginBtn)
                                loginBtn.textContent = lang === 'vi' ? 'Đăng nhập' : 'Login';

                            const logoutBtn = document.querySelector('.header-actions a.logout');
                            if (logoutBtn)
                                logoutBtn.textContent = lang === 'vi' ? 'Đăng xuất' : 'Logout';

                            const welcomeSpan = document.querySelector('.header-actions span');
                            const userName = '<%= user != null ? user : "" %>';
                            if (welcomeSpan)
                                welcomeSpan.textContent = lang === 'vi' ? 'Chào mừng, ' + userName + '!' : 'Welcome, ' + userName + '!';

                            // Đổi placeholder ô nhập
                            const nameInput = document.querySelector('input[name="name"]');
                            if (nameInput) {
                                nameInput.placeholder = lang === 'vi' ? 'Nhập tên sản phẩm' : 'Enter product name';
                            }

                            // Đổi nút tìm kiếm
                            const searchBtn = document.querySelector('button[type="submit"]');
                            if (searchBtn) {
                                searchBtn.innerHTML = lang === 'vi'
                                        ? '<i class="bi bi-filter"></i> Tìm kiếm'
                                        : '<i class="bi bi-filter"></i> Search';
                            }

                            // Đổi text dropdown sắp xếp
                            const sortSelect = document.querySelector('select[name="sort"]');
                            if (sortSelect) {
                                sortSelect.options[0].text = lang === 'vi' ? '-- Sắp xếp theo giá --' : '-- Sort by price --';
                                sortSelect.options[1].text = lang === 'vi' ? 'Giá cao đến thấp' : 'Price: High to Low';
                                sortSelect.options[2].text = lang === 'vi' ? 'Giá thấp đến cao' : 'Price: Low to High';
                            }


                            document.querySelector('h2').textContent = lang === 'vi' ? 'Danh sách sản phẩm' : 'Product List';

                            const headers = document.querySelectorAll('#productTable thead th');
                            if (headers.length >= 6) {
                                if (lang === 'vi') {
                                    headers[0].textContent = '#';
                                    headers[1].textContent = 'Tên sản phẩm';
                                    headers[2].textContent = 'Giá (VNĐ)';
                                    headers[3].textContent = 'Số lượng còn';
                                    headers[4].textContent = 'Ngày tạo';
                                    headers[5].textContent = 'Chi tiết';
                                } else {
                                    headers[0].textContent = '#';
                                    headers[1].textContent = 'Product Name';
                                    headers[2].textContent = 'Price (VND)';
                                    headers[3].textContent = 'Quantity Left';
                                    headers[4].textContent = 'Created At';
                                    headers[5].textContent = 'Detail';
                                }
                            }

                            document.querySelectorAll('.btn-detail').forEach(btn => {
                                btn.innerHTML = lang === 'vi' ? '<i class="bi bi-eye-fill"></i> Xem chi tiết' : '<i class="bi bi-eye-fill"></i> View Detail';
                            });

                            const noProductRow = document.querySelector('tbody tr td[colspan="6"]');
                            if (noProductRow) {
                                noProductRow.textContent = lang === 'vi' ? 'Không có sản phẩm nào' : 'No products available';
                            }

                        } catch (error) {
                            console.error("Language switch error:", error);
                        }
                    }

                    // Load saved language on page load
                    window.onload = function () {
                        const savedLang = localStorage.getItem('lang') || 'vi';
                        const langSelect = document.querySelector('.language-switch select');
                        if (langSelect) {
                            langSelect.value = savedLang;
                            changeLanguage(savedLang);

                            // Gắn sự kiện sau khi DOM đã sẵn sàng
                            langSelect.addEventListener('change', function () {
                                localStorage.setItem('lang', this.value);
                                changeLanguage(this.value);
                            });
                        }
                    };

                    const rowsPerPage = 10;
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



