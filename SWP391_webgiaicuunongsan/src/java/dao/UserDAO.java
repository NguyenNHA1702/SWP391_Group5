package dao;


import java.sql.*;
import model.User;
import utils.DBUtil;

public class UserDAO {

 public static boolean isEmailExist(String email) {
    System.out.println("Check email: " + email); // Thêm dòng này
    return false; // Tạm thời bypass
}





    public static boolean register(User user) {
        String sql = "INSERT INTO users (full_name, email, password_hash, phone, role) " +
                     "VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword()); // hash nếu có
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getRole());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static User checkLogin(String email, String password) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
