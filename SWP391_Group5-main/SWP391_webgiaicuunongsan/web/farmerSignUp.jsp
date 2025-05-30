<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up for Farmer - AgriRescue</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f9f9f5; /* Nền đất sáng, đồng bộ với campaignList.jsp */
            color: #2e3a23; /* Màu chữ xanh đậm */
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        /* Header */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #567d46; /* Xanh rừng, đồng bộ */
            padding: 15px 20px;
            color: #f0f7e6;
            box-shadow: 0 2px 5px rgba(0,0,0,0.15);
            border-radius: 8px;
            margin-bottom: 25px;
            width: 100%;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1000;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .language-switch select {
            padding: 5px 10px;
            border-radius: 5px;
            border: 1.5px solid #a2b29f;
            background-color: #f0f7e6;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .language-switch select:hover {
            border-color: #3e5a22;
        }

        .header-title {
            font-size: 1.8rem;
            font-weight: 700;
            font-family: 'Georgia', serif;
            color: #f0f7e6;
            user-select: none;
        }

        .home-btn {
            padding: 8px 15px;
            background-color: #a6c48a; /* Xanh nhạt, đồng bộ */
            color: #2e3a23;
            font-weight: 600;
            border-radius: 6px;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }
        .home-btn:hover {
            background-color: #8bb05c;
            color: white;
        }

        .header-actions a, .header-actions span {
            font-weight: 600;
            color: #f0f7e6;
            margin-left: 15px;
            text-decoration: none;
        }
        .header-actions a:hover {
            text-decoration: underline;
        }

        /* Signup container */
        .signup-container {
            background-color: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 6px 25px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 600px;
            margin: 100px auto 20px auto; /* Đẩy xuống để không bị che bởi header */
            text-align: center;
        }

        .signup-container h2 {
            font-family: 'Georgia', serif;
            font-weight: 700;
            font-size: 1.6rem;
            color: #567d46; /* Đồng bộ với header */
            margin-bottom: 20px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .signup-container input,
        .signup-container select {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #a2b29f;
            border-radius: 6px;
            font-size: 14px;
            box-sizing: border-box;
            transition: border-color 0.3s ease, box-shadow 0.3s ease, background-color 0.3s ease;
            background-color: #f7f9f2; /* Nền nhạt, đồng bộ bảng */
        }

        .signup-container input:focus,
        .signup-container select:focus {
            border-color: #567d46;
            box-shadow: 0 0 8px rgba(86, 125, 70, 0.3);
            background-color: #fff;
            outline: none;
        }

        .signup-container input::placeholder {
            color: #a2b29f;
            font-style: italic;
        }

        .signup-container select {
            appearance: none;
            background-image: url('data:image/svg+xml;utf8,<svg fill="%232e3a23" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/></svg>');
            background-repeat: no-repeat;
            background-position: right 10px center;
        }

        .signup-container button {
            width: 100%;
            padding: 12px;
            background: linear-gradient(90deg, #567d46, #3e5a22); /* Gradient đồng bộ header */
            color: #f0f7e6;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            margin: 10px 0;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: transform 0.2s ease, background 0.3s ease;
        }

        .signup-container button:hover {
            background: linear-gradient(90deg, #3e5a22, #2e3a23);
            transform: translateY(-2px);
        }

        .signup-container p {
            margin-top: 15px;
            font-size: 14px;
            color: #4b5632;
        }

        .signup-container p a {
            color: #567d46;
            text-decoration: none;
            font-weight: 600;
        }

        .signup-container p a:hover {
            text-decoration: underline;
        }

        .success-message, .error-message {
            font-weight: 600;
            margin-bottom: 15px;
        }
        .success-message {
            color: #28a745;
        }
        .error-message {
            color: #dc3545;
        }

        /* Responsive */
        @media screen and (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 10px;
                text-align: center;
            }
            .header-left {
                justify-content: center;
                gap: 10px;
            }
            .signup-container {
                margin: 80px 20px 20px 20px;
                padding: 20px;
            }
            .signup-container h2 {
                font-size: 1.4rem;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-left">
            <div class="language-switch">
                <select onchange="changeLanguage(this.value)">
                    <option value="vi">Tiếng Việt</option>
                    <option value="en">English</option>
                </select>
            </div>
            <div class="header-title">AgriRescue</div>
            <%
    String loggedUser = (String) session.getAttribute("user");
    String homeLink = (loggedUser != null) ? (request.getContextPath() + "/home") : "index.jsp";
%>
<a href="<%= homeLink %>" class="home-btn">Home Page</a>

        </div>
        <div class="header-actions">
            <!-- Không có login/logout ở đây vì đang ở trang signup -->
        </div>
    </div>

    <div class="signup-container">
        <h2 id="signup-title">Sign Up for Farmer</h2>
        <% String successMsg = (String) request.getAttribute("ms1"); %>
        <% String errorMsg = (String) request.getAttribute("error"); %>
        <% if (successMsg != null) { %>
            <p class="success-message"><%= successMsg %></p>
        <% } %>
        <% if (errorMsg != null) { %>
            <p class="error-message"><%= errorMsg %></p>
        <% } %>
        <form action="farmerRegister" method="post" enctype="multipart/form-data">
            <input type="text" name="fullname" placeholder="Full Name *" required>
            <input type="email" name="email" placeholder="Email *" required>
            <input type="text" name="phone" placeholder="Phone Number *" required>
            <input type="text" name="user" placeholder="Username *" required>
            <input type="password" name="pass" placeholder="Password *" required>
            <input type="hidden" name="role" value="farmer">

            <label for="verificationDocs" style="display: block; text-align: left; margin-top: 10px;">Upload Verification Documents (e.g., Business License, Agricultural Certificate) *</label>
            <input type="file" id="verificationDocs" name="verificationDocs" accept=".pdf,.jpg,.png" required>

            <button type="submit">Sign Up as Farmer</button>
        </form>

        <p>Already have an account? <a href="login.jsp">Login here</a></p>
        <p>Sign up as a regular user? <a href="signup.jsp">Sign Up Here</a></p>
    </div>

    <script>
        function changeLanguage(lang) {
            if (lang === 'vi') {
                document.getElementById('signup-title').textContent = 'Đăng ký cho Nông dân';
                document.querySelector('button').textContent = 'Đăng ký làm Nông dân';
                document.querySelector('p:nth-child(4)').innerHTML = 'Đã có tài khoản? <a href="login.jsp">Đăng nhập tại đây</a>';
                document.querySelector('p:nth-child(5)').innerHTML = 'Đăng ký làm người dùng thông thường? <a href="signup.jsp">Đăng ký tại đây</a>';
                document.querySelector('input[name="fullname"]').placeholder = 'Họ và tên *';
                document.querySelector('input[name="email"]').placeholder = 'Email *';
                document.querySelector('input[name="phone"]').placeholder = 'Số điện thoại *';
                document.querySelector('input[name="user"]').placeholder = 'Tên đăng nhập *';
                document.querySelector('input[name="pass"]').placeholder = 'Mật khẩu *';
                document.querySelector('label[for="verificationDocs"]').textContent = 'Tải lên tài liệu xác minh (ví dụ: Giấy phép kinh doanh, Giấy chứng nhận nông nghiệp) *';
            } else {
                document.getElementById('signup-title').textContent = 'Sign Up for Farmer';
                document.querySelector('button').textContent = 'Sign Up as Farmer';
                document.querySelector('p:nth-child(4)').innerHTML = 'Already have an account? <a href="login.jsp">Login here</a>';
                document.querySelector('p:nth-child(5)').innerHTML = 'Sign up as a regular user? <a href="signup.jsp">Sign Up Here</a>';
                document.querySelector('input[name="fullname"]').placeholder = 'Full Name *';
                document.querySelector('input[name="email"]').placeholder = 'Email *';
                document.querySelector('input[name="phone"]').placeholder = 'Phone Number *';
                document.querySelector('input[name="user"]').placeholder = 'Username *';
                document.querySelector('input[name="pass"]').placeholder = 'Password *';
                document.querySelector('label[for="verificationDocs"]').textContent = 'Upload Verification Documents (e.g., Business License, Agricultural Certificate) *';
            }
        }
    </script>
</body>
</html>