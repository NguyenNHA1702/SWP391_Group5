package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import model.User;
import utils.DBUtil;
import java.sql.Types;


public class UserDAO {




    public static final UserDAO INSTANCE = new UserDAO();
    private static final Logger LOGGER = Logger.getLogger(UserDAO.class.getName());

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
    String sql = "INSERT INTO users (username, password, name, email, phone, role, created_at, document_path, isApproved) "
               + "VALUES (?, ?, ?, ?, ?, ?, GETDATE(), ?, ?)";

    try (Connection conn = DBUtil.getConnection(); 
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, user.getUsername());
        ps.setString(2, user.getPassword());
        ps.setString(3, user.getFullName());
        ps.setString(4, user.getEmail());
        ps.setString(5, user.getPhone());
        ps.setString(6, user.getRole());
        ps.setString(7, user.getDocumentPath()); 

        // Gán isApproved theo role
        if ("buyer".equalsIgnoreCase(user.getRole())) {
            ps.setBoolean(8, true); // Buyer (active) 
        } else {
            ps.setNull(8, java.sql.Types.BOOLEAN); // Farmerb(Pending)
        }

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
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setFullName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setApproved(rs.getBoolean("isApproved"));
                return user;
                
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return null;
}
    
    public int getUserIdByUsername(String username) {
    String sql = "SELECT user_id FROM users WHERE username = ?";
    try (Connection conn = DBUtil.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt("user_id");
        }
    } catch (Exception e) {
        e.printStackTrace(); // Hoặc dùng Logger như các hàm khác
    }
    return -1; // Không tìm thấy hoặc có lỗi
}

public boolean updateProfile(String username, String fullName, String email, String phone) {
        String sql = "UPDATE users SET name = ?, email = ?, phone = ? WHERE username = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, phone != null && !phone.isEmpty() ? phone : null);
           
            ps.setString(5, username);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
            return false;
        }
    }

    public boolean updatePassword(String username, String newPassword) {
        String sql = "UPDATE users SET password = ? WHERE username = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setString(2, username);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
            return false;
        }
    }

    public boolean deleteAccount(String username) {
        String sql = "DELETE FROM users WHERE username = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
            return false;
        }
    }
          

        
           public User getUserByUsername(String username) throws SQLException, Exception {
    String sql = "SELECT * FROM users WHERE username = ?";
    try (Connection con = DBUtil.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            User user = new User(
                rs.getString("name"),
                rs.getString("email"),
                rs.getString("phone"),
                rs.getString("username"),
                rs.getString("password"),
                null, // 🔄 address không tồn tại
                rs.getString("role")
            );
            user.setUserId(rs.getInt("user_id")); // ✅ THÊM DÒNG NÀY
            return user;
        }
    }
    return null;
}

    public List<User> getManageableUsers(String search, String status) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT user_id, name, email, phone, username, password, role, document_path, created_at, isApproved FROM dbo.users WHERE role NOT IN ('admin')";
        List<Object> params = new ArrayList<>();

        if (search != null && !search.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(search.trim());
                sql += " AND user_id = ?";
                params.add(id);
            } catch (NumberFormatException e) {
                sql += " AND (name LIKE ? OR email LIKE ?)";
                params.add("%" + search + "%");
                params.add("%" + search + "%");
            }
        }

        if (status != null && !status.isEmpty()) {
            switch (status) {
                case "Pending" -> sql += " AND isApproved IS NULL";
                case "Active" -> sql += " AND isApproved = 1";
                case "Deactivated" -> sql += " AND isApproved = 0";
            }
        }

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setFullName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("phone"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setRole(rs.getString("role"));
                    user.setDocumentPath(rs.getString("document_path"));
                    user.setCreatedAt(rs.getTimestamp("created_at"));

                    Object approvedObj = rs.getObject("isApproved");
                    if (approvedObj == null) {
                        user.setApproved(null);
                    } else {
                        user.setApproved(rs.getBoolean("isApproved"));
                    }

                    users.add(user);
                    System.out.println("Fetched user: " + user.getUserId() + ", role: " + user.getRole() + ", Approved: " + user.getApproved());
                }
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error fetching manageable users", e);
            e.printStackTrace();
        }
        return users;
    }

    public User getUserById(int userId) {
        String sql = "SELECT user_id, name, email, phone, username, password, role, document_path, created_at, isApproved FROM dbo.users WHERE user_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setFullName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("phone"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setRole(rs.getString("role"));
                    user.setDocumentPath(rs.getString("document_path"));
                    user.setCreatedAt(rs.getTimestamp("created_at"));

                    Object approvedObj = rs.getObject("isApproved");
                    if (approvedObj == null) {
                        user.setApproved(null);
                    } else {
                        user.setApproved(rs.getBoolean("isApproved"));
                    }

                    return user;
                }
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error fetching user by ID", e);
            e.printStackTrace();
        }
        return null;
    }

    public void updateUserApproval(int userId, Boolean isApproved) {
        String sql = "UPDATE dbo.users SET isApproved = ? WHERE user_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            if (isApproved == null) {
                ps.setNull(1, Types.BOOLEAN);
            } else {
                ps.setBoolean(1, isApproved);
            }

            ps.setInt(2, userId);
            int rowsAffected = ps.executeUpdate();
            System.out.println("Rows updated: " + rowsAffected);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error updating user approval", e);
            e.printStackTrace();
        }
    }
}
 