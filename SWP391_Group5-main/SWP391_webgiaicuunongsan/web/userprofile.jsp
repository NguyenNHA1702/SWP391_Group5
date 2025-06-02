<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="utils.DBUtil" %>
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
        .delete-btn {
            background-color: #dc3545;
            color: white;
        }
        .delete-btn:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body class="font-sans text-gray-800">
    <%
        // Lấy userId từ session và xử lý kiểu dữ liệu
        Object userIdObj = session.getAttribute("userId");
        String userId = null;
        if (userIdObj instanceof Integer) {
            userId = String.valueOf(userIdObj);
        } else if (userIdObj instanceof String) {
            userId = (String) userIdObj;
        }

        String role = (String) session.getAttribute("role");

        // Kiểm tra đăng nhập
        if (userId == null || role == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Khai báo các biến để lưu thông tin người dùng
        String username = null;
        String fullName = null;
        String email = null;
        String phone = null;
        String address = null; // Có thể để null nếu không có cột address
        String createdAt = null;

        // Truy vấn thông tin người dùng từ cơ sở dữ liệu
        try (Connection connection = DBUtil.getConnection()) {
            String sql = "SELECT username, name, email, phone, role, created_at FROM users WHERE user_id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, Integer.parseInt(userId));
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                username = resultSet.getString("username");
                fullName = resultSet.getString("name");
                email = resultSet.getString("email");
                phone = resultSet.getString("phone");
                role = resultSet.getString("role");
                createdAt = resultSet.getString("created_at") != null ? resultSet.getString("created_at") : "Not specified";
                // address sẽ để null nếu không có cột này
            } else {
                out.println("<p class='server-message error-message'>User not found.</p>");
                return;
            }
        } catch (SQLException e) {
            out.println("<p class='server-message error-message'>Error retrieving user data: " + e.getMessage() + "</p>");
            return;
        }

        String errorMessage = request.getParameter("error");
        String successMessage = request.getParameter("success");
    %>

    <header class="bg-green-600 text-white py-4 px-6 flex justify-between items-center">
        <h1 class="text-2xl font-bold">User Profile</h1>
        
        <div>
            <a href="home" class="text-white hover:underline mr-4">Back to Home</a>
            <a href="LogoutServlet" class="text-white hover:underline">Logout</a>
        </div>
    </header>

    <main class="container mx-auto px-4 py-8">
        <div class="profile-container p-6 max-w-lg mx-auto">
            <h2 class="text-2xl font-semibold text-green-700 mb-4">Welcome, <%= username != null ? username : "" %>!</h2>
            <% if (errorMessage != null) { %>
                <p class="server-message error-message"><%= errorMessage %></p>
            <% } %>
            <% if (successMessage != null) { %>
                <p class="server-message success-message"><%= successMessage %></p>
            <% } %>
            <form action="UpdateProfileServlet" method="post" id="profileForm" onsubmit="return validateForm()">
                <div class="form-group">
                    <label for="username" class="block text-sm font-medium text-gray-700">Username</label>
                    <input type="text" id="username" name="username" value="<%= username != null ? username : "" %>" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-green-500 focus:border-green-500" readonly>
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
                    <div id="phoneError" class="error">Phone number must be at least 10 digits or start with +84 followed by 9 or 10 digits.</div>
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

            <!-- Change Password Form -->
            <form action="ChangePasswordServlet" method="post" id="passwordForm" class="mt-6" onsubmit="return validatePassword()">
                <h3 class="text-lg font-medium text-green-700 mb-2">Change Password</h3>
                <div class="form-group">
                    <label for="currentPassword" class="block text-sm font-medium text-gray-700">Current Password</label>
                    <input type="password" id="currentPassword" name="currentPassword" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-green-500 focus:border-green-500" required>
                    <div id="currentPasswordError" class="error">Current password is required.</div>
                </div>
                <div class="form-group">
                    <label for="newPassword" class="block text-sm font-medium text-gray-700">New Password</label>
                    <input type="password" id="newPassword" name="newPassword" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-green-500 focus:border-green-500" required>
                    <div id="newPasswordError" class="error">New password must be at least 6 characters.</div>
                </div>
                <div class="form-group">
                    <label for="confirmPassword" class="block text-sm font-medium text-gray-700">Confirm New Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-green-500 focus:border-green-500" required>
                    <div id="confirmPasswordError" class="error">Passwords do not match.</div>
                </div>
                <button type="submit" class="bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700 transition">Change Password</button>
            </form>

            <!-- Delete Account Form -->
            <form action="DeleteAccountServlet" method="post" id="deleteForm" class="mt-6" onsubmit="return confirmDelete()">
                <button type="submit" class="delete-btn px-4 py-2 rounded-lg transition">Delete Account</button>
            </form>
        </div>
    </main>

    <script>
        function validateForm() {
            let isValid = true;
            const fullName = document.getElementById('fullName').value.trim();
            const email = document.getElementById('email').value.trim();
            const phone = document.getElementById('phone').value.trim();

            document.getElementById('fullNameError').style.display = fullName === '' ? 'block' : 'none';
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            document.getElementById('emailError').style.display = !emailRegex.test(email) ? 'block' : 'none';
            const phoneRegex = /^(?:\d{10,}|\+84\d{9,10})$/;
            document.getElementById('phoneError').style.display = phone && !phoneRegex.test(phone) ? 'block' : 'none';

            if (fullName === '' || !emailRegex.test(email) || (phone && !phoneRegex.test(phone))) {
                isValid = false;
            }
            return isValid;
        }

        function validatePassword() {
            let isValid = true;
            const currentPassword = document.getElementById('currentPassword').value;
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;

            document.getElementById('currentPasswordError').style.display = currentPassword === '' ? 'block' : 'none';
            document.getElementById('newPasswordError').style.display = newPassword.length < 6 ? 'block' : 'none';
            document.getElementById('confirmPasswordError').style.display = newPassword !== confirmPassword ? 'block' : 'none';

            if (currentPassword === '' || newPassword.length < 6 || newPassword !== confirmPassword) {
                isValid = false;
            }
            return isValid;
        }

        function confirmDelete() {
            return confirm('Are you sure you want to delete your account? This action cannot be undone.');
        }
    </script>
</body>
</html>