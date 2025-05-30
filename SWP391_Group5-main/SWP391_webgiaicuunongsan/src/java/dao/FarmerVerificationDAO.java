package dao;

import model.FarmerVerification;
import utils.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.logging.Level;
import java.util.logging.Logger;

public class FarmerVerificationDAO {
    // Singleton instance
    private static final FarmerVerificationDAO INSTANCE;

    static {
        try {
            INSTANCE = new FarmerVerificationDAO();
        } catch (Exception e) {
            Logger.getLogger(FarmerVerificationDAO.class.getName()).log(Level.SEVERE, "Failed to initialize FarmerVerificationDAO", e);
            throw new ExceptionInInitializerError("Failed to initialize FarmerVerificationDAO: " + e.getMessage());
        }
    }

    // Constructor private để ngăn chặn khởi tạo trực tiếp
    private FarmerVerificationDAO() {
        // Private constructor to prevent instantiation
    }

    // Phương thức để truy cập instance (nếu cần)
    public static FarmerVerificationDAO getInstance() {
        return INSTANCE;
    }

    public boolean saveVerification(FarmerVerification verification) {
        String sql = "INSERT INTO farmer_verifications (user_id, document_path, status, created_at) VALUES (?, ?, ?, GETDATE())";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, verification.getUserId());
            ps.setString(2, verification.getDocumentPath());
            ps.setString(3, verification.getStatus());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            Logger.getLogger(FarmerVerificationDAO.class.getName()).log(Level.SEVERE, "Error saving verification", e);
        }
        return false;
    }
}