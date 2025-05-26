<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile - AgriRescue</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(to right, #a3bffa, #d4c4fb);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-image: url('https://via.placeholder.com/1920x1080?text=Agricultural+Background');
            background-size: cover;
            background-position: center;
        }
        .header {
            position: absolute;
            top: 0;
            width: 100%;
            padding: 15px 20px;
            display: flex;
            justify-content: flex-start;
            align-items: center;
            background-color: rgba(46, 125, 50, 0.8);
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            z-index: 1000;
        }
        .header-title {
            font-size: 24px;
            font-weight: bold;
            color: #fff;
        }
        .home-btn {
            color: #fff;
            text-decoration: none;
            padding: 8px 15px;
            border-radius: 5px;
            background-color: #1b5e20;
            margin-left: 15px;
            transition: background-color 0.3s;
        }
        .home-btn:hover {
            background-color: #124116;
        }
        .profile-container {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
            text-align: left;
        }
        .profile-container h2 {
            margin-bottom: 20px;
            font-size: 24px;
            color: #2e7d32;
            text-align: center;
        }
        .profile-container label {
            display: block;
            margin: 10px 0 5px;
            font-weight: bold;
            color: #555;
        }
        .profile-container input {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            box-sizing: border-box;
        }
        .profile-container button {
            width: 48%;
            padding: 12px;
            background-color: #2e7d32;
            color: #fff;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            margin-right: 4%;
            transition: background-color 0.3s;
        }
        .profile-container button:hover {
            background-color: #1b5e20;
        }
        .profile-container .save-btn {
            background-color: #2e7d32;
        }
        .profile-container .change-password-btn {
            background-color: #ff9800;
        }
        .profile-container .change-password-btn:hover {
            background-color: #f57c00;
        }
        .profile-container .button-group {
            display: flex;
            justify-content: space-between;
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-title">AgriRescue</div>
        <a href="index.jsp" class="home-btn">Home Page</a>
    </div>

    <div class="profile-container">
        <h2>User Profile</h2>
        <form action="UserProfileServlet" method="post">
            <input type="hidden" name="action" value="updateProfile">
            <label for="name">Full Name:</label>
            <input type="text" id="name" name="name" value="<%= session.getAttribute("userName") != null ? session.getAttribute("userName") : "" %>" required>
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" value="<%= session.getAttribute("userEmail") != null ? session.getAttribute("userEmail") : "" %>" required readonly>
            <label for="phone">Phone Number:</label>
            <input type="tel" id="phone" name="phone" value="<%= session.getAttribute("userPhone") != null ? session.getAttribute("userPhone") : "" %>" required>
            <div class="button-group">
                <button type="submit" class="save-btn">Save Changes</button>
                <button type="button" class="change-password-btn" onclick="showPasswordForm()">Change Password</button>
            </div>
        </form>

        <div id="passwordForm" style="display: none; margin-top: 20px;">
            <form action="UserProfileServlet" method="post">
                <input type="hidden" name="action" value="changePassword">
                <label for="currentPassword">Current Password:</label>
                <input type="password" id="currentPassword" name="currentPassword" required>
                <label for="newPassword">New Password:</label>
                <input type="password" id="newPassword" name="newPassword" required>
                <label for="confirmPassword">Confirm New Password:</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
                <button type="submit" class="save-btn">Update Password</button>
            </form>
        </div>
    </div>

    <script>
        function showPasswordForm() {
            const passwordForm = document.getElementById('passwordForm');
            if (passwordForm.style.display === 'none') {
                passwordForm.style.display = 'block';
            } else {
                passwordForm.style.display = 'none';
            }
        }

        // Validation trước khi gửi form đổi mật khẩu
        document.querySelectorAll('form')[1].addEventListener('submit', function(event) {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            if (newPassword !== confirmPassword) {
                event.preventDefault();
                alert('New password and confirm password do not match.');
            }
        });
    </script>
</body>
</html>