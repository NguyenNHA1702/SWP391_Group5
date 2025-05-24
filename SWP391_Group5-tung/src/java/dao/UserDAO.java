package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;
import utils.DBUtil;

public class UserDAO {

    public static final UserDAO INSTANCE = new UserDAO();

    public static boolean isUsernameExist(String username) {
        String query = "SELECT 1 FROM users WHERE username = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public static boolean isEmailExist(String email) {
        String query = "SELECT 1 FROM users WHERE email = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public static boolean isPhoneExist(String phone) {
        String query = "SELECT 1 FROM users WHERE phone = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public static boolean register(User user) {
        String sql = "INSERT INTO users (username, password, name, email, phone, role, created_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, GETDATE())";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPhone());
            ps.setString(6, user.getRole());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }
    
    public static User checkLogin(String usernameOrEmail, String password) {
    String sql = "SELECT * FROM users WHERE (username = ? OR email = ?) AND password = ?";
    try (Connection conn = DBUtil.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, usernameOrEmail);
        ps.setString(2, usernameOrEmail);
        ps.setString(3, password);

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setFullName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                return user;
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return null;
}


}
