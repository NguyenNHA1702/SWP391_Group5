/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author admin
 */
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import utils.DBUtil;

public class ProductDAO {

    public static List<Product> getAvailableProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE quantity > 0";

        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("product_id"));
                p.setUserId(rs.getInt("user_id"));
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getDouble("price"));
                p.setQuantity(rs.getInt("quantity"));
                p.setLanguage(rs.getString("language"));
                p.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products";

        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("product_id"));
                p.setUserId(rs.getInt("user_id"));
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getDouble("price"));
                p.setQuantity(rs.getInt("quantity"));
                p.setLanguage(rs.getString("language"));
                p.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public static Product getProductById(int productId) {
        Product product = null;
        String sql = "SELECT * FROM products WHERE product_id = ?";

        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    product = new Product();
                    product.setProductId(rs.getInt("product_id"));
                    product.setUserId(rs.getInt("user_id"));
                    product.setName(rs.getString("name"));
                    product.setDescription(rs.getString("description"));
                    product.setPrice(rs.getDouble("price"));
                    product.setQuantity(rs.getInt("quantity"));
                    product.setLanguage(rs.getString("language"));
                    product.setCreatedAt(rs.getTimestamp("created_at"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return product;
    }

    public static List<Product> searchAndSortProducts(String name, String sort) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE quantity > 0";

        if (name != null && !name.isEmpty()) {
            sql += " AND name LIKE ?";
        }

        if ("asc".equalsIgnoreCase(sort)) {
            sql += " ORDER BY price ASC";
        } else if ("desc".equalsIgnoreCase(sort)) {
            sql += " ORDER BY price DESC";
        }

        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            int paramIndex = 1;
            if (name != null && !name.isEmpty()) {
                stmt.setString(paramIndex++, "%" + name + "%");
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("product_id"));
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getDouble("price"));
                p.setQuantity(rs.getInt("quantity"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static List<Product> getProductsByNameSorted(String name, String sort) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE name LIKE ?";

        if ("desc".equalsIgnoreCase(sort)) {
            sql += " ORDER BY price DESC";
        } else if ("asc".equalsIgnoreCase(sort)) {
            sql += " ORDER BY price ASC";
        }

        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, "%" + name + "%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("product_id"));
                p.setUserId(rs.getInt("user_id"));
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getDouble("price"));
                p.setQuantity(rs.getInt("quantity"));
                p.setLanguage(rs.getString("language"));
                p.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

}
