<%-- 
    Document   : checkout
    Created on : 23 Jun 2025, 01:36:45
    Author     : HP
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Shipping Information - AgriRescue</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(rgba(0, 128, 0, 0.1), rgba(139, 69, 19, 0.1)), url('https://www.transparenttextures.com/patterns/leaf.png');
            background-size: cover;
            min-height: 100vh;
            color: #2d3e40;
            font-family: 'Inter', sans-serif;
        }
        .card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 1rem;
        }
        .gradient-btn {
            background: linear-gradient(90deg, #16a34a, #84cc16);
        }
        .gradient-btn:hover {
            background: linear-gradient(90deg, #15803d, #65a30d);
        }
        .action-btn {
            transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
        }
        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 14px rgba(0, 0, 0, 0.15);
        }
        .input-field:focus {
            border-color: #22c55e;
            box-shadow: 0 0 0 3px rgba(34, 197, 94, 0.2);
        }
    </style>
</head>
<body class="min-h-screen py-12">
    <div class="container mx-auto px-4">
        <div class="card max-w-2xl mx-auto p-8 shadow-2xl">
            <h2 class="text-3xl font-extrabold mb-6 text-green-900 flex items-center">
                🚚 Shipping Information
            </h2>

            <c:if test="${not empty errorMessage}">
                <div class="mb-4 text-red-600 font-semibold text-center">
                    ❌ ${errorMessage}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/checkout" method="post" class="space-y-6">
                <div>
                    <label class="block font-medium mb-1">Full Name</label>
                    <input type="text" name="fullName" required
                           class="w-full border border-gray-300 rounded-lg px-4 py-2 input-field transition">
                </div>

                <div>
                    <label class="block font-medium mb-1">Phone Number</label>
                    <input type="text" name="phone" required
                           class="w-full border border-gray-300 rounded-lg px-4 py-2 input-field transition">
                </div>

                <div>
                    <label class="block font-medium mb-1">Specific Address (Street, House No.)</label>
                    <input type="text" name="address" required
                           class="w-full border border-gray-300 rounded-lg px-4 py-2 input-field transition">
                </div>

                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <div>
                        <label class="block font-medium mb-1">Province / City</label>
                        <input type="text" name="province" required
                               class="w-full border border-gray-300 rounded-lg px-4 py-2 input-field transition">
                    </div>
                    <div>
                        <label class="block font-medium mb-1">District / County</label>
                        <input type="text" name="district" required
                               class="w-full border border-gray-300 rounded-lg px-4 py-2 input-field transition">
                    </div>
                    <div>
                        <label class="block font-medium mb-1">Ward / Commune</label>
                        <input type="text" name="ward" required
                               class="w-full border border-gray-300 rounded-lg px-4 py-2 input-field transition">
                    </div>
                </div>

                <div>
                    <label class="block font-medium mb-1">Payment Method</label>
                    <select name="paymentMethod"
                            class="w-full border border-gray-300 rounded-lg px-4 py-2 input-field transition">
                        <option value="COD">Cash on Delivery (COD)</option>
                        <option value="BANK">Bank Transfer</option>
                    </select>
                </div>

                <div>
                    <label class="block font-medium mb-1">Order Notes (Optional)</label>
                    <textarea name="note" rows="3"
                              class="w-full border border-gray-300 rounded-lg px-4 py-2 input-field transition"></textarea>
                </div>

                <div class="flex justify-between items-center mt-8">
                    <a href="${pageContext.request.contextPath}/Buyer/cart.jsp" class="text-green-700 font-semibold hover:underline action-btn">
                        ← Back to Cart
                    </a>
                    <button type="submit"
                            class="gradient-btn text-white font-semibold px-6 py-3 rounded-lg shadow action-btn">
                        Proceed to Payment
                    </button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>