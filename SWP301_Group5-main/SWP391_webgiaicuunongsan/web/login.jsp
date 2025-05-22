<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - AgriRescue</title>
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
        .login-container {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }
        .login-container h2 {
            margin-bottom: 20px;
            font-size: 24px;
            color: #2e7d32;
        }
        .login-container input {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            box-sizing: border-box;
        }
        .login-container button {
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
        .login-container button:hover {
            background-color: #1b5e20;
        }
        .language-switch {
            position: absolute;
            top: 15px;
            right: 20px;
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
        <div class="header-title">AgriRescue</div>
        <a href="index.jsp" class="home-btn">Home Page</a>
        <div class="language-switch">
            <select onchange="changeLanguage(this.value)">
                <option value="en">English</option>
                <option value="vi">Tiếng Việt</option>
            </select>
        </div>
    </div>

    <div class="login-container">
        <h2 id="login-title">Login to AgriRescue</h2>
        <input type="email" id="email" placeholder="Email *">
        <input type="password" id="password" placeholder="Password *">
        <button onclick="handleLogin()">Login</button>
        <p>Don't have an account? <a href="signup.jsp">Sign Up here</a></p>
    </div>

    <script>
        function changeLanguage(lang) {
            if (lang === 'vi') {
                document.getElementById('login-title').textContent = 'Đăng nhập vào AgriRescue';
                document.querySelector('input[type="email"]').placeholder = 'Email *';
                document.querySelector('input[type="password"]').placeholder = 'Mật khẩu *';
                document.querySelector('button').textContent = 'Đăng nhập';
                document.querySelector('.login-container p').innerHTML = 'Chưa có tài khoản? <a href="signup.jsp">Đăng ký tại đây</a>';
            } else {
                document.getElementById('login-title').textContent = 'Login to AgriRescue';
                document.querySelector('input[type="email"]').placeholder = 'Email *';
                document.querySelector('input[type="password"]').placeholder = 'Password *';
                document.querySelector('button').textContent = 'Login';
                document.querySelector('.login-container p').innerHTML = 'Don\'t have an account? <a href="signup.jsp">Sign Up here</a>';
            }
        }

        function handleLogin() {
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;

            if (!email || !password) {
                alert('Vui lòng nhập email và mật khẩu.');
                return;
            }

            fetch('LoginServlet', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'email=' + encodeURIComponent(email) + '&password=' + encodeURIComponent(password)
            })
            .then(response => response.text())
            .then(result => {
                if (result.includes("success")) {
                    window.location.href = 'index.jsp';
                } else if (result.includes("not found")) {
                    alert('Email không tồn tại.');
                } else if (result.includes("incorrect")) {
                    alert('Mật khẩu sai .');
                } else {
                    alert('Đăng nhập thất bại: ' + result);
                }
            })
            .catch(error => alert('Lỗi: ' + error));
        }
    </script>
</body>
</html>