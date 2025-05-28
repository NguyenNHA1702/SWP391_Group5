<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile - AgriRescue</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        body {
            background-image: url('https://images.unsplash.com/photo-1500595046743-ddf4d3d753fd?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');
            background-size: cover;
            background-attachment: fixed;
            background-position: center;
        }
        .profile-container {
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .form-group {
            margin-bottom: 1rem;
        }
        .error {
            color: red;
            font-size: 0.875rem;
            display: none;
        }
        .server-message {
            font-size: 0.875rem;
            margin-top: 0.5rem;
        }
        .error-message {
            color: red;
        }
        .success-message {
            color: green;
        }
    </style>
</head>
<body class="font-sans text-gray-800">
    <%
        String user = (String) session.getAttribute("user");
        String role = (String) session.getAttribute("role");
        String email = (String) session.getAttribute("email");
        String fullName = (String) session.getAttribute("full_name");
        String phone = (String) session.getAttribute("phone");
        String address = (String) session.getAttribute("address");
        String createdAt = (String) session.getAttribute("created_at");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        String errorMessage = request.getParameter("error");
        String successMessage = request.getParameter("success");
    %>
    <header class="bg-green-600 text-white py-4 px-6 flex justify-between items-center">
        <h1 class="text-2xl font-bold">User Profile</h1>
        <a href="index.jsp" class="text-white hover:underline">Back to Home</a>
    </header>

    <main class="container mx-auto px-4 py-8">
        <div class="profile-container p-6 max-w-lg mx-auto">
            <h2 class="text-2xl font-semibold text-green-700 mb-4">Welcome, <%= user %>!</h2>
            <form action="UpdateProfileServlet" method="post" id="profileForm" onsubmit="return validateForm()">
                <div class="form-group">
                    <label for="username" class="block text-sm font-medium text-gray-700">Username</label>
                    <input type="text" id="username" name="username" value="<%= user %>" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-green-500 focus:border-green-500" readonly>
                </div>
                <div class="form-group">
                    <label for="fullName" class="block text-sm font-medium text-gray-700">Full Name</label>
                    <input type="text" id="fullName" name="fullName" value="<%= fullName != null ? fullName : "" %>" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-green-500 focus:border-green-500" required>
                    <div id="fullNameError" class="error">Full name is required.</div>
                </div>
                <div class="form-group">
                    <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
                    <input type="email" id="email" name="email" value="<%= email != null ? email : "" %>" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-green-500 focus:border-green-500" required>
                    <div id="emailError" class="error">Please enter a valid email address.</div>
                </div>
                <div class="form-group">
                    <label for="phone" class="block text-sm font-medium text-gray-700">Phone</label>
                    <input type="text" id="phone" name="phone" value="<%= phone != null ? phone : "" %>" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-green-500 focus:border-green-500">
                    <div id="phoneError" class="error">Phone number must be numeric and at least 10 digits.</div>
                </div>
                <div class="form-group">
                    <label for="address" class="block text-sm font-medium text-gray-700">Address</label>
                    <input type="text" id="address" name="address" value="<%= address != null ? address : "" %>" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-green-500 focus:border-green-500">
                </div>
                <div class="form-group">
                    <label for="role" class="block text-sm font-medium text-gray-700">Role</label>
                    <input type="text" id="role" name="role" value="<%= role != null ? role : "Not specified" %>" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-green-500 focus:border-green-500" readonly>
                </div>
                <div class="form-group">
                    <label for="createdAt" class="block text-sm font-medium text-gray-700">Created At</label>
                    <input type="text" id="createdAt" name="createdAt" value="<%= createdAt != null ? createdAt : "Not specified" %>" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-green-500 focus:border-green-500" readonly>
                </div>
                <button type="submit" class="bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700 transition">Update Profile</button>
            </form>

            <form action="ResetPasswordServlet" method="post" id="passwordForm" class="mt-6" onsubmit="return validatePassword()">