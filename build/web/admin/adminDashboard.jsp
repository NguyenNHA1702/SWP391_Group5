<%-- 
    Document   : adminDashboard
    Created on : 10 Jun 2025, 09:02:44
    Author     : HP
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>AgriRescue - Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-4">
        <h2 class="text-success">🌿 Admin Dashboard</h2>
        <hr>

        <div class="row g-4">
            <div class="col-md-4">
                <div class="card border-success">
                    <div class="card-body">
                        <h5 class="card-title">📁 Manage Campaigns</h5>
                        <p class="card-text">Review, approve or delete campaigns.</p>
                        <a href="ManageCampaignsServlet" class="btn btn-success">Go</a>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card border-primary">
                    <div class="card-body">
                        <h5 class="card-title">👥 Manage Users</h5>
                        <p class="card-text">View all users, block/report spam accounts.</p>
                        <a href="ManageUsersServlet" class="btn btn-primary">Go</a>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card border-warning">
                    <div class="card-body">
                        <h5 class="card-title">📨 Join Requests</h5>
                        <p class="card-text">Approve or decline join requests for campaigns.</p>
                        <a href="ViewJoinRequestsServlet" class="btn btn-warning">Go</a>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card border-danger">
                    <div class="card-body">
                        <h5 class="card-title">🔔 Send Notifications</h5>
                        <p class="card-text">Notify all users or specific roles.</p>
                        <a href="SendNotification.jsp" class="btn btn-danger">Go</a>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card border-info">
                    <div class="card-body">
                        <h5 class="card-title">📊 Statistics</h5>
                        <p class="card-text">See current counts of campaigns, users, products.</p>
                        <a href="AdminStatsServlet" class="btn btn-info">Go</a>
                    </div>
                </div>
            </div>
        </div>

        <hr>
        <a href="LogoutServlet" class="btn btn-outline-secondary mt-3">🚪 Logout</a>
    </div>
</body>
</html>

