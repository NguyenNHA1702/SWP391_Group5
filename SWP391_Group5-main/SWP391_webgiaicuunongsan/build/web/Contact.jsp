<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    Integer farmerId = (Integer) session.getAttribute("userId");
    if (farmerId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String success = request.getParameter("success");
    String error = (String) request.getAttribute("error");
%>
<html>
<head>
    <title>Contact / Help Center</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center py-8">
    <div class="bg-white p-8 rounded-lg shadow-lg w-full max-w-3xl">
        <h2 class="text-3xl font-bold mb-8 text-center text-gray-800">Contact / Help Center</h2>
        <div class="space-y-6">
            <% if (success != null && success.equals("true")) { %>
                <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative" role="alert">
                    <span class="block sm:inline">Yêu cầu của bạn đã được gửi thành công!</span>
                </div>
            <% } %>
            <% if (error != null) { %>
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative" role="alert">
                    <span class="block sm:inline"><%= error %></span>
                </div>
            <% } %>
            <div>
                <h3 class="text-xl font-semibold text-gray-700">Liên hệ với chúng tôi</h3>
                <p class="text-gray-600 mt-2">Nếu bạn cần hỗ trợ, vui lòng điền form dưới đây hoặc liên hệ qua:</p>
                <ul class="list-disc list-inside text-gray-600 mt-2">
                    <li>Email: support@platform.com</li>
                    <li>Phone: +84 123 456 789</li>
                    <li>Thời gian hỗ trợ: 8:00 - 17:00 (GMT+7), Thứ Hai - Thứ Sáu</li>
                </ul>
            </div>
            <form action="submitContact" method="post" class="space-y-4">
                <div>
                    <label for="name" class="block text-sm font-medium text-gray-700">Họ và tên *</label>
                    <input type="text" id="name" name="name" required class="mt-1 block w-full border-gray-300 rounded-md shadow-sm">
                </div>
                <div>
                    <label for="email" class="block text-sm font-medium text-gray-700">Email *</label>
                    <input type="email" id="email" name="email" required class="mt-1 block w-full border-gray-300 rounded-md shadow-sm">
                </div>
                <div>
                    <label for="subject" class="block text-sm font-medium text-gray-700">Chủ đề *</label>
                    <input type="text" id="subject" name="subject" required class="mt-1 block w-full border-gray-300 rounded-md shadow-sm">
                </div>
                <div>
                    <label for="message" class="block text-sm font-medium text-gray-700">Tin nhắn *</label>
                    <textarea id="message" name="message" rows="4" required class="mt-1 block w-full border-gray-300 rounded-md shadow-sm"></textarea>
                </div>
                <div class="text-center">
                    <button type="submit" class="bg-green-600 text-white py-2 px-6 rounded-md hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-green-500">Gửi yêu cầu</button>
                </div>
            </form>
        </div>
        <div class="mt-8 text-center">
            <a href="index.jsp" class="inline-block bg-blue-600 text-white py-2 px-6 rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500">Quay lại trang chủ</a>
        </div>
    </div>
</body>
</html>