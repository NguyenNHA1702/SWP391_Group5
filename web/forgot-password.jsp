<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password - AgriRescue</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(to right, #a3bffa, #d4c4fb);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
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
            justify-content: space-between;
            align-items: center;
            background-color: rgba(46, 125, 50, 0.8);
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            z-index: 1000;
        }
        .header-left {
            display: flex;
            align-items: center;
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
        .forgot-container {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }
        .forgot-container h2 {
            margin-bottom: 20px;
            font-size: 24px;
            color: #2e7d32;
        }
        .forgot-container input {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            box-sizing: border-box;
        }
        .forgot-container button {
            width: 100%;
            padding: 12px;
            background-color: #2e7d32;
            color: #fff;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            margin: 10px 0;
            transition: background-color 0.3s;
        }
        .forgot-container button:hover {
            background-color: #1b5e20;
        }
        .forgot-container a {
            color: #2e7d32;
            text-decoration: none;
        }
        .forgot-container a:hover {
            text-decoration: underline;
        }
        .language-switch select {
            padding: 5px;
            border-radius: 5px;
            background-color: #fff;
            border: 1px solid #ccc;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-left">
            <div class="header-title">AgriRescue</div>
            <a href="index.jsp" class="home-btn" id="home-btn">Home Page</a>
        </div>
        <div class="language-switch">
            <select onchange="changeLanguage(this.value)">
                <option value="en">English</option>
                <option value="vi">Tiếng Việt</option>
            </select>
        </div>
    </div>

    <div class="forgot-container">
        <h2 id="forgot-title">Forgot Password</h2>
        <form action="ForgotPasswordServlet" method="post">
            <input type="email" name="email" id="email" placeholder="Enter your email *" required>
            <button type="submit" id="submit-btn">Submit</button>
        </form>
        <p><a href="login.jsp" id="back-to-login">Back to Login</a></p>
    </div>

    <script>
        function changeLanguage(lang) {
            if (lang === 'vi') {
                document.getElementById('forgot-title').textContent = 'Quên Mật Khẩu';
                document.getElementById('email').placeholder = 'Nhập email của bạn *';
                document.getElementById('submit-btn').textContent = 'Gửi';
                document.getElementById('back-to-login').textContent = 'Quay lại Đăng nhập';
                document.getElementById('home-btn').textContent = 'Trang Chủ';
            } else {
                document.getElementById('forgot-title').textContent = 'Forgot Password';
                document.getElementById('email').placeholder = 'Enter your email *';
                document.getElementById('submit-btn').textContent = 'Submit';
                document.getElementById('back-to-login').textContent = 'Back to Login';
                document.getElementById('home-btn').textContent = 'Home Page';
            }
        }
    </script>
</body>
</html>