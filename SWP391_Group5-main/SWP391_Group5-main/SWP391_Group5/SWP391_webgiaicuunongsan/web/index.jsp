<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Campaign" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>

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
            background-color: rgba(34, 197, 94, 0.9);
            backdrop-filter: blur(8px);
        }
        .feature-card, .campaign-card, .news-card, .spotlight-card, .product-card, .tip-card, .event-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .feature-card:hover, .campaign-card:hover, .news-card:hover, .spotlight-card:hover, .product-card:hover, .tip-card:hover, .event-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
        }
        .footer {
            background-color: rgba(34, 197, 94, 0.9);
            backdrop-filter: blur(8px);
        }
        .faq-circle {
            transition: background-color 0.3s ease, transform 0.3s ease;
        }
        .faq-circle:hover {
            background-color: #fef08a;
            transform: scale(1.1);
        }
        .progress-bar {
            background-color: #22c55e; /* Green-500 */
        }
        .news-section {
            background-color: rgba(0, 0, 0, 0.7);
            color: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        .news-card img, .tip-card img, .event-card img {
            max-height: 150px;
            object-fit: cover;
        }
        .spotlight-section img {
            max-height: 200px;
            object-fit: cover;
        }
        .product-card img {
            max-height: 120px;
            object-fit: cover;
        }
        .cta-banner {
            background-image: url('https://images.unsplash.com/photo-1507525428034-b723cf961d3e?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');
            background-size: cover;
            background-position: center;
            padding: 40px;
            border-radius: 10px;
            text-align: center;
            color: white;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            justify-content: center;
            align-items: center;
        }
        .modal-content {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            width: 90%;
            max-width: 500px;
            text-align: center;
        }
        .modal-content input {
            width: 100%;
            padding: 8px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .modal-content button {
            padding: 10px 20px;
            margin: 5px;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body class="font-sans text-gray-800">
    <%
        String user = (String) session.getAttribute("user");
        String role = (String) session.getAttribute("role");
        List<Campaign> campaigns = new ArrayList<>();
        {
            Campaign c1 = new Campaign();
            c1.setCampaignId(1);
            c1.setTitle("Save Rice Farmers in Hanoi");
            c1.setDescription("Help rice farmers recover from recent floods.");
            c1.setGoalAmount(50000000.0);
            c1.setCurrentAmount(25000000.0);
            c1.setEndDate(new Date(System.currentTimeMillis() + 2 * 24 * 60 * 60 * 1000));
            campaigns.add(c1);

            Campaign c2 = new Campaign();
            c2.setCampaignId(2);
            c2.setTitle("Vegetable Rescue in Dong Nai");
            c2.setDescription("Support vegetable farmers affected by drought.");
            c2.setGoalAmount(30000000.0);
            c2.setCurrentAmount(15000000.0);
            c2.setEndDate(new Date(System.currentTimeMillis() + 5 * 24 * 60 * 60 * 1000));
            campaigns.add(c2);
        }
        NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
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
                <a href="userprofile.jsp" class="profile bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition">Profile</a>
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

        <!-- Farmer Spotlight Section -->
        <section class="spotlight-section mb-8">
            <h2 class="text-3xl font-bold text-green-700 mb-6 text-center">Tiêu điểm Nông dân</h2>
            <div class="spotlight-card bg-white bg-opacity-90 rounded-xl shadow-md p-6 flex flex-col md:flex-row items-center">
                <img src="https://images.unsplash.com/photo-1500595046743-ddf4d3d753fd?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" alt="Farmer Spotlight" class="w-full md:w-1/3 rounded-lg mb-4 md:mb-0 md:mr-6">
                <div class="text-center md:text-left">
                    <h3 class="text-xl font-semibold text-green-700 mb-2">Anh Nguyễn Văn Tâm, Hải Dương</h3>
                    <p class="text-gray-600 mb-4">Nhờ AgriRescue, anh Tâm đã cứu được mùa lúa và mở rộng kinh doanh.</p>
                    <a href="successStoryDetail?storyId=1" class="bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700 transition">Tìm hiểu thêm</a>
                </div>
            </div>
        </section>

        <!-- Marketplace Highlights Section -->
        <section class="marketplace-section mb-8">
            <h2 class="text-3xl font-bold text-green-700 mb-6 text-center">Sản phẩm Nổi bật</h2>
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
                <div class="product-card bg-white rounded-xl shadow-md p-4 text-center">
                    <img src="https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" alt="Product 1" class="w-full rounded-lg mb-2">
                    <h3 class="text-lg font-semibold text-green-700">Dưa hấu Hà Nội</h3>
                    <p class="text-gray-600">15,000 VND/kg</p>
                    <a href="productList" class="bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700 transition mt-2 inline-block">Buy Now</a>
                </div>
                <div class="product-card bg-white rounded-xl shadow-md p-4 text-center">
                    <img src="https://images.unsplash.com/photo-1600585154526-990d71dbb6b8?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" alt="Product 2" class="w-full rounded-lg mb-2">
                    <h3 class="text-lg font-semibold text-green-700">Rau sạch Đồng Nai</h3>
                    <p class="text-gray-600">20,000 VND/bó</p>
                    <a href="productList" class="bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700 transition mt-2 inline-block">Buy Now</a>
                </div>
            </div>
            <div class="text-center mt-6">
                <a href="productList" class="bg-green-700 text-white px-6 py-3 rounded-lg hover:bg-green-800 transition">See More Products</a>
            </div>
        </section>

        <!-- Seasonal Tips & Events Section -->
        <section class="tips-events-section mb-8">
            <h2 class="text-3xl font-bold text-green-700 mb-6 text-center">Mẹo Theo Mùa & Sự Kiện</h2>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="tip-card bg-white rounded-xl shadow-md p-6">
                    <img src="https://images.unsplash.com/photo-1500595046743-ddf4d3d753fd?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" alt="Seasonal Tip" class="w-full rounded-lg mb-4">
                    <h3 class="text-xl font-semibold text-green-700 mb-2">Mẹo Mùa Mưa</h3>
                    <p class="text-gray-600 mb-4">Đảm bảo thoát nước tốt để tránh ngập úng cho cây lúa.</p>
                    <a href="tipsAndEvents.jsp" class="text-green-600 hover:underline">Xem Thêm Mẹo</a>
                </div>
                <div class="event-card bg-white rounded-xl shadow-md p-6">
                    <img src="https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" alt="Event" class="w-full rounded-lg mb-4">
                    <h3 class="text-xl font-semibold text-green-700 mb-2">Hội chợ Nông sản Hà Nội 2025</h3>
                    <p class="text-gray-600 mb-2">Ngày: 15/06/2025</p>
                    <p class="text-gray-600 mb-4">Địa điểm: Trung tâm Hội nghị Hà Nội</p>
                    <a href="tipsAndEvents.jsp" class="bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700 transition">Đăng ký ngay</a>
                </div>
            </div>
        </section>

        <!-- News Feed Section -->
        <section class="news-section mb-8">
            <h2 class="text-3xl font-bold mb-6 text-center">Tin Mới Nhất</h2>
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
                <div class="news-card bg-white bg-opacity-90 rounded-xl shadow-md p-4 text-center" onclick="navigateToCampaigns('Hanoi')">
                    <img src="https://images.unsplash.com/photo-1500595046743-ddf4d3d753fd?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" alt="Hanoi Rescue" class="w-full rounded-lg mb-2">
                    <h3 class="text-lg font-semibold">Dưa hấu "giải cứu" bày bán tại lễ hội Hà Nội, giá siêu rẻ</h3>
                    <p class="text-sm text-gray-300">VTV.vn: Tình hình thu hoạch dưa hấu tại Hà Nội đang gặp khó khăn...</p>
                </div>
                <div class="news-card bg-white bg-opacity-90 rounded-xl shadow-md p-4 text-center" onclick="navigateToCampaigns('Trung Quoc')">
                    <img src="https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" alt="Trung Quoc Trade" class="w-full rounded-lg mb-2">
                    <h3 class="text-lg font-semibold">Nhiều cửa khẩu giáp Trung Quốc thông quan trở lại</h3>
                    <p class="text-sm text-gray-300">Thông tin về việc thông quan hàng hóa tại biên giới...</p>
                </div>
                <div class="news-card bg-white bg-opacity-90 rounded-xl shadow-md p-4 text-center" onclick="navigateToCampaigns('Venezuela')">
                    <img src="https://images.unsplash.com/photo-1600585154526-990d71dbb6b8?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" alt="Venezuela Crisis" class="w-full rounded-lg mb-2">
                    <h3 class="text-lg font-semibold">Đảng cầm quyền Venezuela chiến thắng trong cuộc bầu cử</h3>
                    <p class="text-sm text-gray-300">Tin tức về tình hình chính trị tại Venezuela...</p>
                </div>
            </div>
        </section>

        <!-- Rescue Campaigns Section -->
        <section class="campaigns-section mb-8">
            <h2 class="text-3xl font-bold text-green-700 mb-6 text-center">Rescue Campaigns</h2>
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
                <%
                    Date now = new Date();
                    if (campaigns != null && !campaigns.isEmpty()) {
                        for (Campaign campaign : campaigns) {
                            Date end = campaign.getEndDate();
                            long diffInMs = end.getTime() - now.getTime();
                            long diffInDays = diffInMs / (1000 * 60 * 60 * 24);
                            long diffInHours = (diffInMs / (1000 * 60 * 60)) % 24;

                            String status;
                            if (now.after(end)) {
                                status = "Đã kết thúc";
                            } else if (diffInDays <= 3) {
                                status = "Sắp kết thúc";
                            } else {
                                status = "Đang diễn ra";
                            }

                            double progress = (campaign.getCurrentAmount() / campaign.getGoalAmount()) * 100;
                            String description = campaign.getDescription() != null ? campaign.getDescription() : "";
                            String shortDesc = description.length() > 100 ? description.substring(0, 100) + "..." : description;
                %>
                <div class="campaign-card bg-white rounded-xl shadow-md p-6">
                    <h3 class="text-xl font-semibold text-green-700 mb-2"><%= campaign.getTitle() %></h3>
                    <p class="text-gray-600 mb-2"><%= shortDesc %></p>
                    <p class="text-sm text-red-600 font-semibold">⏳ Còn <%= diffInDays %> ngày <%= diffInHours %> giờ</p>
                    <span class="inline-block mt-1 mb-3 px-3 py-1 rounded-full text-white
                        <%= "Đã kết thúc".equals(status) ? "bg-gray-500" :
                             "Sắp kết thúc".equals(status) ? "bg-yellow-500" :
                             "bg-green-600" %>">
                        <%= status %>
                    </span>
                    <div class="mb-4">
                        <p class="text-sm text-gray-500">Support Goal: <%= currencyFormat.format(campaign.getGoalAmount()) %></p>
                        <p class="text-sm text-gray-500">Raised: <%= currencyFormat.format(campaign.getCurrentAmount()) %></p>
                        <div class="w-full bg-gray-200 rounded-full h-2.5 mt-2">
                            <div class="progress-bar h-2.5 rounded-full" style="width: <%= progress %>%;"></div>
                        </div>
                        <p class="text-sm text-gray-500 mt-1"><%= String.format("%.0f%%", progress) %> of goal</p>
                    </div>
                    <button class="bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700 transition w-full join-campaign-btn"
                            data-campaign-id="<%= campaign.getCampaignId() %>"
                            data-campaign-title="<%= campaign.getTitle() %>"
                            data-campaign-desc="<%= shortDesc %>"
                            <% if (user == null || !"buyer".equals(role)) { %>
                            onclick="showJoinModal(<%= campaign.getCampaignId() %>, '<%= campaign.getTitle() %>', '<%= shortDesc %>', false)"
                            <% } else { %>
                            onclick="showJoinModal(<%= campaign.getCampaignId() %>, '<%= campaign.getTitle() %>', '<%= shortDesc %>', true)"
                            <% } %>>
                        Join Now
                    </button>
                </div>
                <%
                        }
                    } else {
                %>
                <p class="text-center text-gray-600 col-span-3">No rescue campaigns available at the moment.</p>
                <%
                    }
                %>
            </div>
        </section>

        <!-- Modal for Joining Campaign -->
        <div id="joinModal" class="modal">
            <div class="modal-content">
                <h2 id="modalTitle" class="text-xl font-semibold text-green-700 mb-4"></h2>
                <p id="modalDesc" class="text-gray-600 mb-4"></p>
                <div id="contributionInput" class="mb-4"></div>
                <div id="modalActions"></div>
            </div>
        </div>

        <!-- Call to Action Banner -->
        <section class="cta-banner mb-8">
            <h2 class="text-3xl font-bold mb-4">Cùng chung tay giải cứu nông sản ngay hôm nay!</h2>
            <a href="signup.jsp" class="bg-green-700 text-white px-6 py-3 rounded-lg hover:bg-green-800 transition">Tham gia ngay</a>
        </section>

        <p class="text-center text-gray-600">Login or Sign Up to access more features like creating campaigns and managing your inventory.</p>
    </main>

    <footer class="footer fixed bottom-0 w-full py-4 px-6 flex justify-between items-center text-white">
        <div class="contact-help">
            <a href="#" onclick="navigate('Contact / Help Center')" class="hover:underline">Contact / Help Center</a>
        </div>
        <div class="faq flex items-center space-x-2">
            <a href="/SWP391_webgiaicuunongsan/faq" onclick="navigate('FAQs')" class="hover:underline">FAQs</a>
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

        function navigateToCampaigns(location) {
            if ("<%= user %>" != "null" && "<%= role %>" === "farmer") {
                window.location.href = 'Farmer/campaignList?location=' + encodeURIComponent(location);
            } else if ("<%= user %>" != "null" && "<%= role %>" === "buyer") {
                window.location.href = 'Buyer/browse?location=' + encodeURIComponent(location);
            } else {
                window.location.href = 'login.jsp';
            }
        }

        function showJoinModal(campaignId, campaignTitle, campaignDesc, isBuyer) {
            const modal = document.getElementById('joinModal');
            const modalTitle = document.getElementById('modalTitle');
            const modalDesc = document.getElementById('modalDesc');
            const contributionInput = document.getElementById('contributionInput');
            const modalActions = document.getElementById('modalActions');

            modalTitle.textContent = isBuyer ? `Tham gia Chiến dịch: ${campaignTitle}` : 'Yêu cầu Đăng nhập';
            modalDesc.textContent = isBuyer ? campaignDesc : 'Vui lòng đăng nhập với vai trò Người mua để tham gia chiến dịch.';

            if (isBuyer) {
                contributionInput.innerHTML = `
                    <label for="contributionAmount" class="block text-gray-600 mb-2">Số tiền đóng góp (VND, tùy chọn):</label>
                    <input type="number" id="contributionAmount" placeholder="Nhập số tiền" min="0">
                `;
                modalActions.innerHTML = `
                    <button onclick="confirmJoin(${campaignId})" class="bg-green-600 text-white hover:bg-green-700">Xác nhận Tham gia</button>
                    <button onclick="closeModal()" class="bg-gray-400 text-white hover:bg-gray-500">Hủy</button>
                `;
            } else {
                contributionInput.innerHTML = '';
                modalActions.innerHTML = `
                    <button onclick="window.location.href='login.jsp'" class="bg-yellow-400 text-green-900 hover:bg-yellow-500">Đăng nhập</button>
                    <button onclick="closeModal()" class="bg-gray-400 text-white hover:bg-gray-500">Hủy</button>
                `;
            }

            modal.style.display = 'flex';
        }

        function closeModal() {
            document.getElementById('joinModal').style.display = 'none';
        }

        function confirmJoin(campaignId) {
            const contributionAmount = document.getElementById('contributionAmount').value || 0;
            window.location.href = `campaignDetail?campaignId=${campaignId}&contribution=${contributionAmount}`;
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
                if (document.querySelector('.logout')) document.querySelector('.logout').textContent = 'Đăng xuất';
                if (document.querySelector('.profile')) document.querySelector('.profile').textContent = 'Hồ sơ';
                if (document.querySelector('.header-actions span')) {
                    document.querySelector('.header-actions span').textContent = 'Chào mừng, ' + '<%= user != null ? user : "" %>' + '!';
                }
                document.querySelector('.spotlight-section h2').textContent = 'Tiêu điểm Nông dân';
                document.querySelector('.spotlight-section h3').textContent = 'Anh Nguyễn Văn Tâm, Hải Dương';
                document.querySelector('.spotlight-section p').textContent = 'Nhờ AgriRescue, anh Tâm đã cứu được mùa lúa và mở rộng kinh doanh.';
                document.querySelector('.spotlight-section a').textContent = 'Tìm hiểu thêm';
                document.querySelector('.marketplace-section h2').textContent = 'Sản phẩm Nổi bật';
                document.querySelectorAll('.product-card h3')[0].textContent = 'Dưa hấu Hà Nội';
                document.querySelectorAll('.product-card p')[0].textContent = '15,000 VND/kg';
                document.querySelectorAll('.product-card h3')[1].textContent = 'Rau sạch Đồng Nai';
                document.querySelectorAll('.product-card p')[1].textContent = '20,000 VND/bó';
                document.querySelector('.marketplace-section a.bg-green-700').textContent = 'Xem Thêm Sản phẩm';
                document.querySelectorAll('.product-card a').forEach(a => a.textContent = 'Mua ngay');
                document.querySelector('.tips-events-section h2').textContent = 'Mẹo Theo Mùa & Sự Kiện';
                document.querySelector('.tip-card h3').textContent = 'Mẹo Mùa Mưa';
                document.querySelector('.tip-card p').textContent = 'Đảm bảo thoát nước tốt để tránh ngập úng cho cây lúa.';
                document.querySelector('.tip-card a').textContent = 'Xem Thêm Mẹo';
                document.querySelector('.event-card h3').textContent = 'Hội chợ Nông sản Hà Nội 2025';
                document.querySelectorAll('.event-card p')[0].textContent = 'Ngày: 15/06/2025';
                document.querySelectorAll('.event-card p')[1].textContent = 'Địa điểm: Trung tâm Hội nghị Hà Nội';
                document.querySelector('.event-card a').textContent = 'Đăng ký ngay';
                document.querySelector('.news-section h2').textContent = 'Tin Mới Nhất';
                document.querySelectorAll('.news-card h3')[0].textContent = 'Dưa hấu "giải cứu" bày bán tại lễ hội Hà Nội, giá siêu rẻ';
                document.querySelectorAll('.news-card p')[0].textContent = 'VTV.vn: Tình hình thu hoạch dưa hấu tại Hà Nội đang gặp khó khăn...';
                document.querySelectorAll('.news-card h3')[1].textContent = 'Nhiều cửa khẩu giáp Trung Quốc thông quan trở lại';
                document.querySelectorAll('.news-card p')[1].textContent = 'Thông tin về việc thông quan hàng hóa tại biên giới...';
                document.querySelectorAll('.news-card h3')[2].textContent = 'Đảng cầm quyền Venezuela chiến thắng trong cuộc bầu cử';
                document.querySelectorAll('.news-card p')[2].textContent = 'Tin tức về tình hình chính trị tại Venezuela...';
                document.querySelector('.campaigns-section h2').textContent = 'Chiến dịch Giải cứu';
                document.querySelectorAll('.campaign-card p.text-sm')[0].forEach(p => p.textContent = p.textContent.replace('Support Goal', 'Số tiền cần hỗ trợ'));
                document.querySelectorAll('.campaign-card p.text-sm')[1].forEach(p => p.textContent = p.textContent.replace('Raised', 'Đã hỗ trợ'));
                document.querySelectorAll('.campaign-card p.text-sm')[2].forEach(p => p.textContent = p.textContent.replace('of goal', 'mục tiêu'));
                document.querySelectorAll('.campaign-card button.join-campaign-btn').forEach(btn => btn.textContent = 'Tham gia ngay');
                const noCampaigns = document.querySelector('.campaigns-section p.text-center');
                if (noCampaigns) noCampaigns.textContent = 'Hiện tại không có chiến dịch giải cứu nào.';
                document.querySelector('.cta-banner h2').textContent = 'Cùng chung tay giải cứu nông sản ngay hôm nay!';
                document.querySelector('.cta-banner a').textContent = 'Tham gia ngay';
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
                if (document.querySelector('.logout')) document.querySelector('.logout').textContent = 'Logout';
                if (document.querySelector('.profile')) document.querySelector('.profile').textContent = 'Profile';
                if (document.querySelector('.header-actions span')) {
                    document.querySelector('.header-actions span').textContent = 'Welcome, ' + '<%= user != null ? user : "" %>' + '!';
                }
                document.querySelector('.spotlight-section h2').textContent = 'Farmer Spotlight';
                document.querySelector('.spotlight-section h3').textContent = 'Mr. Nguyen Van Tam, Hai Duong';
                document.querySelector('.spotlight-section p').textContent = 'Thanks to AgriRescue, Mr. Tam saved his rice harvest and expanded his business.';
                document.querySelector('.spotlight-section a').textContent = 'Learn More';
                document.querySelector('.marketplace-section h2').textContent = 'Marketplace Highlights';
                document.querySelectorAll('.product-card h3')[0].textContent = 'Hanoi Watermelon';
                document.querySelectorAll('.product-card p')[0].textContent = '15,000 VND/kg';
                document.querySelectorAll('.product-card h3')[1].textContent = 'Dong Nai Fresh Vegetables';
                document.querySelectorAll('.product-card p')[1].textContent = '20,000 VND/bunch';
                document.querySelector('.marketplace-section a.bg-green-700').textContent = 'See More Products';
                document.querySelectorAll('.product-card a').forEach(a => a.textContent = 'Buy Now');
                document.querySelector('.tips-events-section h2').textContent = 'Seasonal Tips & Events';
                document.querySelector('.tip-card h3').textContent = 'Rainy Season Tip';
                document.querySelector('.tip-card p').textContent = 'Ensure proper drainage to prevent waterlogging for rice crops.';
                document.querySelector('.tip-card a').textContent = 'See More Tips';
                document.querySelector('.event-card h3').textContent = 'Hanoi Agricultural Fair 2025';
                document.querySelectorAll('.event-card p')[0].textContent = 'Date: 15/06/2025';
                document.querySelectorAll('.event-card p')[1].textContent = 'Location: Hanoi Convention Center';
                document.querySelector('.event-card a').textContent = 'Register Now';
                document.querySelector('.news-section h2').textContent = 'Latest News';
                document.querySelectorAll('.news-card h3')[0].textContent = 'Watermelon "Rescue" Sold at Hanoi Festival, Super Cheap';
                document.querySelectorAll('.news-card p')[0].textContent = 'VTV.vn: The watermelon harvest in Hanoi is facing challenges...';
                document.querySelectorAll('.news-card h3')[1].textContent = 'Several Border Gates with China Reopen';
                document.querySelectorAll('.news-card p')[1].textContent = 'Information on the reopening of trade at the border...';
                document.querySelectorAll('.news-card h3')[2].textContent = 'Ruling Party Wins Election in Venezuela';
                document.querySelectorAll('.news-card p')[2].textContent = 'News on the political situation in Venezuela...';
                document.querySelector('.campaigns-section h2').textContent = 'Rescue Campaigns';
                document.querySelectorAll('.campaign-card p.text-sm')[0].forEach(p => p.textContent = p.textContent.replace('Số tiền cần hỗ trợ', 'Support Goal'));
                document.querySelectorAll('.campaign-card p.text-sm')[1].forEach(p => p.textContent = p.textContent.replace('Đã hỗ trợ', 'Raised'));
                document.querySelectorAll('.campaign-card p.text-sm')[2].forEach(p => p.textContent = p.textContent.replace('mục tiêu', 'of goal'));
                document.querySelectorAll('.campaign-card button.join-campaign-btn').forEach(btn => btn.textContent = 'Join Now');
                const noCampaigns = document.querySelector('.campaigns-section p.text-center');
                if (noCampaigns) noCampaigns.textContent = 'No rescue campaigns available at the moment.';
                document.querySelector('.cta-banner h2').textContent = 'Join Hands to Rescue Agricultural Products Today!';
                document.querySelector('.cta-banner a').textContent = 'Join Now';
            }
        }
    </script>
</body>
</html>