<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    Integer farmerId = (Integer) session.getAttribute("farmerId");
    if (farmerId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
    <head>
        <title>Create Campaign</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    </head>
    <body class="bg-gray-100 min-h-screen flex items-center justify-center">
        <div class="bg-white p-8 rounded-lg shadow-lg w-full max-w-md">
            <h2 class="text-2xl font-bold mb-6 text-center text-gray-800">Create a New Campaign</h2>
            <form action="CreateCampaignServlet" method="post" class="space-y-4">
                <div>
                    <label for="title" class="block text-sm font-medium text-gray-700">Title</label>
                    <input type="text" id="title" name="title" required 
                           class="mt-1 w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>

                <div>
                    <label for="productName" class="block text-sm font-medium text-gray-700">Product Name</label>
                    <input type="text" id="productName" name="productName" required 
                           class="mt-1 w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>

                <div>
                    <label for="quantity" class="block text-sm font-medium text-gray-700">Quantity (kg)</label>
                    <input type="number" id="quantity" name="quantity" required 
                           class="mt-1 w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>

                <div>
                    <label for="price" class="block text-sm font-medium text-gray-700">Price per kg ($)</label>
                    <input type="text" id="price" name="price" required 
                           class="mt-1 w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>

                

                <div>
                    <label for="personInCharge" class="block text-sm font-medium text-gray-700">Person in Charge</label>
                    <input type="text" id="personInCharge" name="personInCharge" required 
                           class="mt-1 w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>

                <div>
                    <label for="description" class="block text-sm font-medium text-gray-700">Description</label>
                    <textarea id="description" name="description" rows="4" 
                              class="mt-1 w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500"></textarea>
                </div>

                <div>
                    <label for="startDate" class="block text-sm font-medium text-gray-700">Start Date</label>
                    <input type="date" id="startDate" name="startDate" required 
                           class="mt-1 w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>

                <div>
                    <label for="endDate" class="block text-sm font-medium text-gray-700">End Date</label>
                    <input type="date" id="endDate" name="endDate" required 
                           class="mt-1 w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>

                <div class="text-center">
                    <input type="submit" value="Create Campaign" 
                           class="w-full bg-blue-600 text-white py-2 px-4 rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 cursor-pointer">
                </div>
            </form>
        </div>
    </body>
</html>