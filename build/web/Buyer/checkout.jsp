<%-- 
    Document   : checkout
    Created on : 23 Jun 2025, 01:36:45
    Author     : HP
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Thông tin giao hàng - AgriRescue</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-green-50 py-10">
        <div class="max-w-2xl mx-auto bg-white p-8 rounded-xl shadow-xl">
            <h2 class="text-2xl font-bold mb-6 text-green-800">🚚 Nhập Thông Tin Giao Hàng</h2>

            <c:if test="${not empty errorMessage}">
                <div class="mb-4 text-red-600 font-semibold">
                    ❌ ${errorMessage}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/checkout" method="post" class="space-y-4">
                <div>
                    <label class="block font-medium mb-1">Họ và tên</label>
                    <input type="text" name="fullName" required
                           class="w-full border border-gray-300 rounded-lg px-4 py-2">
                </div>

                <div>
                    <label class="block font-medium mb-1">Số điện thoại</label>
                    <input type="text" name="phone" required
                           class="w-full border border-gray-300 rounded-lg px-4 py-2">
                </div>

                <div>
                    <label class="block font-medium mb-1">Địa chỉ cụ thể (số nhà, đường)</label>
                    <input type="text" name="address" required
                           class="w-full border border-gray-300 rounded-lg px-4 py-2">
                </div>

                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <div>
                        <label class="block font-medium mb-1">Tỉnh / Thành phố</label>
                        <input type="text" name="province" required
                               class="w-full border border-gray-300 rounded-lg px-4 py-2">
                    </div>
                    <div>
                        <label class="block font-medium mb-1">Quận / Huyện</label>
                        <input type="text" name="district" required
                               class="w-full border border-gray-300 rounded-lg px-4 py-2">
                    </div>
                    <div>
                        <label class="block font-medium mb-1">Phường / Xã</label>
                        <input type="text" name="ward" required
                               class="w-full border border-gray-300 rounded-lg px-4 py-2">
                    </div>
                </div>

                <div>
                    <label class="block font-medium mb-1">Phương thức thanh toán</label>
                    <select name="paymentMethod"
                            class="w-full border border-gray-300 rounded-lg px-4 py-2">
                        <option value="COD">Thanh toán khi nhận hàng (COD)</option>
                        <option value="BANK">Chuyển khoản ngân hàng</option>
                    </select>
                </div>

                <div>
                    <label class="block font-medium mb-1">Ghi chú đơn hàng (nếu có)</label>
                    <textarea name="note" rows="2"
                              class="w-full border border-gray-300 rounded-lg px-4 py-2"></textarea>
                </div>

                <div class="flex justify-between mt-6">
                    <a href="${pageContext.request.contextPath}/Buyer/cart.jsp" class="text-green-700 font-medium hover:underline">
                        ← Quay lại giỏ hàng
                    </a>

                    <button type="submit"
                            class="bg-green-600 hover:bg-green-700 text-white font-semibold px-6 py-2 rounded-lg shadow">
                        Thanh Toán
                    </button>
                </div>
            </form>
        </div>
    </body>
</html>




