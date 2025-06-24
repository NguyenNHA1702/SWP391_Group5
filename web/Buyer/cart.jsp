<%-- 
    Document   : cart
    Created on : 22 Jun 2025, 22:58:15
    Author     : HP
    Updated on : 23 Jun 2025
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.CartItem, model.Product" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Your Shopping Cart - AgriRescue</title>
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
            .table-header {
                background: linear-gradient(90deg, #15803d, #4d7c0f);
            }
            .gradient-btn {
                background: linear-gradient(90deg, #16a34a, #84cc16);
            }
            .gradient-btn:hover {
                background: linear-gradient(90deg, #15803d, #65a30d);
            }
            .action-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 14px rgba(0, 0, 0, 0.15);
            }
        </style>
    </head>
    <body class="min-h-screen py-12">
        <div class="table-container px-4 sm:px-6 lg:px-8">
            <div class="card max-w-5xl w-full mx-auto p-8 shadow-2xl">
                <div class="flex justify-between items-center mb-8">
                    <h2 class="text-4xl font-extrabold flex items-center tracking-tight text-green-900">
                        <i class="fas fa-shopping-cart mr-3"></i> Your Cart
                    </h2>
                    <a href="${pageContext.request.contextPath}/farmer/inventory?campaignId=${param.campaignId}"
                       class="gradient-btn text-white px-6 py-3 rounded-xl shadow-lg action-btn">
                        <i class="fas fa-arrow-left mr-2"></i> Back to Inventory
                    </a>

                </div>

                <c:if test="${empty cart}">
                    <div class="text-center py-12">
                        <i class="fas fa-cart-arrow-down text-5xl text-gray-400 mb-4"></i>
                        <p class="text-lg text-gray-600 mb-4">Your cart is empty.</p>
                        <a href="productList" class="gradient-btn text-white px-6 py-3 rounded-xl font-semibold shadow-lg action-btn">
                            <i class="fas fa-store mr-2"></i> Shop Now
                        </a>
                    </div>
                </c:if>

                <c:if test="${not empty cart}">
                    <form method="post">
                        <input type="hidden" name="campaignId" value="${param.campaignId}">

                        <div class="overflow-x-auto">
                            <table class="w-full">
                                <thead class="table-header">
                                    <tr>
                                        <th class="py-4 px-6 text-left text-white font-semibold">Product Name</th>
                                        <th class="py-4 px-6 text-center text-white font-semibold">Quantity</th>
                                        <th class="py-4 px-6 text-right text-white font-semibold">Price</th>
                                        <th class="py-4 px-6 text-right text-white font-semibold">Subtotal</th>
                                        <th class="py-4 px-6 text-center text-white font-semibold">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        double total = 0;
                                        int index = 0;
                                        for (CartItem item : cart) {
                                            double subtotal = item.getSubtotal();
                                            total += subtotal;
                                    %>
                                    <tr class="hover:bg-green-50">
                                        <td class="py-4 px-6 border-b"><%= item.getProduct().getName() %></td>
                                        <td class="py-4 px-6 border-b text-center">
                                            <input type="hidden" name="productId" value="<%= item.getProduct().getProductId() %>">
                                            <input type="number" name="quantity_<%= index %>" value="<%= item.getQuantity() %>" min="1"
                                                   class="w-16 border px-2 py-1 text-center rounded">
                                        </td>
                                        <td class="py-4 px-6 border-b text-right">
                                            <fmt:formatNumber value="<%= item.getProduct().getPrice() %>" type="number" pattern="#,##0"/> ₫
                                        </td>
                                        <td class="py-4 px-6 border-b text-right text-green-700 font-semibold">
                                            <fmt:formatNumber value="<%= subtotal %>" type="number" pattern="#,##0"/> ₫
                                        </td>
                                        <td class="py-4 px-6 border-b text-center">
                                            <a href="${pageContext.request.contextPath}/remove-from-cart?productId=<%= item.getProduct().getProductId() %>&campaignId=${param.campaignId}"
                                               class="text-red-600 font-bold hover:underline">❌</a>
                                        </td>
                                    </tr>
                                    <%
                                            index++;
                                        }
                                    %>
                                    <tr class="bg-gray-100 font-bold">
                                        <td colspan="3" class="py-4 px-6 text-right">Total:</td>
                                        <td colspan="2" class="py-4 px-6 text-right text-green-700">
                                            <fmt:formatNumber value="<%= total %>" type="number" pattern="#,##0"/> ₫
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <!-- Nút Update và Checkout -->
                        <div class="flex flex-col sm:flex-row justify-between items-center mt-6 space-y-4 sm:space-y-0 sm:space-x-4">
                            <button type="submit"
                                    formaction="${pageContext.request.contextPath}/update-cart?campaignId=${param.campaignId}"

                                    class="gradient-btn text-white font-semibold px-6 py-3 rounded-xl shadow-lg action-btn w-full sm:w-auto">
                                <i class="fas fa-sync-alt mr-2"></i> Update Quantities
                            </button>
                            <button type="submit"
                                    formaction="${pageContext.request.contextPath}/checkout"

                                    class="gradient-btn text-white font-semibold px-6 py-3 rounded-xl shadow-lg action-btn w-full sm:w-auto">
                                <i class="fas fa-check-circle mr-2"></i> Proceed to Checkout
                            </button>
                        </div>
                    </form>
                </c:if>
            </div>
        </div>
    </body>
</html>
