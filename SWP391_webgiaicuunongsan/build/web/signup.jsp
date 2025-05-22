<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sign Up - AgriRescue</title>
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
            .signup-container {
                background-color: rgba(255, 255, 255, 0.9);
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 400px;
                text-align: center;
            }
            .signup-container h2 {
                margin-bottom: 20px;
                font-size: 24px;
                color: #2e7d32;
            }
            .signup-container input {
                width: 100%;
                padding: 10px;
                margin: 10px 0;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 14px;
                box-sizing: border-box;
            }
            .signup-container select {
                width: 20%;
                padding: 10px;
                margin: 10px 5px 10px 0;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 14px;
            }
            .signup-container input[type="checkbox"] {
                width: auto;
                margin-right: 5px;
            }
            .signup-container label {
                font-size: 14px;
                color: #555;
                text-align: left;
                display: block;
            }
            .signup-container button {
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
            .signup-container button:hover {
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

        <div class="signup-container">
            <h2 id="signup-title">Sign Up for AgriRescue</h2>
            <input type="text" id="name" placeholder="Full Name *">
            <input type="email" id="email" placeholder="Email *">
            <input type="password" id="password" placeholder="Password *">
            <div style="display: flex; align-items: center;">
                <select id="country-code">
                    <option value="+84">+84</option>
                </select>
                <input type="tel" id="phone" placeholder="Phone Number *" style="width: 80%;">
            </div>
            <label>Your data will be stored securely.</label>
            <div style="text-align: left;">
                <input type="checkbox" id="terms">
                <label for="terms">I agree to the Terms of Service and Privacy Policy.</label>
            </div>
            <button onclick="handleSignup()">Sign Up for Free</button>
            <p>Already have an account? <a href="login.jsp">Login here</a></p>
        </div>

        <script>
            function changeLanguage(lang) {
                if (lang === 'vi') {
                    document.getElementById('signup-title').textContent = 'Đăng ký cho AgriRescue';
                    document.getElementById('name').placeholder = 'Họ và tên *';
                    document.getElementById('email').placeholder = 'Email *';
                    document.getElementById('password').placeholder = 'Mật khẩu *';
                    document.getElementById('phone').placeholder = 'Số điện thoại *';
                    document.querySelector('.signup-container label').textContent = 'Dữ liệu của bạn sẽ được lưu trữ an toàn.';
                    document.querySelector('.signup-container input[type="checkbox"] + label').textContent = 'Tôi đồng ý với Điều khoản Dịch vụ và Chính sách Bảo mật.';
                    document.querySelector('button').textContent = 'Đăng ký miễn phí';
                    document.querySelector('.signup-container p').innerHTML = 'Đã có tài khoản? <a href="login.jsp">Đăng nhập tại đây</a>';
                } else {
                    document.getElementById('signup-title').textContent = 'Sign Up for AgriRescue';
                    document.getElementById('name').placeholder = 'Full Name *';
                    document.getElementById('email').placeholder = 'Email *';
                    document.getElementById('password').placeholder = 'Password *';
                    document.getElementById('phone').placeholder = 'Phone Number *';
                    document.querySelector('.signup-container label').textContent = 'Your data will be stored securely.';
                    document.querySelector('.signup-container input[type="checkbox"] + label').textContent = 'I agree to the Terms of Service and Privacy Policy.';
                    document.querySelector('button').textContent = 'Sign Up for Free';
                    document.querySelector('.signup-container p').innerHTML = 'Already have an account? <a href="login.jsp">Login here</a>';
                }
            }

            function handleSignup() {
                const name = document.getElementById('name').value.trim();
                const email = document.getElementById('email').value.trim().toLowerCase();
                const password = document.getElementById('password').value.trim();
                const phone = document.getElementById('phone').value.trim();
                const terms = document.getElementById('terms').checked;

                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email)) {
                    alert('Please enter a valid email address (e.g. user@example.com).');
                    return;
                }

                if (!name || !email || !password || !phone || !terms) {
                    alert('Vui lòng điền đầy đủ thông tin và đồng ý với điều khoản.');
                    return;
                }

                fetch('RegisterServlet', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: "name=" + encodeURIComponent(name)
                            + "&email=" + encodeURIComponent(email)
                            + "&password=" + encodeURIComponent(password)
                            + "&phone=" + encodeURIComponent(phone)

                })
                        .then(response => response.text())
                        .then(result => {
                            console.log("Server response:", result);
                            if (result.includes("success")) {
                                alert('Đăng ký thành công! Vui lòng đăng nhập.');
                                window.location.href = 'login.jsp';
                            } else if (result.includes("exists")) {
                                alert('Email đã tồn tại.');
                            } else {
                                alert('Đăng ký thất bại: ' + result);
                            }
                        })
                        .catch(error => alert('Lỗi: ' + error));
            }
        </script>
    </body>
</html>
