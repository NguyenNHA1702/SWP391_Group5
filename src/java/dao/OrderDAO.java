/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.CartItem;
import model.User;
import utils.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.util.List;

public class OrderDAO {

    public static boolean placeOrder(User user, List<CartItem> cart, int shippingId, String paymentMethod, String note) throws Exception {
        Connection conn = null;
        PreparedStatement psOrder = null;
        PreparedStatement psItem = null;
        PreparedStatement psUpdateStock = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false); // Transaction

            // 1. Tính tổng tiền
            double totalAmount = 0;
            for (CartItem item : cart) {
                totalAmount += item.getSubtotal();
            }

            // 2. Thêm đơn hàng có note
            String sqlOrder = "INSERT INTO orders "
                    + "(user_id, shipping_id, order_date, payment_method, shipping_fee, total_amount, status, note) "
                    + "VALUES (?, ?, GETDATE(), ?, 0, ?, 'pending', ?)";

            psOrder = conn.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS);
            psOrder.setInt(1, user.getUserId());
            psOrder.setInt(2, shippingId);
            psOrder.setString(3, paymentMethod);
            psOrder.setDouble(4, totalAmount);
            psOrder.setString(5, note); // ✅ đảm bảo cột note có trong bảng orders
            psOrder.executeUpdate();

            rs = psOrder.getGeneratedKeys();
            int orderId = -1;
            if (rs.next()) {
                orderId = rs.getInt(1);
            } else {
                conn.rollback();
                return false;
            }

            // 3. Thêm từng sản phẩm
            String sqlItem = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
            psItem = conn.prepareStatement(sqlItem);

            String sqlUpdate = "UPDATE products SET quantity = quantity - ? WHERE product_id = ?";
            psUpdateStock = conn.prepareStatement(sqlUpdate);

            for (CartItem item : cart) {
                int productId = item.getProduct().getProductId();
                int quantity = item.getQuantity();
                double price = item.getProduct().getPrice();

                // order_items
                psItem.setInt(1, orderId);
                psItem.setInt(2, productId);
                psItem.setInt(3, quantity);
                psItem.setDouble(4, price);
                psItem.addBatch();

                // trừ tồn kho
                psUpdateStock.setInt(1, quantity);
                psUpdateStock.setInt(2, productId);
                psUpdateStock.addBatch();
            }

            psItem.executeBatch();
            psUpdateStock.executeBatch();

            conn.commit();
            return true;

        } catch (Exception ex) {
            if (conn != null) {
                conn.rollback();
            }
            ex.printStackTrace();
            return false;
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (psOrder != null) {
                psOrder.close();
            }
            if (psItem != null) {
                psItem.close();
            }
            if (psUpdateStock != null) {
                psUpdateStock.close();
            }
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
    }

}
