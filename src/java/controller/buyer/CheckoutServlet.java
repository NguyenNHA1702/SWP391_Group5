/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
 /*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.buyer;

import dao.OrderDAO;
import dao.ShippingInfoDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.CartItem;
import model.ShippingInfo;
import model.User;

import java.io.IOException;
import java.util.List;


public class CheckoutServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        // 1. Kiểm tra đăng nhập
        User user = (User) session.getAttribute("account");
        if (user == null || !"buyer".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 2. Lấy giỏ hàng
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            request.setAttribute("errorMessage", "Giỏ hàng trống.");
            request.getRequestDispatcher("/Buyer/cart.jsp").forward(request, response);
            return;
        }

        // 3. Lấy thông tin từ form
        String name = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String province = request.getParameter("province");
        String district = request.getParameter("district");
        String ward = request.getParameter("ward");
        String paymentMethod = request.getParameter("paymentMethod");
        String note = request.getParameter("note"); // chưa lưu DB nhưng có thể dùng hiển thị

        // Validate cơ bản
        if (name == null || phone == null || address == null
                || name.trim().isEmpty() || phone.trim().isEmpty() || address.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ thông tin giao hàng.");
            request.getRequestDispatcher("/Buyer/checkout.jsp").forward(request, response);
            return;
        }

        try {
            // 4. Tạo ShippingInfo
            ShippingInfo info = new ShippingInfo();
            info.setUserId(user.getUserId());
            info.setRecipientName(name);
            info.setPhone(phone);
            info.setAddress(address);
            info.setProvince(province);
            info.setDistrict(district);
            info.setWard(ward);

            // 5. Lưu shipping_info → lấy shippingId
            int shippingId = ShippingInfoDAO.saveShippingInfo(info);

            // 6. Gọi placeOrder truyền thêm phương thức thanh toán
            boolean success = OrderDAO.placeOrder(user, cart, shippingId, paymentMethod, note);


            if (success) {
                session.removeAttribute("cart");
                response.sendRedirect("Buyer/order-success.jsp");
            } else {
                request.setAttribute("errorMessage", "Có lỗi khi đặt hàng. Vui lòng thử lại.");
                request.getRequestDispatcher("/Buyer/checkout.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("/Buyer/checkout.jsp").forward(request, response);
        }
    }
}
