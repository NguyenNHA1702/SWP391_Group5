<%-- 
    Document   : inventory
    Created on : 18 Jun 2025, 23:16:11
    Updated on : 24 Jun 2025 (Thêm Search, hiển thị soldQty, disable Delete)
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Agricultural Inventory</title>
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
        .table-header {
            background: linear-gradient(90deg, #15803d, #4d7c0f);
        }
        .table-row:hover {
            transform: scale(1.01);
            transition: transform 0.2s ease-in-out;
        }
        .input-field:focus {
            border-color: #22c55e;
            box-shadow: 0 0 0 3px rgba(34, 197, 94, 0.2);
        }
        .sold-out {
            color: #dc2626;
            font-weight: 600;
            padding: 4px 12px;
            border-radius: 16px;
            background-color: rgba(220, 38, 38, 0.1);
            transition: transform 0.2s ease, background-color 0.2s ease;
        }
        .sold-out:hover {
            transform: scale(1.1);
            background-color: rgba(220, 38, 38, 0.2);
        }
    </style>
</head>
<body class="min-h-screen py-12">
    <div class="container mx-auto px-4 sm:px-6 lg:px-8">
        <div class="card p-6 shadow-2xl mb-8">
            <h2 class="text-3xl font-extrabold text-green-900 mb-6 flex items-center">
                🌾 My Agricultural Inventory
            </h2>
        </div>

        <div class="flex justify-between items-center mb-8">
            <form method="get" action="${pageContext.request.contextPath}/farmer/inventory" class="flex space-x-3 items-center">
                <input type="hidden" name="campaignId" value="${param.campaignId}" />
                <input type="text" name="name" placeholder="Search product name..." value="${param.name}" class="input-field border rounded-lg px-4 py-2">
                <input type="number" name="minPrice" placeholder="Min price..." value="${param.minPrice}" class="input-field border rounded-lg px-4 py-2">
                <input type="number" name="maxPrice" placeholder="Max price..." value="${param.maxPrice}" class="input-field border rounded-lg px-4 py-2">
                <label class="flex items-center">
                    <input type="checkbox" name="inStock" value="true" ${param.inStock == 'true' ? 'checked' : ''} class="mr-1">
                    In Stock
                </label>
                <button type="submit" class="gradient-btn text-white px-4 py-2 rounded-lg action-btn">🔍 Filter</button>
            </form>

            <div class="flex gap-4">
                <c:if test="${sessionScope.role == 'farmer'}">
                    <a href="${pageContext.request.contextPath}/Farmer/createProduct.jsp?campaignId=${param.campaignId}"
                       class="gradient-btn text-white font-bold py-2 px-4 rounded-lg action-btn">➕ Add New Product</a>
                </c:if>
                <a href="${pageContext.request.contextPath}/home"
                   class="gradient-btn text-white font-semibold py-2 px-6 rounded-xl shadow action-btn">🏠 Back</a>
            </div>
        </div>

        <div class="card p-6 shadow-2xl">
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="table-header text-white">
                        <tr>
                            <th class="px-6 py-3 text-left text-sm font-bold">No.</th>
                            <th class="px-6 py-3 text-left text-sm font-bold">Name</th>
                            <th class="px-6 py-3 text-left text-sm font-bold">Description</th>
                            <th class="px-6 py-3 text-left text-sm font-bold">Price</th>
                            <th class="px-6 py-3 text-left text-sm font-bold">Quantity</th>
                            <th class="px-6 py-3 text-left text-sm font-bold">Sold</th>
                            <th class="px-6 py-3 text-left text-sm font-bold">Created At</th>
                            <th class="px-6 py-3 text-left text-sm font-bold">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                        <c:forEach var="p" items="${products}">
                            <tr class="table-row">
                                <td class="px-6 py-4">${p.stt}</td>
                                <td class="px-6 py-4">${p.name}</td>
                                <td class="px-6 py-4">${p.description}</td>
                                <td class="px-6 py-4"><fmt:formatNumber value="${p.price}" type="number" pattern="#,##0"/> ₫</td>
                                <td class="px-6 py-4">${p.quantity}</td>
                                <td class="px-6 py-4">${p.soldQty}</td>
                                <td class="px-6 py-4">${p.createdAt}</td>
                                <td class="px-6 py-4">
                                    <c:choose>
                                        <c:when test="${sessionScope.role == 'farmer'}">
                                            <div class="flex space-x-2">
                                                <a href="${pageContext.request.contextPath}/edit?id=${p.productId}&campaignId=${param.campaignId}"
                                                   class="gradient-btn text-black px-4 py-2 rounded-md action-btn">✏️ Edit</a>
                                                <form action="${pageContext.request.contextPath}/delete" method="post"
                                                      onsubmit="return confirm('Are you sure you want to delete this product?');">
                                                    <input type="hidden" name="productId" value="${p.productId}"/>
                                                    <input type="hidden" name="campaignId" value="${param.campaignId}"/>
                                                    <button type="submit"
                                                            class="px-4 py-2 rounded-md font-medium text-white ${p.soldQty > 0 ? 'bg-gray-400 cursor-not-allowed' : 'gradient-btn'}"
                                                            ${p.soldQty > 0 ? 'disabled' : ''}>
                                                        🗑️ Delete
                                                    </button>
                                                </form>
                                            </div>
                                        </c:when>
                                        <c:when test="${sessionScope.role == 'buyer'}">
                                            <c:choose>
                                                <c:when test="${p.quantity > 0}">
                                                    <form action="${pageContext.request.contextPath}/add-to-cart" method="post">
                                                        <input type="hidden" name="productId" value="${p.productId}" />
                                                        <input type="hidden" name="productName" value="${p.name}" />
                                                        <input type="hidden" name="price" value="${p.price}" />
                                                        <input type="hidden" name="quantity" value="1" />
                                                        <input type="hidden" name="campaignId" value="${param.campaignId}" />
                                                        <button type="submit"
                                                                class="gradient-btn text-white px-4 py-2 rounded-md action-btn">
                                                            🛒 Add to Cart
                                                        </button>
                                                    </form>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="sold-out">Sold Out</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-gray-400">N/A</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>