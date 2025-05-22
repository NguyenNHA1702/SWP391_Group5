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
        .farmer-section {
            display: none;
            margin-top: 10px;
        }
        .farmer-section.active {
            display: block;
        }
        .signup-container input[type="file"] {
            padding: 5px;
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
        <form id="signupForm" enctype="multipart/form-data">
            <input type="text" id="name" name="name" placeholder="Full Name *">
            <input type="email" id="email" name="email" placeholder="Email *">
            <input type="password" id="password" name="password" placeholder="Password *">
            <div style="display: flex; align-items: center;">
                <select id="country-code" name="countryCode">
                    <option value="+84">+84</option>
                </select>
                <input type="tel" id="phone" name="phone" placeholder="Phone Number *" style="width: 80%;">
            </div>
            <label>Your data will be stored securely.</label>
            <div style="text-align: left;">
                <input type="checkbox" id="farmerCheck" name="farmerCheck">
                <label for="farmerCheck">Register as a Farmer/Cooperative</label>
            </div>
            <div class="farmer-section" id="farmerSection">
                <select id="entityType" name="entityType">
                    <option value="farmer">Farmer</option>
                    <option value="cooperative">Cooperative</option>
                </select>
                <input type="text" id="farmName" name="farmName" placeholder="Farm/Cooperative Name *">
                <input type="text" id="farmLocation" name="farmLocation" placeholder="Farm/Cooperative Location *">
                <label for="verificationDocs">Upload Verification Documents (e.g., farm ownership, cooperative certificate, Certificate of Food Hygiene and Safety) *</label>
                <input type="file" id="verificationDocs" name="verificationDocs" multiple accept=".pdf,.jpg,.png">
            </div>
            <div style="text-align: left;">
                <input type="checkbox" id="terms" name="terms">
                <label for="terms">I agree to the Terms of Service and Privacy Policy.</label>
            </div>
            <button type="button" onclick="handleSignup()">Sign Up for Free</button>
            <p>Already have an account? <a href="login.jsp">Login here</a></p>
        </form>
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
                document.querySelector('.signup-container input[type="checkbox"][id="terms"] + label').textContent = 'Tôi đồng ý với Điều khoản Dịch vụ và Chính sách Bảo mật.';
                document.querySelector('button').textContent = 'Đăng ký miễn phí';
                document.querySelector('.signup-container p').innerHTML = 'Đã có tài khoản? <a href="login.jsp">Đăng nhập tại đây</a>';
                document.querySelector('input[id="farmerCheck"] + label').textContent = 'Đăng ký với tư cách Nông dân/Hợp tác xã';
                document.getElementById('entityType').options[0].text = 'Nông dân';
                document.getElementById('entityType').options[1].text = 'Hợp tác xã';
                document.getElementById('farmName').placeholder = 'Tên Nông trại/Hợp tác xã *';
                document.getElementById('farmLocation').placeholder = 'Vị trí Nông trại/Hợp tác xã *';
                document.querySelector('label[for="verificationDocs"]').textContent = 'Tải lên Tài liệu Xác minh (ví dụ: giấy tờ sở hữu nông trại, chứng nhận hợp tác xã) *';
            } else {
                document.getElementById('signup-title').textContent = 'Sign Up for AgriRescue';
                document.getElementById('name').placeholder = 'Full Name *';
                document.getElementById('email').placeholder = 'Email *';
                document.getElementById('password').placeholder = 'Password *';
                document.getElementById('phone').placeholder = 'Phone Number *';
                document.querySelector('.signup-container label').textContent = 'Your data will be stored securely.';
                document.querySelector('.signup-container input[type="checkbox"][id="terms"] + label').textContent = 'I agree to the Terms of Service and Privacy Policy.';
                document.querySelector('button').textContent = 'Sign Up for Free';
                document.querySelector('.signup-container p').innerHTML = 'Already have an account? <a href="login.jsp">Login here</a>';
                document.querySelector('input[id="farmerCheck"] + label').textContent = 'Register as a Farmer/Cooperative';
                document.getElementById('entityType').options[0].text = 'Farmer';
                document.getElementById('entityType').options[1].text = 'Cooperative';
                document.getElementById('farmName').placeholder = 'Farm/Cooperative Name *';
                document.getElementById('farmLocation').placeholder = 'Farm/Cooperative Location *';
                document.querySelector('label[for="verificationDocs"]').textContent = 'Upload Verification Documents (e.g., farm ownership, cooperative certificate) *';
            }
        }

        const farmerCheck = document.getElementById('farmerCheck');
        const farmerSection = document.getElementById('farmerSection');

        farmerCheck.addEventListener('change', function() {
            farmerSection.classList.toggle('active', this.checked);
        });

        function handleSignup() {
            const name = document.getElementById('name').value;
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;
            const phone = document.getElementById('phone').value;
            const terms = document.getElementById('terms').checked;
            const isFarmer = document.getElementById('farmerCheck').checked;
            const entityType = document.getElementById('entityType').value;
            const farmName = document.getElementById('farmName').value;
            const farmLocation = document.getElementById('farmLocation').value;
            const verificationDocs = document.getElementById('verificationDocs').files;

            if (!name || !email || !password || !phone || !terms) {
                alert('Vui lòng điền đầy đủ thông tin và đồng ý với điều khoản.');
                return;
            }

            if (isFarmer && (!farmName || !farmLocation || verificationDocs.length === 0)) {
                alert('Vui lòng điền đầy đủ thông tin nông trại/hợp tác xã và tải lên tài liệu xác minh.');
                return;
            }

            const formData = new FormData();
            formData.append('name', name);
            formData.append('email', email);
            formData.append('password', password);
            formData.append('phone', phone);
            formData.append('isFarmer', isFarmer);
            formData.append('entityType', isFarmer ? entityType : '');
            formData.append('farmName', isFarmer ? farmName : '');
            formData.append('farmLocation', isFarmer ? farmLocation : '');

            if (isFarmer) {
                for (let i = 0; i < verificationDocs.length; i++) {
                    formData.append('verificationDocs', verificationDocs[i]);
                }
            }

            fetch('RegisterServlet', {
                method: 'POST',
                body: formData
            })
            .then(response => response.text())
            .then(result => {
                if (result.includes("success")) {
                    alert('Đăng ký thành công! Vui lòng đăng nhập. Tài khoản của bạn sẽ được xem xét để xác minh.');
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