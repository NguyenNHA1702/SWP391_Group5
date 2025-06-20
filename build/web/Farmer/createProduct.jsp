<%-- 
    Document   : createProduct
    Created on : 19 Jun 2025, 06:15:37
    Author     : HP
    Updated on : 20 Jun 2025
--%>

<%-- 
    Document   : createProduct
    Created on : 19 Jun 2025
    Updated on : 20 Jun 2025
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String campaignId = request.getParameter("campaignId");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Agricultural Product</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            background: linear-gradient(rgba(0, 128, 0, 0.1), rgba(139, 69, 19, 0.1)), url('https://www.transparenttextures.com/patterns/leaf.png');
            background-size: cover;
            min-height: 100vh;
            color: #2d3e40;
            font-family: 'Inter', sans-serif;
        }
        .form-container {
            max-width: 600px;
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
        .card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 1rem;
        }
        input, select {
            transition: border-color 0.3s ease;
        }
        input:focus, select:focus {
            border-color: #16a34a;
            outline: none;
        }
    </style>
</head>
<body>
    <div class="min-h-screen py-12">
        <div class="form-container px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center mb-8">
                <h3 class="text-4xl font-extrabold flex items-center tracking-tight text-green-900">
                    <span class="mr-3">🌱</span> Add New Agricultural Product
                </h3>
                <a href="${pageContext.request.contextPath}/farmer/inventory?campaignId=${param.campaignId}" class="gradient-btn text-white px-6 py-3 rounded-xl font-semibold shadow-lg action-btn">
                    🔙 Back to Inventory
                </a>
            </div>

            <div class="card shadow-2xl p-8">

                <!-- Hiển thị lỗi -->
                <c:if test="${not empty errorMessage}">
                    <div class="mb-4 text-red-600 font-semibold">${errorMessage}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/add" method="post" class="space-y-6">
                    <input type="hidden" name="campaignId" value="${param.campaignId != null ? param.campaignId : campaignId}" />

                    <div>
                        <label for="name" class="block text-sm font-medium text-gray-700">Product Name</label>
                        <input type="text" name="name" id="name"
                               value="${name}" 
                               class="mt-1 block w-full rounded-lg border border-gray-300 p-3 focus:border-green-600 focus:ring focus:ring-green-200 focus:ring-opacity-50"
                               placeholder="Enter product name" />
                    </div>

                    <div>
                        <label for="description" class="block text-sm font-medium text-gray-700">Description</label>
                        <input type="text" name="description" id="description"
                               value="${description}" 
                               class="mt-1 block w-full rounded-lg border border-gray-300 p-3 focus:border-green-600 focus:ring focus:ring-green-200 focus:ring-opacity-50"
                               placeholder="Enter product description" />
                    </div>

                    <div>
                        <label for="price" class="block text-sm font-medium text-gray-700">Price (VND, in thousands)</label>
                        <input type="number" name="price" id="price" step="1000"
                               value="${price}" 
                               class="mt-1 block w-full rounded-lg border border-gray-300 p-3 focus:border-green-600 focus:ring focus:ring-green-200 focus:ring-opacity-50"
                               placeholder="Enter price (e.g., 1000 for 1,000,000 VND)" />
                    </div>

                    <div>
                        <label for="quantity" class="block text-sm font-medium text-gray-700">Quantity</label>
                        <input type="number" name="quantity" id="quantity"
                               value="${quantity}" 
                               class="mt-1 block w-full rounded-lg border border-gray-300 p-3 focus:border-green-600 focus:ring focus:ring-green-200 focus:ring-opacity-50"
                               placeholder="Enter quantity" />
                    </div>

                    <div>
                        <label for="language" class="block text-sm font-medium text-gray-700">Language</label>
                        <select name="language" id="language" class="mt-1 block w-full rounded-lg border border-gray-300 p-3 focus:border-green-600 focus:ring focus:ring-green-200 focus:ring-opacity-50">
                            <option value="vi" <c:if test="${language == 'vi'}">selected</c:if>>Vietnamese</option>
                            <option value="en" <c:if test="${language == 'en'}">selected</c:if>>English</option>
                        </select>
                    </div>

                    <div>
                        <button type="submit" class="gradient-btn text-white px-6 py-3 rounded-xl font-semibold shadow-lg action-btn w-full">
                            ➕ Add Product
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
