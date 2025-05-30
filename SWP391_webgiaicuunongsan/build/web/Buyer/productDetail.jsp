<%-- 
    Document   : productDetail
    Created on : May 24, 2025, 10:50:42 PM
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
                <h1 class="text-2xl font-bold text-white header-title">AgriRescue</h1>
                <a href="index.jsp" class="home-btn">Home Page</a>
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
        // Lấy đối tượng sản phẩm từ request scope (được truyền từ Servlet/controller)
        Product product = (Product) request.getAttribute("product");
        NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        %>

        <h2 class="text-center text-success my-4">
            <i class="bi bi-box-seam-fill me-2"></i>Chi tiết sản phẩm
        </h2>

        <div class="container mt-4">
            <%
                // Kiểm tra xem sản phẩm có tồn tại không
                if (product != null) {
            %>
            <div class="card shadow-sm">
                <div class="card-body">
                    <!-- BẢNG THÔNG TIN CHI TIẾT SẢN PHẨM -->
                    <table class="table table-bordered table-striped">
                        <tbody>
                            <tr>
                                <th><i class="bi bi-tag-fill text-primary me-2"></i>Tên sản phẩm</th>
                                <td><%= product.getName() %></td>
                            </tr>
                            <tr>
                                <th><i class="bi bi-card-text text-secondary me-2"></i>Mô tả</th>
                                <td><%= product.getDescription() != null ? product.getDescription() : "Chưa có mô tả" %></td>
                            </tr>
                            <tr>
                                <th><i class="bi bi-cash-coin text-success me-2"></i>Giá</th>
                                <td class="text-danger fw-bold"><%= currencyFormat.format(product.getPrice()) %></td>
                            </tr>
                            <tr>
                                <th><i class="bi bi-boxes text-warning me-2"></i>Số lượng còn</th>
                                <td><%= product.getQuantity() %>kg</td>
                            </tr>
                            <tr>
                                <th><i class="bi bi-translate text-info me-2"></i>Ngôn ngữ</th>
                                <td><%= product.getLanguage() != null ? product.getLanguage() : "Không xác định" %></td>
                            </tr>
                            <tr>
                                <th><i class="bi bi-calendar-event text-muted me-2"></i>Ngày tạo</th>
                                <td><%= sdf.format(product.getCreatedAt()) %></td>
                            </tr>

                        </tbody>
                    </table>
                    <!-- NÚT QUAY LẠI DANH SÁCH SẢN PHẨM -->
                    <a href="productList" class="btn btn-primary mt-3">Quay lại danh sách sản phẩm</a>
                </div>
            </div>

            <%
                } else {
            %>
            <!-- THÔNG BÁO SẢN PHẨM KHÔNG TỒN TẠI -->
            <div class="alert alert-warning mt-4 shadow-sm">
                Rất tiếc, sản phẩm bạn tìm không tồn tại hoặc đã bị xóa.
            </div>
            <%
                }
            %>
        </div>
        <script>
            function changeLanguage(lang) {
                const homeBtn = document.querySelector('.home-btn');
                const headerTitle = document.querySelector('.header-title');
                const loginBtn = document.querySelector('.header-actions a.login');
                const logoutBtn = document.querySelector('.header-actions a.logout');
                const welcomeSpan = document.querySelector('.header-actions span');
                const h2 = document.querySelector('h2');
                const labels = document.querySelectorAll('table th');
                const backBtn = document.querySelector('.btn.btn-primary');
                const alertBox = document.querySelector('.alert.alert-warning');
                const userName = '<%= user != null ? user : "" %>';

                if (lang === 'vi') {
                    if (homeBtn)
                        homeBtn.textContent = 'Trang chủ';
                    if (headerTitle)
                        headerTitle.textContent = 'AgriRescue';
                    if (loginBtn)
                        loginBtn.textContent = 'Đăng nhập';
                    if (logoutBtn)
                        logoutBtn.textContent = 'Đăng xuất';
                    if (welcomeSpan)
                        welcomeSpan.textContent = 'Chào mừng, ' + userName + '!';
                    if (h2)
                        h2.textContent = 'Chi tiết sản phẩm';

                    if (labels.length >= 6) {
                        labels[0].textContent = 'Tên sản phẩm';
                        labels[1].textContent = 'Mô tả';
                        labels[2].textContent = 'Giá';
                        labels[3].textContent = 'Số lượng còn';
                        labels[4].textContent = 'Ngôn ngữ';
                        labels[5].textContent = 'Ngày tạo';
                    }

                    if (backBtn)
                        backBtn.textContent = 'Quay lại danh sách sản phẩm';
                    if (alertBox)
                        alertBox.textContent = 'Không tìm thấy sản phẩm.';
                } else {
                    if (homeBtn)
                        homeBtn.textContent = 'Home Page';
                    if (headerTitle)
                        headerTitle.textContent = 'AgriRescue';
                    if (loginBtn)
                        loginBtn.textContent = 'Login';
                    if (logoutBtn)
                        logoutBtn.textContent = 'Logout';
                    if (welcomeSpan)
                        welcomeSpan.textContent = 'Welcome, ' + userName + '!';
                    if (h2)
                        h2.textContent = 'Product Detail';

                    if (labels.length >= 6) {
                        labels[0].textContent = 'Product Name';
                        labels[1].textContent = 'Description';
                        labels[2].textContent = 'Price';
                        labels[3].textContent = 'Quantity Left';
                        labels[4].textContent = 'Language';
                        labels[5].textContent = 'Created At';
                    }

                    if (backBtn)
                        backBtn.textContent = 'Back to Product List';
                    if (alertBox)
                        alertBox.textContent = 'Product not found.';
                }
            }

            // Load language preference
            window.onload = function () {
                const savedLang = localStorage.getItem('lang') || 'vi';
                document.querySelector('.language-switch select').value = savedLang;
                changeLanguage(savedLang);
            };

            // Save language change
            document.querySelector('.language-switch select').addEventListener('change', function () {
                localStorage.setItem('lang', this.value);
            });
        </script>

    </body>

</html>
