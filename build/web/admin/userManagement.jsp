<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Management</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .table th, .table td {
            text-align: center;
            vertical-align: middle;
        }
        .action-buttons {
            display: flex;
            gap: 5px;
            justify-content: center;
        }
        .search-filter {
            margin-bottom: 20px;
            display: flex;
            gap: 10px;
        }
        .search-input {
            width: 300px;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h2>User Management</h2>

    <!-- Back -->
    <div class="mb-3">
        <a href="http://localhost:8080/SWP391_webgiaicuunongsan/Admin/adminDashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
    </div>

    <!-- Search and filter -->
    <div class="search-filter">
        <form action="userManagement" method="get" style="display: flex; gap: 10px;">
            <input type="text" name="search" placeholder="Search by ID, name, or email..." class="form-control search-input" value="${param.search}">
            <select name="status" class="form-select">
                <option value="">All Status</option>
                <option value="Pending" ${param.status == 'Pending' ? 'selected' : ''}>Pending</option>
                <option value="Active" ${param.status == 'Active' ? 'selected' : ''}>Active</option>
                <option value="Deactivated" ${param.status == 'Deactivated' ? 'selected' : ''}>Deactivated</option>
            </select>
            <button type="submit" class="btn btn-primary">Filter</button>
        </form>
    </div>

    <table class="table table-striped">
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Phone Number</th>
            <th>Role</th>
            <th>Status</th>
            <th>Actions</th>
            <th>Document</th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${users == null || users.isEmpty()}">
            <tr><td colspan="8">No users found.</td></tr>
        </c:if>
        <c:forEach var="user" items="${users}">
            <tr>
                <td>${user.userId}</td>
                <td>${user.fullName}</td>
                <td>${user.email}</td>
                <td>${user.phone}</td>
                <td>${user.role}</td>
                <td>
                    <c:choose>
                        <c:when test="${empty user.approved}">Pending</c:when>
                        <c:when test="${user.approved == true}">Active</c:when>
                        <c:otherwise>Deactivated</c:otherwise>
                    </c:choose>
                </td>
                <td class="action-buttons">
                    <c:choose>
                        <c:when test="${empty user.approved or user.approved == false}">
                            <form action="userManagement" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="activate"/>
                                <input type="hidden" name="id" value="${user.userId}"/>
                                <button type="submit" class="btn btn-sm btn-success">Activate</button>
                            </form>
                        </c:when>
                        <c:when test="${user.approved == true}">
                            <form action="userManagement" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="deactivate"/>
                                <input type="hidden" name="id" value="${user.userId}"/>
                                <button type="submit" class="btn btn-sm btn-danger">Deactivate</button>
                            </form>
                        </c:when>
                    </c:choose>
                </td>
                <td>
                    <c:if test="${user.role eq 'farmer' and not empty user.documentPath}">
                        <a href="${pageContext.request.contextPath}/${user.documentPath}" 
                           class="btn btn-sm btn-info" target="_blank">View Document</a>
                    </c:if>
                    <c:if test="${empty user.documentPath}">
                        No document
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>