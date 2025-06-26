<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>AgriRescue - Admin Dashboard</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <style>
            :root {
                --primary-green: #28a745;
                --secondary-green: #4caf50;
                --light-green: #e8f5e9;
                --dark-green: #1b5e20;
                --accent-yellow: #ffc107;
                --icon-campaign: #2e7d32; /* Green for campaigns */
                --icon-users: #0288d1; /* Blue for users */
                --icon-requests: #f57c00; /* Orange for join requests */
                --icon-notifications: #d32f2f; /* Red for notifications */
                --icon-stats: #7b1fa2; /* Purple for statistics */
                --icon-messages: #6d28d9; /* Purple for messages */
            }

            body {
                background-color: var(--light-green);
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .navbar {
                background-color: var(--primary-green);
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            .navbar-brand img {
                height: 40px;
            }

            .card {
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                border-radius: 10px;
                border: none;
                overflow: hidden;
            }

            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            }

            .card-header {
                background: linear-gradient(135deg, var(--primary-green), var(--secondary-green));
                color: white;
                font-weight: 600;
                padding: 15px;
            }

            .card-body {
                background-color: white;
                padding: 20px;
            }

            .btn-custom {
                background-color: var(--primary-green);
                color: white;
                border-radius: 20px;
                padding: 10px 20px;
                transition: background-color 0.3s ease;
            }

            .btn-custom:hover {
                background-color: var(--dark-green);
            }

            .logout-btn {
                background-color: var(--accent-yellow);
                color: var(--dark-green);
                border-radius: 20px;
            }

            .logout-btn:hover {
                background-color: #e0a800;
            }

            .messages-btn {
                background-color: var(--icon-messages);
                color: white;
                border-radius: 20px;
                position: relative;
            }

            .messages-btn:hover {
                background-color: #5b21b6;
            }

            .unread-badge {
                background-color: var(--icon-notifications);
                color: white;
                border-radius: 9999px;
                padding: 2px 8px;
                font-size: 12px;
                position: absolute;
                top: -10px;
                right: -10px;
            }

            .dashboard-title {
                color: var(--dark-green);
                font-weight: 700;
                text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);
            }

            .icon {
                font-size: 1.5rem;
                margin-right: 10px;
            }

            .icon-campaign {
                color: var(--icon-campaign);
            }
            .icon-users {
                color: var(--icon-users);
            }
            .icon-requests {
                color: var(--icon-requests);
            }
            .icon-notifications {
                color: var(--icon-notifications);
            }
            .icon-stats {
                color: var(--icon-stats);
            }
            .icon-messages {
                color: var(--icon-messages);
            }
        </style>
    </head>
    <body>
        <%
            Integer unreadMessages = (Integer) session.getAttribute("unreadMessages");
            if (unreadMessages == null) unreadMessages = 0;
            String messageBadge = (unreadMessages > 99) ? "99+" : unreadMessages.toString();
        %>
        <nav class="navbar navbar-expand-lg">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">
                    <span class="ms-2 text-white">AgriRescue</span>
                </a>
                <div class="ms-auto d-flex align-items-center gap-3">
                    <a href="${pageContext.request.contextPath}/messages.jsp" class="btn messages-btn">
                        <i class="fas fa-envelope icon icon-messages"></i>Messages
                        <c:if test="${unreadMessages > 0}">
                            <span class="unread-badge">${messageBadge}</span>
                        </c:if>
                    </a>
                    <a href="${pageContext.request.contextPath}/login.jsp" class="btn logout-btn">
                        <i class="fas fa-sign-out-alt icon"></i>Logout
                    </a>
                </div>
            </div>
        </nav>

        <div class="container mt-5">
            <h2 class="dashboard-title text-center mb-4">🌱 Admin Dashboard</h2>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-header">
                            <i class="fas fa-seedling icon icon-campaign"></i>Manage Campaigns
                        </div>
                        <div class="card-body">
                            <p class="card-text">Review, approve, or delete agricultural rescue campaigns.</p>
                            <a href="ManageCampaignsServlet" class="btn btn-custom">Go to Campaigns</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card">
                        <div class="card-header">
                            <i class="fas fa-users icon icon-users"></i>Manage Users
                        </div>
                        <div class="card-body">
                            <p class="card-text">View all users and manage spam or blocked accounts.</p>
                            <a href="${pageContext.request.contextPath}/userManagement" class="btn btn-custom">Go</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card">
                        <div class="card-header">
                            <i class="fas fa-handshake icon icon-requests"></i>Join Requests
                        </div>
                        <div class="card-body">
                            <p class="card-text">Approve or decline join requests for campaigns.</p>
                            <a href="ViewJoinRequestsServlet" class="btn btn-custom">Go to Requests</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card">
                        <div class="card-header">
                            <i class="fas fa-bell icon icon-notifications"></i>Notifications
                        </div>
                        <div class="card-body">
                            <p class="card-text">Send notifications to all users or specific roles.</p>
                            <a href="SendNotification.jsp" class="btn btn-custom">Go to Notifications</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card">
                        <div class="card-header">
                            <i class="fas fa-chart-bar icon icon-stats"></i>Statistics
                        </div>
                        <div class="card-body">
                            <p class="card-text">View counts of campaigns, users, and products.</p>
                            <a href="AdminStatsServlet" class="btn btn-custom">Go to Stats</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>