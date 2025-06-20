<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.Product" %>

<%
    Product product = (Product) request.getAttribute("product");
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Edit Product</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <style>
            body {
                background: linear-gradient(rgba(0, 128, 0, 0.1), rgba(139, 69, 19, 0.1));
                min-height: 100vh;
                font-family: 'Inter', sans-serif;
            }
            .form-container {
                max-width: 600px;
                margin: 0 auto;
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
        </style>
    </head>
    <body>
        <div class="min-h-screen py-12">
            <div class="form-container px-4 sm:px-6 lg:px-8">
                <div class="flex justify-between items-center mb-8">
                    <h3 class="text-4xl font-extrabold text-green-900 flex items-center">
                        <span class="mr-2">✏️</span> Edit Product
                    </h3>
                    <a href="${pageContext.request.contextPath}/farmer/inventory?campaignId=${param.campaignId}" class="gradient-btn text-white px-6 py-3 rounded-xl font-semibold shadow-lg action-btn">
                        🔙 Back to Inventory
                    </a>

                </div>

                <div class="card shadow-2xl p-8">
                    <c:if test="${not empty error}">    
                        <div class="mb-4 text-red-600 font-semibold">${error}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/edit" method="post" class="space-y-6">
                        <!-- Hidden productId và campaignId -->
                        <input type="hidden" name="productId" value="${product.productId}" />
                        <input type="hidden" name="campaignId" value="${product.campaignId}" />

                        <div>
                            <label class="block text-sm font-medium text-gray-700">Product Name</label>
                            <input type="text" name="name" value="${product.name}" required
                                   class="mt-1 block w-full rounded-lg border border-gray-300 p-3 focus:border-green-600" />
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700">Description</label>
                            <input type="text" name="description" value="${product.description}" required
                                   class="mt-1 block w-full rounded-lg border border-gray-300 p-3 focus:border-green-600" />
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700">Price (VND)</label>
                            <input type="number" name="price" step="1000" value="${product.price}" required
                                   class="mt-1 block w-full rounded-lg border border-gray-300 p-3 focus:border-green-600" />
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700">Quantity</label>
                            <input type="number" name="quantity" value="${product.quantity}" required
                                   class="mt-1 block w-full rounded-lg border border-gray-300 p-3 focus:border-green-600" />
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700">Language</label>
                            <select name="language"
                                    class="mt-1 block w-full rounded-lg border border-gray-300 p-3 focus:border-green-600">
                                <option value="vi" ${product.language == 'vi' ? 'selected' : ''}>Vietnamese</option>
                                <option value="en" ${product.language == 'en' ? 'selected' : ''}>English</option>
                            </select>
                        </div>

                        <div>
                            <button type="submit"
                                    class="gradient-btn text-white px-6 py-3 rounded-xl font-semibold shadow-lg w-full">
                                💾 Save
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
