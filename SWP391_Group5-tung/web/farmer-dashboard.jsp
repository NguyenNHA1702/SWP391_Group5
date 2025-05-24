<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Farmer Dashboard - AgriRescue</title>
        <style>
            body {
                font-family: 'Arial', sans-serif;
                margin: 0;
                padding: 0;
                background: linear-gradient(to right, #a3bffa, #d4c4fb);
                background-image: url('https://via.placeholder.com/1920x1080?text=Agricultural+Background');
                background-size: cover;
                background-position: center;
                min-height: 100vh;
                display: flex;
                flex-direction: column;
            }
            .header {
                width: 100%;
                padding: 15px 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: rgba(46, 125, 50, 0.8);
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            }
            .header-title {
                font-size: 24px;
                font-weight: bold;
                color: #fff;
            }
            .header-right {
                display: flex;
                align-items: center;
            }
            .welcome-message {
                color: #fff;
                margin-right: 20px;
            }
            .logout-btn, .action-btn {
                color: #fff;
                text-decoration: none;
                padding: 8px 15px;
                border-radius: 5px;
                background-color: #1b5e20;
                margin-left: 10px;
                transition: background-color 0.3s;
            }
            .logout-btn:hover, .action-btn:hover {
                background-color: #124116;
            }
            .language-switch {
                margin-left: 20px;
            }
            .language-switch select {
                padding: 5px;
                border-radius: 5px;
                background-color: #fff;
                border: 1px solid #ccc;
                cursor: pointer;
            }
            .main-container {
                flex: 1;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 20px;
            }
            .dashboard {
                background-color: rgba(255, 255, 255, 0.9);
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 800px;
                text-align: center;
            }
            .dashboard h2 {
                margin-bottom: 20px;
                font-size: 24px;
                color: #2e7d32;
            }
            .section {
                margin: 20px 0;
                padding: 15px;
                background-color: #f9f9f9;
                border-radius: 5px;
                text-align: left;
            }
            .section h3 {
                margin-bottom: 10px;
                color: #2e7d32;
            }
            .section ul {
                list-style-type: none;
                padding: 0;
            }
            .section li {
                padding: 5px 0;
            }
        </style>
    </head>
    <body>
        <%
            // Kiểm tra đăng nhập và vai trò
            String userName = (String) session.getAttribute("user_name");
            String userRole = (String) session.getAttribute("user_role");
            if (userName == null || !"farmer".equals(userRole)) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>

        <div class="header">
            <div class="header-title">AgriRescue</div>
            <div class="header-right">
                <span class="welcome-message" id="welcome-message">Welcome, <%=userName%>!</span>
                <a href="createCampaign.jsp" class="action-btn" id="create-campaign-btn">Create Campaign</a>

                <a href="#" class="action-btn" onclick="editCampaign()" id="edit-campaign-btn">Edit Campaign</a>
                <a href="LogoutServlet" class="logout-btn" id="logout-btn">Logout</a>
                <div class="language-switch">
                    <select onchange="changeLanguage(this.value)">
                        <option value="en">English</option>
                        <option value="vi">Tiếng Việt</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="main-container">
            <div class="dashboard">
                <h2 id="dashboard-title">Farmer Dashboard</h2>

                <div class="section">
                    <h3 id="campaign-status-title">Campaign Status Dashboard</h3>
                    <ul id="campaign-status-list">
                        <!-- Danh sách trạng thái chiến dịch sẽ được tải động -->
                    </ul>
                </div>

                <div class="section">
                    <h3 id="my-campaigns-title">My Campaigns</h3>
                    <ul id="my-campaigns-list">
                        <!-- Danh sách chiến dịch của tôi sẽ được tải động -->
                    </ul>
                </div>

                <div class="section">
                    <h3 id="campaign-analytics-title">Campaign Analytics</h3>
                    <ul id="campaign-analytics-list">
                        <!-- Phân tích chiến dịch sẽ được tải động -->
                    </ul>
                </div>

                <div class="section">
                    <h3 id="my-inventory-title">My Inventory</h3>
                    <ul id="my-inventory-list">
                        <!-- Danh sách kho hàng sẽ được tải động -->
                    </ul>
                </div>
            </div>
        </div>

        <script>
            function changeLanguage(lang) {
                if (lang === 'vi') {
                    document.getElementById('welcome-message').textContent = 'Xin chào, <%=userName%>!';
                    document.getElementById('logout-btn').textContent = 'Đăng xuất';
                    document.getElementById('dashboard-title').textContent = 'Bảng điều khiển nông dân';
                    document.getElementById('campaign-status-title').textContent = 'Bảng điều khiển trạng thái chiến dịch';
                    document.getElementById('my-campaigns-title').textContent = 'Chiến dịch của tôi';
                    document.getElementById('campaign-analytics-title').textContent = 'Phân tích chiến dịch';
                    document.getElementById('my-inventory-title').textContent = 'Kho hàng của tôi';
                    document.getElementById('create-campaign-btn').textContent = 'Tạo chiến dịch';
                    document.getElementById('edit-campaign-btn').textContent = 'Sửa chiến dịch';
                } else {
                    document.getElementById('welcome-message').textContent = 'Welcome, <%=userName%>!';
                    document.getElementById('logout-btn').textContent = 'Logout';
                    document.getElementById('dashboard-title').textContent = 'Farmer Dashboard';
                    document.getElementById('campaign-status-title').textContent = 'Campaign Status Dashboard';
                    document.getElementById('my-campaigns-title').textContent = 'My Campaigns';
                    document.getElementById('campaign-analytics-title').textContent = 'Campaign Analytics';
                    document.getElementById('my-inventory-title').textContent = 'My Inventory';
                    document.getElementById('create-campaign-btn').textContent = 'Create Campaign';
                    document.getElementById('edit-campaign-btn').textContent = 'Edit Campaign';
                }
                loadCampaignStatus(lang);
                loadMyCampaigns(lang);
                loadCampaignAnalytics(lang);
                loadMyInventory(lang);
            }

            function loadCampaignStatus(lang) {
                fetch('GetCampaignStatusServlet', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: 'language=' + encodeURIComponent(lang)
                })
                        .then(response => response.json())
                        .then(data => {
                            const campaignStatusList = document.getElementById('campaign-status-list');
                            campaignStatusList.innerHTML = '';
                            if (data.length === 0) {
                                campaignStatusList.innerHTML = lang === 'vi' ? '<li>Chưa có chiến dịch nào.</li>' : '<li>No campaigns yet.</li>';
                            } else {
                                data.forEach(campaign => {
                                    campaignStatusList.innerHTML += `<li>${campaign.title} - ${campaign.status}</li>`;
                                });
                            }
                        })
                        .catch(error => console.error('Error loading campaign status:', error));
            }

            function loadMyCampaigns(lang) {
                fetch('GetMyCampaignsServlet', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: 'language=' + encodeURIComponent(lang)
                })
                        .then(response => response.json())
                        .then(data => {
                            const myCampaignsList = document.getElementById('my-campaigns-list');
                            myCampaignsList.innerHTML = '';
                            if (data.length === 0) {
                                myCampaignsList.innerHTML = lang === 'vi' ? '<li>Chưa có chiến dịch nào.</li>' : '<li>No campaigns yet.</li>';
                            } else {
                                data.forEach(campaign => {
                                    myCampaignsList.innerHTML += `<li>${campaign.title} - ${campaign.current_amount}/${campaign.goal_amount}</li>`;
                                });
                            }
                        })
                        .catch(error => console.error('Error loading my campaigns:', error));
            }

            function loadCampaignAnalytics(lang) {
                fetch('GetCampaignAnalyticsServlet', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: 'language=' + encodeURIComponent(lang)
                })
                        .then(response => response.json())
                        .then(data => {
                            const campaignAnalyticsList = document.getElementById('campaign-analytics-list');
                            campaignAnalyticsList.innerHTML = '';
                            if (data.length === 0) {
                                campaignAnalyticsList.innerHTML = lang === 'vi' ? '<li>Chưa có dữ liệu phân tích.</li>' : '<li>No analytics data yet.</li>';
                            } else {
                                data.forEach(analytics => {
                                    campaignAnalyticsList.innerHTML += `<li>${analytics.title} - Views: ${analytics.view_count}, Donations: ${analytics.donation_count}</li>`;
                                });
                            }
                        })
                        .catch(error => console.error('Error loading campaign analytics:', error));
            }

            function loadMyInventory(lang) {
                fetch('GetMyInventoryServlet', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: 'language=' + encodeURIComponent(lang)
                })
                        .then(response => response.json())
                        .then(data => {
                            const myInventoryList = document.getElementById('my-inventory-list');
                            myInventoryList.innerHTML = '';
                            if (data.length === 0) {
                                myInventoryList.innerHTML = lang === 'vi' ? '<li>Chưa có sản phẩm nào.</li>' : '<li>No products yet.</li>';
                            } else {
                                data.forEach(product => {
                                    myInventoryList.innerHTML += `<li>${product.name} - ${product.price} (${product.quantity})</li>`;
                                });
                            }
                        })
                        .catch(error => console.error('Error loading my inventory:', error));
            }

            function createCampaign() {
                window.location.href = 'createCampaign.jsp';
            }

            function editCampaign() {
                window.location.href = 'editCampaign.jsp';
            }

            function viewOrders() {
                window.location.href = 'viewOrders.jsp';
            }

            // Tải dữ liệu ban đầu
            loadCampaignStatus('en');
            loadMyCampaigns('en');
            loadCampaignAnalytics('en');
            loadMyInventory('en');
        </script>
    </body>
</html>