<%-- 
    Document   : inventory
    Created on : 18 Jun 2025, 23:16:11
    Author     : HP
    Updated on : 19 Jun 2025
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Agricultural Inventory</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <style>
            body {
                background: linear-gradient(rgba(0, 128, 0, 0.1), rgba(139, 69, 19, 0.1)), url('https://www.transparenttextures.com/patterns/leaf.png');
                background-size: cover;
                min-height: 100vh;
                color: #2d3e40;
                font-family: 'Inter', sans-serif;
            }
            .table-container {
                max-width: 1280px;
                margin: 0 auto;
            }
            .action-btn {
                transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
            }
            .action-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 14px rgba(0, 0, 0, 0.15);
            }
            .gradient-btn {
                background: linear-gradient(90deg, #16a34a, #84cc16);
            }
            .gradient-btn:hover {
                background: linear-gradient(90deg, #15803d, #65a30d);
            }
            .table-header {
                background: linear-gradient(90deg, #15803d, #4d7c0f);
            }
            table tr {
                transition: background-color 0.3s ease;
            }
            .card {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                border-radius: 1rem;
            }
        </style>
    </head>
    <body>
        <div class="min-h-screen py-12">
            <div class="table-container px-4 sm:px-6 lg:px-8">
                <div class="flex justify-between items-center mb-8">
                    <h2 class="text-4xl font-extrabold flex items-center tracking-tight text-green-900">
                        <span class="mr-3">🌾</span> My Agricultural Inventory
                    </h2>
                    <a href="${pageContext.request.contextPath}/home" class="gradient-btn text-white px-6 py-3 rounded-xl font-semibold shadow-lg action-btn">
                        🏠 Back to Homepage
                    </a>
                </div>

                <c:if test="${sessionScope.role == 'farmer'}">
                    <div class="mb-8">
                        <a href="createProduct.jsp" class="gradient-btn text-white px-6 py-3 rounded-xl font-semibold shadow-lg action-btn">
                            🌱 Add New Product
                        </a>
                    </div>
                </c:if>

                <div class="card shadow-2xl">
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead class="table-header">
                                <tr>
                                    <th class="py-4 px-6 text-left text-white font-semibold tracking-wide">STT</th>
                                    <!--                                    <th class="py-4 px-6 text-left text-white font-semibold tracking-wide">ID</th>-->
                                    <th class="py-4 px-6 text-left text-white font-semibold tracking-wide">Name</th>
                                    <th class="py-4 px-6 text-left text-white font-semibold tracking-wide">Description</th>
                                    <th class="py-4 px-6 text-left text-white font-semibold tracking-wide">Price (VND)</th>
                                    <th class="py-4 px-6 text-left text-white font-semibold tracking-wide">Quantity</th>
                                    <th class="py-4 px-6 text-left text-white font-semibold tracking-wide">Created At</th>
                                    <th class="py-4 px-6 text-left text-white font-semibold tracking-wide">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="p" items="${products}">
                                    <tr class="hover:bg-green-50 hover:bg-opacity-50">
                                        <td class="py-4 px-6 border-b border-green-200">${p.stt}</td>


                                        <td class="py-4 px-6 border-b border-green-200">${p.name}</td>
                                        <td class="py-4 px-6 border-b border-green-200">${p.description}</td>
                                        <td class="py-4 px-6 border-b border-green-200"><fmt:formatNumber value="${p.price}" type="number" pattern="#,##0"/> ₫</td>
                                        <td class="py-4 px-6 border-b border-green-200">${p.quantity}</td>
                                        <td class="py-4 px-6 border-b border-green-200">${p.createdAt}</td>
                                        <td class="py-4 px-6 border-b border-green-200">
                                            <c:choose>
                                                <c:when test="${sessionScope.role == 'farmer'}">
                                                    <div class="flex space-x-3">
                                                        <a href="editProduct.jsp?id=${p.productId}" class="action-btn bg-amber-400 text-gray-900 px-4 py-2 rounded-lg font-medium hover:bg-amber-500">
                                                            ✏️ Edit
                                                        </a>
                                                        <form action="DeleteProductServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this product?');">
                                                            <input type="hidden" name="productId" value="${p.productId}" />
                                                            <button type="submit" class="action-btn bg-red-600 text-white px-4 py-2 rounded-lg font-medium hover:bg-red-700">
                                                                🗑️ Delete
                                                            </button>
                                                        </form>
                                                    </div>
                                                </c:when>
                                                <c:when test="${sessionScope.role == 'buyer'}">
                                                    <form action="OrderServlet" method="post">
                                                        <input type="hidden" name="productId" value="${p.productId}" />
                                                        <button type="submit" class="action-btn gradient-btn text-white px-4 py-2 rounded-lg font-medium">
                                                            🛒 Buy Now
                                                        </button>
                                                    </form>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-gray-500">N/A</span>
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
        </div>
    </body>
</html>