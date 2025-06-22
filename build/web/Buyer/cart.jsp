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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
        .action-btn {
            transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
        }
        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 14px rgba(0, 0, 0, 0.15);
        }
        table tr {
            transition: background-color 0.3s ease;
        }
        .table-row:hover {
            transform: scale(1.01);
            transition: transform 0.2s ease-in-out;
        }
        .input-quantity {
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        .input-quantity:focus {
            border-color: #22c55e;
            box-shadow: 0 0 0 3px rgba(34, 197, 94, 0.2);
        }
        .btn {
            transition: all 0.3s ease;
        }
        .btn:hover {
            transform: translateY(-2px);
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
                <a href="javascript:history.back()" class="gradient-btn text-white px-6 py-3 rounded-xl font-semibold shadow-lg action-btn">
                    <i class="fas fa-arrow-left mr-2"></i> Back
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
                <form action="${pageContext.request.contextPath}/update-cart" method="post">
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead class="table-header">
                                <tr>
                                    <th class="py-4 px-6 text-left text-white font-semibold tracking-wide">Product Name</th>
                                    <th class="py-4 px-6 text-center text-white font-semibold tracking-wide">Quantity</th>
                                    <th class="py-4 px-6 text-right text-white font-semibold tracking-wide">Price</th>
                                    <th class="py-4 px-6 text-right text-white font-semibold tracking-wide">Subtotal</th>
                                    <th class="py-4 px-6 text-center text-white font-semibold tracking-wide">Action</th>
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
                                <tr class="table-row hover:bg-green-50 hover:bg-opacity-50">
                                    <td class="py-4 px-6 border-b border-green-200"><%= item.getProduct().getName() %></td>
                                    <td class="py-4 px-6 border-b border-green-200 text-center">
                                        <input type="hidden" name="productId" value="<%= item.getProduct().getProductId() %>">
                                        <input type="number" 
                                               name="quantity_<%= index %>" 
                                               value="<%= item.getQuantity() %>" 
                                               min="1"
                                               class="input-quantity w-16 border border-gray-300 px-2 py-1 text-center rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500"
                                               aria-label="Quantity for <%= item.getProduct().getName() %>">
                                    </td>
                                    <td class="py-4 px-6 border-b border-green-200 text-right">
                                        <fmt:formatNumber value="<%= item.getProduct().getPrice() %>" type="number" pattern="#,##0"/> ₫
                                    </td>
                                    <td class="py-4 px-6 border-b border-green-200 text-right font-medium text-green-700">
                                        <fmt:formatNumber value="<%= subtotal %>" type="number" pattern="#,##0"/> ₫
                                    </td>
                                    <td class="py-4 px-6 border-b border-green-200 text-center">
                                        <a href="${pageContext.request.contextPath}/remove-from-cart?productId=<%= item.getProduct().getProductId() %>"
                                           class="text-red-600 hover:text-red-800 font-bold transition duration-200 action-btn"
                                           title="Remove <%= item.getProduct().getName() %> from cart"
                                           aria-label="Remove <%= item.getProduct().getName() %> from cart">
                                            <i class="fas fa-trash-alt"></i>
                                        </a>
                                    </td>
                                </tr>
                                <%
                                        index++;
                                    }
                                %>
                                <tr class="bg-gray-100">
                                    <td colspan="3" class="py-4 px-6 text-right font-bold text-lg">Total:</td>
                                    <td colspan="2" class="py-4 px-6 text-right font-bold text-green-700 text-lg">
                                        <fmt:formatNumber value="<%= total %>" type="number" pattern="#,##0"/> ₫
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="flex flex-col sm:flex-row justify-between items-center mt-6 space-y-4 sm:space-y-0 sm:space-x-4">
                        <button type="submit" 
                                class="gradient-btn text-white font-semibold px-6 py-3 rounded-xl shadow-lg action-btn w-full sm:w-auto"
                                title="Update cart quantities">
                            <i class="fas fa-sync-alt mr-2"></i> Update Quantities
                        </button>
                        <form action="${pageContext.request.contextPath}/checkout" method="post">
                            <button type="submit" 
                                    class="gradient-btn text-white font-semibold px-6 py-3 rounded-xl shadow-lg action-btn w-full sm:w-auto"
                                    title="Proceed to checkout">
                                <i class="fas fa-check-circle mr-2"></i> Proceed to Checkout
                            </button>
                        </form>
                    </div>
                </form>
            </c:if>
        </div>
    </div>
</body>
</html>