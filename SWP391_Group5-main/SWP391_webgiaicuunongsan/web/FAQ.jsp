<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    Integer farmerId = (Integer) session.getAttribute("userId");
    if (farmerId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>FAQ - Campaign Platform</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        .faq-answer { display: none; }
        .faq-answer.show { display: block; }
        .faq-question { cursor: pointer; }
        .faq-question:hover { background-color: #f1f5f9; }
        .rotate { transform: rotate(180deg); }
    </style>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center py-8">
    <div class="bg-white p-8 rounded-lg shadow-lg w-full max-w-3xl">
        <h2 class="text-3xl font-bold mb-8 text-center text-gray-800">Frequently Asked Questions</h2>
        <div class="space-y-4">
            <div class="border-b border-gray-200">
                <div class="faq-question flex justify-between items-center py-4" onclick="toggleAnswer(this)">
                    <h3 class="text-lg font-semibold text-gray-700">1. What is this platform?</h3>
                    <svg class="w-5 h-5 text-gray-500 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path></svg>
                </div>
                <p class="faq-answer text-gray-600 mt-2 pb-4">This platform allows farmers to create campaigns to sell their agricultural products directly to consumers. You can set up campaigns with details like product name, quantity, price, and duration.</p>
            </div>
            <div class="border-b border-gray-200">
                <div class="faq-question flex justify-between items-center py-4" onclick="toggleAnswer(this)">
                    <h3 class="text-lg font-semibold text-gray-700">2. How do I create a campaign?</h3>
                    <svg class="w-5 h-5 text-gray-500 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path></svg>
                </div>
                <p class="faq-answer text-gray-600 mt-2 pb-4">Log in to your account, navigate to the "Create Campaign" page, and fill out the form with details such as title, product name, quantity, price, description, and campaign dates. Click "Create Campaign" to submit.</p>
            </div>
            <div class="border-b border-gray-200">
                <div class="faq-question flex justify-between items-center py-4" onclick="toggleAnswer(this)">
                    <h3 class="text-lg font-semibold text-gray-700">3. What happens after I create a campaign?</h3>
                    <svg class="w-5 h-5 text-gray-500 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path></svg>
                </div>
                <p class="faq-answer text-gray-600 mt-2 pb-4">Once submitted, your campaign will be reviewed and, if approved, listed on the platform for consumers to view and purchase your products.</p>
            </div>
            <div class="border-b border-gray-200">
                <div class="faq-question flex justify-between items-center py-4" onclick="toggleAnswer(this)">
                    <h3 class="text-lg font-semibold text-gray-700">4. Can I edit or delete a campaign?</h3>
                    <svg class="w-5 h-5 text-gray-500 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path></svg>
                </div>
                <p class="faq-answer text-gray-600 mt-2 pb-4">Yes, you can manage your campaigns from your dashboard. You can edit details or delete a campaign before it starts. Contact support for changes to active campaigns.</p>
            </div>
            <div class="border-b border-gray-200">
                <div class="faq-question flex justify-between items-center py-4" onclick="toggleAnswer(this)">
                    <h3 class="text-lg font-semibold text-gray-700">5. How do I receive payments?</h3>
                    <svg class="w-5 h-5 text-gray-500 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path></svg>
                </div>
                <p class="faq-answer text-gray-600 mt-2 pb-4">Payments are processed through the platform’s secure payment system. Funds will be transferred to your registered bank account after the campaign ends, minus any applicable fees.</p>
            </div>
            <div class="border-b border-gray-200">
                <div class="faq-question flex justify-between items-center py-4" onclick="toggleAnswer(this)">
                    <h3 class="text-lg font-semibold text-gray-700">6. What if I encounter issues?</h3>
                    <svg class="w-5 h-5 text-gray-500 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path></svg>
                </div>
                <p class="faq-answer text-gray-600 mt-2 pb-4">If you face any problems, visit the "Support" page or contact our team at support@platform.com. We’re here to help!</p>
            </div>
        </div>
        <div class="mt-8 text-center">
            <a href="home" class="inline-block bg-blue-600 text-white py-2 px-6 rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500">Back to Create Campaign</a>
        </div>
        
    </div>
    <script>
        function toggleAnswer(element) {
            const answer = element.nextElementSibling;
            const arrow = element.querySelector('svg');
            answer.classList.toggle('show');
            arrow.classList.toggle('rotate');
        }
    </script>
</body>
</html>