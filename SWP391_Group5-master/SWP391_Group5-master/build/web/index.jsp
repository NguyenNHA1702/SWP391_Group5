<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AgriRescue - Home</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
            background-image: url('https://via.placeholder.com/1920x1080?text=Agricultural+Fields');
            background-size: cover;
            background-attachment: fixed;
            position: relative;
            min-height: 100vh;
        }
        .header {
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: rgba(46, 125, 50, 0.8);
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            position: sticky;
            top: 0;
            z-index: 1000;
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
    </style>
</head>
<body>
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
                String user = (String) session.getAttribute("user");
                if (user == null) {
            %>
                <a href="login.jsp" class="login">Login</a>
                
            <% } else { %>
                <span>Welcome, <%= user %>!</span>
                <a href="logout.jsp" class="logout">Logout</a>
            <% } %>
        </div>
    </div>

    <div class="content">
        <h1>Welcome to AgriRescue</h1>
        <p>Promote local agricultural products and organize rescue campaigns to support farmers and communities. Explore our marketplace, join campaigns, and contribute to a sustainable future.</p>
        <div class="banner">
            <img src="https://via.placeholder.com/800x300?text=AgriRescue+Banner" alt="Welcome Banner">
        </div>
        <div class="features">
            <div class="feature-card" onclick="navigate('Browse Campaigns')">
                <h3>Browse Campaigns</h3>
                <p>Join ongoing rescue campaigns to support farmers in need.</p>
            </div>
            <div class="feature-card" onclick="navigate('Marketplace')">
                <h3>Marketplace</h3>
                <p>Discover fresh local agricultural products directly from farmers.</p>
            </div>
            <div class="feature-card" onclick="navigate('News & Blog')">
                <h3>News & Blog</h3>
                <p>Stay updated with the latest agricultural news and stories.</p>
            </div>
        </div>
        <p>Login or Sign Up to access more features like creating campaigns and managing your inventory.</p>
    </div>

    <div class="footer">
        <div class="contact-help">
            <a href="#" onclick="navigate('Contact / Help Center')">Contact / Help Center</a>
        </div>
        <div class="faq">
            <a href="#" onclick="navigate('FAQs')">FAQs</a>
            <div class="faq-circle" onclick="navigate('FAQs')">?</div>
        </div>
    </div>

    <script>
        function navigate(feature) {
            alert('Navigating to ' + feature + ' (placeholder link).');
        }

        function changeLanguage(lang) {
            if (lang === 'vi') {
                document.querySelector('h1').textContent = 'Chào mừng đến với AgriRescue';
                document.querySelectorAll('p')[0].textContent = 'Thúc đẩy sản phẩm nông nghiệp địa phương và tổ chức các chiến dịch cứu trợ để hỗ trợ nông dân và cộng đồng. Khám phá thị trường của chúng tôi, tham gia chiến dịch và góp phần vào một tương lai bền vững.';
                document.querySelectorAll('.feature-card h3')[0].textContent = 'Duyệt Chiến dịch';
                document.querySelectorAll('.feature-card p')[0].textContent = 'Tham gia các chiến dịch cứu trợ đang diễn ra để hỗ trợ nông dân gặp khó khăn.';
                document.querySelectorAll('.feature-card h3')[1].textContent = 'Thị trường';
                document.querySelectorAll('.feature-card p')[1].textContent = 'Khám phá các sản phẩm nông nghiệp địa phương tươi ngon trực tiếp từ nông dân.';
                document.querySelectorAll('.feature-card h3')[2].textContent = 'Tin tức & Blog';
                document.querySelectorAll('.feature-card p')[2].textContent = 'Cập nhật những tin tức và câu chuyện nông nghiệp mới nhất.';
                document.querySelectorAll('p')[1].textContent = 'Đăng nhập hoặc Đăng ký để truy cập thêm các tính năng như tạo chiến dịch và quản lý kho hàng.';
                document.querySelector('.contact-help a').textContent = 'Liên hệ / Trung tâm Hỗ trợ';
                document.querySelector('.faq a').textContent = 'Câu hỏi thường gặp';
                document.querySelector('.header-actions a.login').textContent = 'Đăng nhập';
                document.querySelector('.header-actions a.signup').textContent = 'Đăng ký';
                document.querySelector('.home-btn').textContent = 'Trang chủ';
                if (document.querySelector('.header-actions span')) {
                    document.querySelector('.header-actions span').textContent = 'Chào mừng, ' + '<%= user != null ? user : "" %>' + '!';
                }
            } else {
                document.querySelector('h1').textContent = 'Welcome to AgriRescue';
                document.querySelectorAll('p')[0].textContent = 'Promote local agricultural products and organize rescue campaigns to support farmers and communities. Explore our marketplace, join campaigns, and contribute to a sustainable future.';
                document.querySelectorAll('.feature-card h3')[0].textContent = 'Browse Campaigns';
                document.querySelectorAll('.feature-card p')[0].textContent = 'Join ongoing rescue campaigns to support farmers in need.';
                document.querySelectorAll('.feature-card h3')[1].textContent = 'Marketplace';
                document.querySelectorAll('.feature-card p')[1].textContent = 'Discover fresh local agricultural products directly from farmers.';
                document.querySelectorAll('.feature-card h3')[2].textContent = 'News & Blog';
                document.querySelectorAll('.feature-card p')[2].textContent = 'Stay updated with the latest agricultural news and stories.';
                document.querySelectorAll('p')[1].textContent = 'Login or Sign Up to access more features like creating campaigns and managing your inventory.';
                document.querySelector('.contact-help a').textContent = 'Contact / Help Center';
                document.querySelector('.faq a').textContent = 'FAQs';
                document.querySelector('.header-actions a.login').textContent = 'Login';
                document.querySelector('.header-actions a.signup').textContent = 'Sign Up';
                document.querySelector('.home-btn').textContent = 'Home Page';
                if (document.querySelector('.header-actions span')) {
                    document.querySelector('.header-actions span').textContent = 'Welcome, ' + '<%= user != null ? user : "" %>' + '!';
                }
            }
        }
    </script>
</body>
</html>
