<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AgriRescue - Home</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        body {
            background-image: url('https://images.unsplash.com/photo-1500595046743-ddf4d3d753fd?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');
            background-size: cover;
            background-attachment: fixed;
            background-position: center;
        }
        .header {
            background-color: rgba(46, 125, 50, 0.8);
            backdrop-filter: blur(8px);
        }
        .feature-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .feature-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
        }
        .banner img {
            transition: transform 0.3s ease;
        }
        .banner img:hover {
            transform: scale(1.02);
        }
        .footer {
            background-color: rgba(46, 125, 50, 0.8);
            backdrop-filter: blur(8px);
        }
        .faq-circle {
            transition: background-color 0.3s ease, transform 0.3s ease;
        }
        .faq-circle:hover {
            background-color: #fef08a;
            transform: scale(1.1);
        }
    </style>
</head>
<body class="font-sans text-gray-800">
    <%
        String user = (String) session.getAttribute("user");
        String role = (String) session.getAttribute("role");
    %>
    <header class="header sticky top-0 z-50 shadow-lg py-4 px-6 flex justify-between items-center">
        <div class="flex items-center space-x-4">
            <select onchange="changeLanguage(this.value)" class="bg-white border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
                <option value="en">English</option>
                <option value="vi">Tiếng Việt</option>
            </select>
            <h1 class="text-2xl font-bold text-white">AgriRescue</h1>
            <a href="index.jsp" class="home-btn bg-green-800 text-white px-4 py-2 rounded-lg hover:bg-green-900 transition">Home Page</a>
        </div>
        <div class="flex items-center space-x-3">
            <%
                if (user == null) {
            %>
                <a href="login.jsp" class="login bg-yellow-400 text-green-900 px-4 py-2 rounded-lg hover:bg-yellow-500 transition">Login</a>
                <a href="signup.jsp" class="signup bg-green-700 text-white px-4 py-2 rounded-lg hover:bg-green-800 transition">Sign Up</a>
            <%
                } else {
            %>
                <span class="text-white font-medium">Welcome, <%= user %>!</span>
                <a href="LogoutServlet" class="logout bg-red-600 text-white px-4 py-2 rounded-lg hover:bg-red-700 transition">Logout</a>
            <%
                }
            %>
        </div>
    </header>

    <main class="container mx-auto px-4 py-8">
        <section class="bg-white bg-opacity-90 rounded-xl shadow-lg p-8 mb-8 text-center">
            <h1 class="text-4xl font-extrabold text-green-700 mb-4">Welcome to AgriRescue</h1>
            <p class="text-lg text-gray-600 max-w-2xl mx-auto">Promote local agricultural products and organize rescue campaigns to support farmers and communities. Explore our marketplace, join campaigns, and contribute to a sustainable future.</p>
        </section>

        <div class="banner mb-8">
            <img src="https://images.unsplash.com/photo-1501436513145-30f24e19fcc8?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="AgriRescue Banner" class="rounded-xl shadow-md mx-auto">
        </div>

        <div class="features grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
            <div class="feature-card bg-white rounded-xl shadow-md p-6 text-center"
                 <% if (user != null && "buyer".equals(role)) { %>
                 onclick="location.href = 'browse'"
                 style="cursor:pointer;"
                 <% } else { %>
                 onclick="alert('Please login as a buyer to access Browse Campaigns'); location.href = 'login.jsp';"
                 style="cursor:not-allowed; opacity: 0.6;"
                 <% } %>>
                <h3 class="text-xl font-semibold text-green-700 mb-2">Browse Campaigns</h3>
                <p class="text-gray-600">Join ongoing rescue campaigns to support farmers in need.</p>
            </div>
            <div class="feature-card bg-white rounded-xl shadow-md p-6 text-center"
                 onclick="location.href = 'productList';"
                 style="cursor:pointer;">
                <h3 class="text-xl font-semibold text-green-700 mb-2">Marketplace</h3>
                <p class="text-gray-600">Discover fresh local agricultural products directly from farmers.</p>
            </div>
            <div class="feature-card bg-white rounded-xl shadow-md p-6 text-center"
                 onclick="navigate('News & Blog')">
                <h3 class="text-xl font-semibold text-green-700 mb-2">News & Blog</h3>
                <p class="text-gray-600">Stay updated with the latest agricultural news and stories.</p>
            </div>
            <div class="feature-card bg-white rounded-xl shadow-md p-6 text-center"
                 <% if (user != null && "farmer".equals(role)) { %>
                 onclick="location.href = 'campaigns'"
                 style="cursor:pointer;"
                 <% } else { %>
                 onclick="alert('Please login to access Campaigns'); location.href = 'login.jsp';"
                 style="cursor:not-allowed; opacity: 0.6;"
                 <% } %>>
                <h3 class="text-xl font-semibold text-green-700 mb-2">Campaign</h3>
                <p class="text-gray-600">Campaigns for farmers.</p>
            </div>
        </div>

        <p class="text-center text-gray-600">Login or Sign Up to access more features like creating campaigns and managing your inventory.</p>
    </main>

    <footer class="footer fixed bottom-0 w-full py-4 px-6 flex justify-between items-center text-white">
        <div class="contact-help">
            <a href="#" onclick="navigate('Contact / Help Center')" class="hover:underline">Contact / Help Center</a>
        </div>
        <div class="faq flex items-center space-x-2">
            <a href="#" onclick="navigate('FAQs')" class="hover:underline">FAQs</a>
            <div class="faq-circle bg-white text-green-700 w-6 h-6 rounded-full flex items-center justify-center cursor-pointer" onclick="navigate('FAQs')">?</div>
        </div>
    </footer>

    <script>
        function navigate(feature) {
            switch (feature) {
                case 'Browse Campaigns':
                    window.location.href = 'Buyer/browse';
                    break;
                case 'Marketplace':
                    window.location.href = 'productList';
                    break;
                case 'News & Blog':
                    window.location.href = 'blog.jsp';
                    break;
                case 'Campaign':
                    window.location.href = 'Farmer/campaignList';
                    break;
                case 'Contact / Help Center':
                    window.location.href = 'contact.jsp';
                    break;
                case 'FAQs':
                    window.location.href = 'faq.jsp';
                    break;
                default:
                    alert('Feature not available');
            }
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
                document.querySelectorAll('.feature-card h3')[3].textContent = 'Chiến dịch';
                document.querySelectorAll('.feature-card p')[3].textContent = 'Chiến dịch cho nông dân.';
                document.querySelectorAll('p')[1].textContent = 'Đăng nhập hoặc Đăng ký để truy cập thêm các tính năng như tạo chiến dịch và quản lý kho hàng.';
                document.querySelector('.contact-help a').textContent = 'Liên hệ / Trung tâm Hỗ trợ';
                document.querySelector('.faq a').textContent = 'Câu hỏi thường gặp';
                document.querySelector('.home-btn').textContent = 'Trang chủ';
                if (document.querySelector('.login')) document.querySelector('.login').textContent = 'Đăng nhập';
                if (document.querySelector('.signup')) document.querySelector('.signup').textContent = 'Đăng ký';
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
                document.querySelectorAll('.feature-card h3')[3].textContent = 'Campaign';
                document.querySelectorAll('.feature-card p')[3].textContent = 'Campaigns for farmers.';
                document.querySelectorAll('p')[1].textContent = 'Login or Sign Up to access more features like creating campaigns and managing your inventory.';
                document.querySelector('.contact-help a').textContent = 'Contact / Help Center';
                document.querySelector('.faq a').textContent = 'FAQs';
                document.querySelector('.home-btn').textContent = 'Home Page';
                if (document.querySelector('.login')) document.querySelector('.login').textContent = 'Login';
                if (document.querySelector('.signup')) document.querySelector('.signup').textContent = 'Sign Up';
                if (document.querySelector('.header-actions span')) {
                    document.querySelector('.header-actions span').textContent = 'Welcome, ' + '<%= user != null ? user : "" %>' + '!';
                }
            }
        }
    </script>
</body>
</html>