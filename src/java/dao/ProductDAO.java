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

    public static List<Product> getProductsByUser(int userId) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE user_id = ?";

        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
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
                p.setCampaignId(rs.getInt("campaign_id")); // nếu bạn có thêm field này
                list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Product> getProductsByCampaign(int campaignId) {
        List<Product> list = new ArrayList<>();
        String sql = """
    SELECT ROW_NUMBER() OVER (ORDER BY product_id) AS stt, * 
    FROM products 
    WHERE campaign_id = ?
""";

        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, campaignId);  // chỉ cần set campaignId
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
                p.setCampaignId(rs.getInt("campaign_id"));
                p.setStt(rs.getInt("stt"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public static boolean insertProduct(Product p) {
        String sql = "INSERT INTO products (user_id, campaign_id, name, description, price, quantity, language, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, p.getUserId());
            stmt.setInt(2, p.getCampaignId());
            stmt.setString(3, p.getName());
            stmt.setString(4, p.getDescription());
            stmt.setDouble(5, p.getPrice());
            stmt.setInt(6, p.getQuantity());
            stmt.setString(7, p.getLanguage());
            stmt.setTimestamp(8, new Timestamp(System.currentTimeMillis()));
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void deleteProduct(int productId) throws Exception {
        String sql = "DELETE FROM products WHERE product_id = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.executeUpdate();
        }
    }

    public static void updateProduct(Product p) {
        String sql = "UPDATE products SET name=?, description=?, price=?, quantity=?, language=? WHERE product_id=?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getName());
            ps.setString(2, p.getDescription());
            ps.setDouble(3, p.getPrice());
            ps.setInt(4, p.getQuantity());
            ps.setString(5, p.getLanguage());
            ps.setInt(6, p.getProductId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Product> filterProducts(String name, Double minPrice, Double maxPrice, Boolean inStock) {
        List<Product> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Products WHERE 1=1");

        if (name != null && !name.trim().isEmpty()) {
            sql.append(" AND name LIKE ?");
        }
        if (minPrice != null) {
            sql.append(" AND price >= ?");
        }
        if (maxPrice != null) {
            sql.append(" AND price <= ?");
        }
        if (inStock != null && inStock) {
            sql.append(" AND quantity > 0");
        }

        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString());) {
            int index = 1;
            if (name != null && !name.trim().isEmpty()) {
                ps.setString(index++, "%" + name + "%");
            }
            if (minPrice != null) {
                ps.setDouble(index++, minPrice);
            }
            if (maxPrice != null) {
                ps.setDouble(index++, maxPrice);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                // Set các field từ rs
                p.setProductId(rs.getInt("product_id"));
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getDouble("price"));
                p.setQuantity(rs.getInt("quantity"));
                p.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> filterProductsByUser(int userId, String name, Double minPrice, Double maxPrice, Boolean inStock) {
        List<Product> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM products WHERE user_id = ?");

        if (name != null && !name.trim().isEmpty()) {
            sql.append(" AND name LIKE ?");
        }
        if (minPrice != null) {
            sql.append(" AND price >= ?");
        }
        if (maxPrice != null) {
            sql.append(" AND price <= ?");
        }
        if (inStock != null && inStock) {
            sql.append(" AND quantity > 0");
        }

        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int index = 1;
            ps.setInt(index++, userId);

            if (name != null && !name.trim().isEmpty()) {
                ps.setString(index++, "%" + name + "%");
            }
            if (minPrice != null) {
                ps.setDouble(index++, minPrice);
            }
            if (maxPrice != null) {
                ps.setDouble(index++, maxPrice);
            }

            ResultSet rs = ps.executeQuery();
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
                p.setCampaignId(rs.getInt("campaign_id"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Product> filterProductsByCampaign(int campaignId, String name, Double minPrice, Double maxPrice, Boolean inStock) {
        List<Product> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT ROW_NUMBER() OVER (ORDER BY product_id) AS stt, * FROM products WHERE campaign_id = ?");

        if (name != null && !name.trim().isEmpty()) {
            sql.append(" AND name LIKE ?");
        }
        if (minPrice != null) {
            sql.append(" AND price >= ?");
        }
        if (maxPrice != null) {
            sql.append(" AND price <= ?");
        }
        if (inStock != null && inStock) {
            sql.append(" AND quantity > 0");
        }

        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int index = 1;
            ps.setInt(index++, campaignId);

            if (name != null && !name.trim().isEmpty()) {
                ps.setString(index++, "%" + name + "%");
            }
            if (minPrice != null) {
                ps.setDouble(index++, minPrice);
            }
            if (maxPrice != null) {
                ps.setDouble(index++, maxPrice);
            }

            ResultSet rs = ps.executeQuery();
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
                p.setCampaignId(rs.getInt("campaign_id"));
                p.setStt(rs.getInt("stt"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

}
