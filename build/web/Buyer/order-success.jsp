<%-- 
    Document   : order-success
    Created on : 23 Jun 2025, 01:57:57
    Author     : HP
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt hàng thành công</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-green-50 py-16">
    <div class="max-w-xl mx-auto bg-white p-8 rounded-xl shadow-lg text-center">
        <h1 class="text-3xl font-bold text-green-700 mb-4">🎉 Đặt hàng thành công!</h1>
        <p class="text-gray-700 text-lg mb-6">
            Cảm ơn bạn đã tin tưởng AgriRescue. Đơn hàng của bạn đã được ghi nhận.
        </p>

        <p class="text-gray-600 mb-4">
            Chúng tôi sẽ sớm liên hệ để xác nhận đơn hàng và tiến hành giao hàng trong thời gian sớm nhất.
        </p>

        <div class="flex justify-center gap-4 mt-6">
            <a href="${pageContext.request.contextPath}/home"
               class="bg-green-600 hover:bg-green-700 text-white font-semibold px-6 py-3 rounded-lg shadow">
                ⬅ Quay về Trang chủ
            </a>
            <a href="${pageContext.request.contextPath}/Buyer/orders.jsp"
               class="bg-gray-100 hover:bg-gray-200 text-green-800 font-medium px-6 py-3 rounded-lg border border-gray-300">
                📦 Xem lịch sử đơn hàng
            </a>
        </div>
    </div>
</body>
</html>


