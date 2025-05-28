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
                <a href="index.jsp" class="home-btn">Home Page</a>
            </div>
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
            <button id="login-btn" onclick="handleLogin()">Login</button>
            <p id="signup-text">Don't have an account? <a href="signup.jsp">Sign Up here</a></p>
        </div>

        <script>
            function changeLanguage(lang) {
                if (lang === 'vi') {
                    document.getElementById('login-title').textContent = 'Đăng nhập vào AgriRescue';
                    document.getElementById('email').placeholder = 'Địa chỉ email *';
                    document.getElementById('password').placeholder = 'Mật khẩu *';
                    document.getElementById('login-btn').textContent = 'Đăng nhập';
                    document.getElementById('signup-text').innerHTML = 'Chưa có tài khoản? <a href="signup.jsp">Đăng ký tại đây</a>';
                } else {
                    document.getElementById('login-title').textContent = 'Login to AgriRescue';
                    document.getElementById('email').placeholder = 'Email *';
                    document.getElementById('password').placeholder = 'Password *';
                    document.getElementById('login-btn').textContent = 'Login';
                    document.getElementById('signup-text').innerHTML = 'Don\'t have an account? <a href="signup.jsp">Sign Up here</a>';
                }
            }

            function handleLogin() {
                const email = document.getElementById('email').value.trim();
                const password = document.getElementById('password').value.trim();

                if (!email || !password) {
                    alert('Vui lòng nhập email và mật khẩu.');
                    return;
                }

                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email)) {
                    alert('Vui lòng nhập email hợp lệ.');
                    return;
                }

                const loginBtn = document.getElementById('login-btn');
                const originalText = loginBtn.textContent;
                loginBtn.textContent = (originalText === 'Login') ? 'Logging in...' : 'Đang đăng nhập...';

                fetch('/SWP391_webgiaicuunongsan/login', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
                    body: 'email=' + encodeURIComponent(email) + '&password=' + encodeURIComponent(password)
                })
                        .then(response => response.text())
                        .then(result => {
                            loginBtn.textContent = originalText;
                            if (result.includes("success")) {
                                window.location.href = 'index.jsp';
                            } else if (result.includes("not found")) {
                                alert('Email không tồn tại.');
                            } else if (result.includes("incorrect")) {
                                alert('Mật khẩu sai.');
                            } else {
                                alert('Đăng nhập thất bại: ' + result);
                            }
                        })
                        .catch(error => {
                            loginBtn.textContent = originalText;
                            alert('Lỗi: ' + error);
                        });
            }
        </script>
    </body>
</html>
