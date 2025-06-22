<%-- 
    Document   : cartButton
    Created on : 22 Jun 2025, 22:35:54
    Author     : HP
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.CartItem" %>

<%
    
    if (role != null && "buyer".equals(role)) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        int cartCount = (cart == null) ? 0 : cart.size();
%>
    <a href="<%= request.getContextPath() %>/Buyer/cart.jsp"
       class="relative flex items-center bg-white text-green-700 px-4 py-2 rounded-full shadow-md hover:bg-green-50 hover:shadow-lg transition-all duration-300 ml-3 text-sm font-medium" 
       title="View your cart">
        <i class="fas fa-shopping-cart mr-2"></i>
        🧺 Cart
        <span class="absolute -top-2 -right-2 bg-red-500 text-white text-xs font-bold rounded-full w-5 h-5 flex items-center justify-center">
            <%= cartCount %>
        </span>
    </a>
<%
    }
%>
