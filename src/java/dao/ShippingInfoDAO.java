/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author HP
 */
package dao;

import model.ShippingInfo;
import utils.DBUtil;

import java.sql.*;

public class ShippingInfoDAO {

    // Lưu thông tin giao hàng vào DB, trả về shipping_id mới tạo
    public static int saveShippingInfo(ShippingInfo info) throws Exception {
        int generatedId = -1;

        String sql = "INSERT INTO shipping_info "
                + "(user_id, recipient_name, phone, address, province, district, ward, is_default, created_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, 0, GETDATE())";

        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, info.getUserId());
            ps.setString(2, info.getRecipientName());
            ps.setString(3, info.getPhone());
            ps.setString(4, info.getAddress());
            ps.setString(5, info.getProvince());
            ps.setString(6, info.getDistrict());
            ps.setString(7, info.getWard());

            int affectedRows = ps.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        generatedId = rs.getInt(1);
                    }
                }
            }
        }

        return generatedId;
    }
}
