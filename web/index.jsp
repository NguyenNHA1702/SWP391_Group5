<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Campaign" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


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
            .feature-card, .campaign-card {
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }
            .feature-card:hover, .campaign-card:hover {
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
            List<Campaign> campaigns = (List<Campaign>) request.getAttribute("campaigns");
            NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
        %>
        <header class="header sticky top-0 z-50 shadow-lg py-4 px-6 flex justify-between items-center">
            <div class="flex items-center space-x-4">
                <select onchange="changeLanguage(this.value)" class="bg-white border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
                    <option value="en">English</option>
                    <option value="vi">Tiếng Việt</option>
                </select>
                <h1 class="text-2xl font-bold text-white">AgriRescue</h1>
                <%
        String ctx = request.getContextPath();
        String homeLink = (user != null) ? ctx + "/home" : ctx + "/index.jsp";
                %>
                <a href="<%= homeLink %>" class="home-btn bg-green-800 text-white px-4 py-2 rounded-lg hover:bg-green-900 transition">Home Page</a>

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

        <c:if test="${sessionScope.role == 'farmer' || sessionScope.role == 'admin'}">
            <div class="fixed top-20 right-6 z-50 bg-yellow-200 border border-yellow-500 text-yellow-800 px-4 py-2 rounded-lg shadow-lg flex items-center space-x-2">
                <span>🔔</span>
                <span>
                    <c:choose>
                        <c:when test="${pendingJoinRequests > 0}">
                            ${pendingJoinRequests} yêu cầu tham gia chiến dịch đang chờ duyệt
                        </c:when>
                        <c:otherwise>
                            Không có yêu cầu mới
                        </c:otherwise>
                    </c:choose>
                </span>
                <a href="${pageContext.request.contextPath}/ViewJoinRequestsServlet" class="ml-4 text-blue-700 underline hover:text-blue-900">Xem</a>

            </div>
        </c:if>


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
                     <% if (user != null && "farmer".equalsIgnoreCase(role)) { %>

                     onclick="location.href = 'campaigns'"
                     style="cursor:pointer;"
                     <% } else if (user == null) { %>
                     onclick="alert('Please login to access Campaigns'); location.href = 'login.jsp';"
                     style="cursor:not-allowed; opacity: 0.6;"
                     <% } else { %>
                     onclick="alert('Only farmers can access this section.');"
                     style="cursor:not-allowed; opacity: 0.6;"
                     <% } %>>
                    <h3 class="text-xl font-semibold text-green-700 mb-2">Campaign</h3>
                    <p class="text-gray-600">Campaigns for farmers.</p>
                </div>
            </div>

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
                                    status = "Ended";
                                } else if (diffInDays <= 3) {
                                    status = "Ending Soon";
                                } else {
                                    status = "Ongoing";
                                }

                                double progress = (campaign.getCurrentAmount() / campaign.getGoalAmount()) * 100;
                                String description = campaign.getDescription() != null ? campaign.getDescription() : "";
                                String shortDesc = description.length() > 100 ? description.substring(0, 100) + "..." : description;
                    %>
                    <div class="campaign-card bg-white rounded-xl shadow-md p-6">
                        <%
     String imageUrl = campaign.getImageUrl(); // đảm bảo có getter
     String imagePath = imageUrl != null && !imageUrl.isEmpty()
                        ? request.getContextPath() + imageUrl
                        : request.getContextPath() + "/assets/images/default.jpg"; // fallback ảnh mặc định
                        %>
                        <img src="<%= imagePath %>" alt="Campaign Image" class="w-full h-40 object-cover rounded-lg mb-4">


                        <h3 class="text-xl font-semibold text-green-700 mb-2"><%= campaign.getTitle() %></h3>
                        <p class="text-gray-600 mb-2"><%= shortDesc %></p>
                        <p class="text-sm text-red-600 font-semibold countdown" data-end-time="<%= end.getTime() %>">
                            ⏳ calculating...
                        </p>

                        <span class="inline-block mt-1 mb-3 px-3 py-1 rounded-full text-white
                              <%= "Ended".equals(status) ? "bg-gray-500" :
                                   "Ending Soon".equals(status) ? "bg-yellow-500" :
                                   "bg-green-600" %>">
                            <%= status %>
                        </span>
                        <div class="mb-4">
                            <p class="text-sm text-gray-500">Support Goal: <%= currencyFormat.format(campaign.getGoalAmount()) %></p>
                            <p class="text-sm text-gray-500">Raised: <%= currencyFormat.format(campaign.getCurrentAmount()) %></p>
                            <div class="w-full bg-gray-200 rounded-full h-2.5 mt-2">
                                <div class="progress-bar h-2.5 rounded-full" style="width: <%= progress %>%"></div>
                            </div>
                            <p class="text-sm text-gray-500 mt-1"><%= String.format("%.0f%%", progress) %> of goal</p>
                        </div>
                        <% if ("farmer".equals(role)) { %>
                        <a href="<%= request.getContextPath() %>/farmer/inventory?campaignId=<%= campaign.getCampaignId() %>"
                           class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition w-full text-center block">
                            📦 Access Inventory
                        </a>

                        <% } else { %>
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
                        <% } %>

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
                <h2 class="text-3xl font-bold mb-4">Join Hands to Rescue Agricultural Products Today!</h2>
                <%
                    if (user == null) {
                %>
                <a href="signup.jsp" class="bg-green-700 text-white px-6 py-3 rounded-lg hover:bg-green-800 transition">Join Now</a>
                <%
                    } else {
                %>
                <a href="browse" class="bg-green-700 text-white px-6 py-3 rounded-lg hover:bg-green-800 transition">Browse Campaigns</a>
                <%
                    }
                %>
            </section>

            <%
                if (user == null) {
            %>
            <p class="text-center text-gray-600">Login or Sign Up to access more features like creating campaigns and managing your inventory.</p>
            <%
                } else {
            %>
            <p class="text-center text-gray-600">Explore more features like creating campaigns and managing your inventory.</p>
            <%
                }
            %>
        </main>

        <footer class="footer fixed bottom-0 w-full py-4 px-6 flex justify-between items-center text-white">
            <div class="contact-help">
                <a href="/SWP391_webgiaicuunongsan/Contact" onclick="navigate('Contact / Help Center')" class="hover:underline">Contact / Help Center</a>
            </div>
            <div class="faq flex items-center space-x-2">
                <a href="/SWP391_webgiaicuunongsan/faq" onclick="navigate('FAQs')" class="hover:underline">FAQs</a>
                <div class="faq-circle bg-white text-green-700 w-6 h-6 rounded-full flex items-center justify-center cursor-pointer" onclick="navigate('FAQs')">?</div>
            </div>
        </footer>

        <script>
            let currentCampaignId = null; // 🔧 Biến toàn cục để giữ campaignId

            function showJoinModal(campaignId, campaignTitle, campaignDesc, isBuyer) {
                currentCampaignId = campaignId; // ✅ Gán lại mỗi khi mở modal

                const modal = document.getElementById('joinModal');
                const modalTitle = document.getElementById('modalTitle');
                const modalDesc = document.getElementById('modalDesc');
                const contributionInput = document.getElementById('contributionInput');
                const modalActions = document.getElementById('modalActions');

                modalTitle.textContent = isBuyer ? `Join Campaign: ${campaignTitle}` : 'Login Required';
                modalDesc.textContent = isBuyer ? campaignDesc : 'Please login as a buyer to join the campaign.';

                if (isBuyer) {
                    contributionInput.innerHTML = `
                  <div class="flex flex-col gap-4">
                      <button onclick="viewCampaignProducts()" class="bg-green-500 text-white px-4 py-2 rounded">📦 View Products</button>

                      <button onclick="selectJoinType('volunteer')" class="bg-blue-500 text-white px-4 py-2 rounded">🤝 Volunteer to Join</button>
                      <div id="joinForm" class="mt-4"></div>
                  </div>
              `;
                    modalActions.innerHTML = `
                  <button onclick="closeModal()" class="mt-4 bg-gray-400 text-white hover:bg-gray-500 px-4 py-2 rounded">Cancel</button>
              `;
                } else {
                    contributionInput.innerHTML = '';
                    modalActions.innerHTML = `
                  <button onclick="window.location.href='login.jsp'" class="bg-yellow-400 text-green-900 hover:bg-yellow-500 px-4 py-2 rounded">Login</button>
                  <button onclick="closeModal()" class="bg-gray-400 text-white hover:bg-gray-500 px-4 py-2 rounded">Cancel</button>
              `;
                }

                modal.style.display = 'flex';
            }

            function viewCampaignProducts() {
                if (currentCampaignId) {
                    window.location.href = '<%= request.getContextPath() %>/farmer/inventory?campaignId=' + currentCampaignId;

                } else {
                    alert("❌ Campaign ID is missing.");
                }
            }


            function selectJoinType(type) {
                const formDiv = document.getElementById('joinForm');
                if (type === 'money') {
                    formDiv.innerHTML = `
                  <label class="block text-left text-sm mb-2">Amount (VND):</label>
                  <input type="number" id="contributionAmount" class="border w-full p-2 rounded" placeholder="e.g. 50000">
                  <button onclick="confirmJoin()" class="mt-2 bg-green-600 text-white px-4 py-2 rounded">Confirm Contribution</button>
              `;
                } else if (type === 'volunteer') {
                    formDiv.innerHTML = `
                  <label class="block text-left text-sm mb-1">Full Name:</label>
                  <input type="text" id="fullName" class="border w-full p-2 rounded" placeholder="Your full name" required>
                  <label class="block text-left text-sm mb-1">Email:</label>
                  <input type="email" id="email" class="border w-full p-2 rounded" placeholder="you@example.com" required>
                  <label class="block text-left text-sm mb-1">Phone Number:</label>
                  <input type="tel" id="phone" class="border w-full p-2 rounded" placeholder="e.g. 0901234567" required>
                  <label class="block text-left text-sm mb-1">Why do you want to join this campaign?</label>
                  <textarea id="reason" rows="3" class="border w-full p-2 rounded" placeholder="I want to help..." required></textarea>
                  <button onclick="submitVolunteerRequest()" class="mt-2 bg-blue-600 text-white px-4 py-2 rounded">Send Request</button>
              `;
                }
            }

            function confirmJoin() {
                const amount = document.getElementById('contributionAmount').value;
                if (!amount || amount <= 0) {
                    alert("Please enter a valid amount.");
                    return;
                }
                window.location.href = `campaignDetail?campaignId=${currentCampaignId}&contribution=${amount}`;
            }

            function submitVolunteerRequest() {
                const fullName = document.getElementById('fullName').value.trim();
                const email = document.getElementById('email').value.trim();
                const phone = document.getElementById('phone').value.trim();
                const reason = document.getElementById('reason').value.trim();

//                if (!fullName || !email || !phone || !reason) {
//                    alert("Please fill in all required fields.");
//                    return;
//                }


                if (!fullName) {
                    alert("❌ Vui lòng nhập Họ và tên.");
                    return;
                }
                if (!email) {
                    alert("❌ Vui lòng nhập Email.");
                    return;
                }
                if (!phone) {
                    alert("❌ Vui lòng nhập Số điện thoại.");
                    return;
                }
                if (!reason) {
                    alert("❌ Vui lòng nhập lý do bạn muốn tham gia chiến dịch");
                    return;
                }



                fetch('<%= request.getContextPath() %>/JoinRequestServlet', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body:
                            'campaignId=' + encodeURIComponent(currentCampaignId) +
                            '&fullName=' + encodeURIComponent(fullName) +
                            '&email=' + encodeURIComponent(email) +
                            '&phone=' + encodeURIComponent(phone) +
                            '&reason=' + encodeURIComponent(reason)
                })
                        .then(response => response.text().then(text => {
                                if (!response.ok)
                                    throw new Error(text);
                                alert("✅ " + text);
                                closeModal();
                            }))
                        .catch(error => {
                            alert("❌ Failed to send request: " + error.message);
                        });
            }

            function closeModal() {
                document.getElementById('joinModal').style.display = 'none';
            }

            // Hàm cập nhật thời gian còn lại
            function updateCountdowns() {
                const now = new Date().getTime();
                document.querySelectorAll('.countdown').forEach(el => {
                    const endTime = parseInt(el.getAttribute('data-end-time'), 10);
                    const distance = endTime - now;
                    if (distance <= 0) {
                        el.textContent = '⏳ Ended';
                    } else {
                        const days = Math.floor(distance / (1000 * 60 * 60 * 24));
                        const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                        el.textContent = `⏳ ${days} days ${hours} hours left`;
                    }
                });
            }

// Chạy khi tải trang
            updateCountdowns();

// Tự động cập nhật mỗi phút
            setInterval(updateCountdowns, 60000);




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
                    if (document.querySelector('p.text-center')) {
                        document.querySelector('p.text-center').textContent = "<%= user == null ? "Đăng nhập hoặc Đăng ký để truy cập thêm các tính năng như tạo chiến dịch và quản lý kho hàng." : "Khám phá thêm các tính năng như tạo chiến dịch và quản lý kho hàng." %>";
                    }
                    document.querySelector('.contact-help a').textContent = 'Liên hệ / Trung tâm Hỗ trợ';
                    document.querySelector('.faq a').textContent = 'Câu hỏi thường gặp';
                    document.querySelector('.home-btn').textContent = 'Trang chủ';
                    if (document.querySelector('.login'))
                        document.querySelector('.login').textContent = 'Đăng nhập';
                    if (document.querySelector('.signup'))
                        document.querySelector('.signup').textContent = 'Đăng ký';
                    if (document.querySelector('.logout'))
                        document.querySelector('.logout').textContent = 'Đăng xuất';
                    if (document.querySelector('.profile'))
                        document.querySelector('.profile').textContent = 'Hồ sơ';
                    document.querySelector('.campaigns-section h2').textContent = 'Chiến dịch Giải cứu';
                    document.querySelector('.cta-banner h2').textContent = 'Cùng chung tay giải cứu nông sản ngay hôm nay!';
                    if (document.querySelector('.cta-banner a')) {
                        document.querySelector('.cta-banner a').textContent = "<%= user == null ? "Tham gia ngay" : "Duyệt Chiến dịch" %>";
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
                    if (document.querySelector('p.text-center')) {
                        document.querySelector('p.text-center').textContent = "<%= user == null ? "Login or Sign Up to access more features like creating campaigns and managing your inventory." : "Explore more features like creating campaigns and managing your inventory." %>";
                    }
                    document.querySelector('.contact-help a').textContent = 'Contact / Help Center';
                    document.querySelector('.faq a').textContent = 'FAQs';
                    document.querySelector('.home-btn').textContent = 'Home Page';
                    if (document.querySelector('.login'))
                        document.querySelector('.login').textContent = 'Login';
                    if (document.querySelector('.signup'))
                        document.querySelector('.signup').textContent = 'Sign Up';
                    if (document.querySelector('.logout'))
                        document.querySelector('.logout').textContent = 'Logout';
                    if (document.querySelector('.profile'))
                        document.querySelector('.profile').textContent = 'Profile';
                    document.querySelector('.campaigns-section h2').textContent = 'Rescue Campaigns';
                    document.querySelector('.cta-banner h2').textContent = 'Join Hands to Rescue Agricultural Products Today!';
                    if (document.querySelector('.cta-banner a')) {
                        document.querySelector('.cta-banner a').textContent = "<%= user == null ? "Join Now" : "Browse Campaigns" %>";
                    }
                }
            }
        </script>
    </body>
</html>