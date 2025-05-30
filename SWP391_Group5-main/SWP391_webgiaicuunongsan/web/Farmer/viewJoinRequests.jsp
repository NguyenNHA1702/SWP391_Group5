<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.JoinRequest" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Join Requests</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 p-8">
    <div class="max-w-5xl mx-auto bg-white rounded shadow p-6">

        <!-- Header + Quay về trang chủ -->
        <div class="flex justify-between items-center mb-4">
            <h2 class="text-2xl font-bold text-green-700">📥 Join Requests</h2>
            <a href="${pageContext.request.contextPath}/home" class="bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded">
                ⬅ Quay về trang chủ
            </a>
        </div>

        <c:if test="${empty joinRequests}">
            <p class="text-gray-600">No pending requests.</p>
        </c:if>

        <c:if test="${not empty joinRequests}">
            <table class="min-w-full table-auto border-collapse border border-gray-300">
                <thead class="bg-green-100">
                    <tr>
                        <th class="border border-gray-300 px-4 py-2">Campaign</th>
                        <th class="border border-gray-300 px-4 py-2">Full Name</th>
                        <th class="border border-gray-300 px-4 py-2">Email</th>
                        <th class="border border-gray-300 px-4 py-2">Phone</th>
                        <th class="border border-gray-300 px-4 py-2">Reason</th>
                        <th class="border border-gray-300 px-4 py-2">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="req" items="${joinRequests}">
                        <tr class="hover:bg-gray-50">
                            <td class="border border-gray-300 px-4 py-2">${req.campaignTitle}</td>
                            <td class="border border-gray-300 px-4 py-2">${req.fullName}</td>
                            <td class="border border-gray-300 px-4 py-2">${req.email}</td>
                            <td class="border border-gray-300 px-4 py-2">${req.phone}</td>
                            <td class="border border-gray-300 px-4 py-2">${req.reason}</td>
                            <td class="border border-gray-300 px-4 py-2 space-x-2">
                                <form method="post" action="ProcessJoinRequestServlet" style="display:inline;">
                                    <input type="hidden" name="requestId" value="${req.id}" />
                                    <input type="hidden" name="action" value="approve" />
                                    <button type="submit" class="bg-green-500 hover:bg-green-600 text-white px-3 py-1 rounded">Approve</button>
                                </form>
                                <form method="post" action="ProcessJoinRequestServlet" style="display:inline;">
                                    <input type="hidden" name="requestId" value="${req.id}" />
                                    <input type="hidden" name="action" value="reject" />
                                    <button type="submit" class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded">Reject</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
    </div>
</body>
</html>
