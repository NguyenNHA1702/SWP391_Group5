package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Campaign;
import utils.DBUtil;

public class CampaignDAO {

    public static List<Campaign> getActiveCampaigns() {
        List<Campaign> list = new ArrayList<>();
        String sql = "SELECT * FROM campaigns WHERE status = 'active' AND GETDATE() BETWEEN start_date AND end_date";

        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Campaign c = new Campaign();
                c.setCampaignId(rs.getInt("campaign_id"));
                c.setUserId(rs.getInt("user_id"));
                c.setTitle(rs.getString("title"));
                c.setDescription(rs.getString("description"));
                c.setGoalAmount(rs.getDouble("goal_amount"));
                c.setCurrentAmount(rs.getDouble("current_amount"));
                Timestamp startTimestamp = rs.getTimestamp("start_date");
                c.setStartDate(startTimestamp != null ? new Date(startTimestamp.getTime()) : null);
                Timestamp endTimestamp = rs.getTimestamp("end_date");
                c.setEndDate(endTimestamp != null ? new Date(endTimestamp.getTime()) : null);
                c.setLanguage(rs.getString("language"));
                c.setStatus(rs.getString("status"));
                c.setAdminStatus(rs.getString("admin_status")); // Thêm lấy admin_status
                Timestamp createdTimestamp = rs.getTimestamp("created_at");
                c.setCreatedAt(createdTimestamp != null ? new Date(createdTimestamp.getTime()) : null);
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Campaign> getCampaignsByUserId(int userId) {
        List<Campaign> campaigns = new ArrayList<>();
        String sql = "SELECT * FROM campaigns WHERE user_id = ?";

        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Campaign c = new Campaign();
                c.setCampaignId(rs.getInt("campaign_id"));
                c.setUserId(rs.getInt("user_id"));
                c.setTitle(rs.getString("title"));
                c.setDescription(rs.getString("description"));
                c.setGoalAmount(rs.getDouble("goal_amount"));
                c.setCurrentAmount(rs.getDouble("current_amount"));
                Timestamp startTimestamp = rs.getTimestamp("start_date");
                c.setStartDate(startTimestamp != null ? new Date(startTimestamp.getTime()) : null);
                Timestamp endTimestamp = rs.getTimestamp("end_date");
                c.setEndDate(endTimestamp != null ? new Date(endTimestamp.getTime()) : null);
                c.setLanguage(rs.getString("language"));
                c.setStatus(rs.getString("status"));
                c.setAdminStatus(rs.getString("admin_status")); // Thêm lấy admin_status
                Timestamp createdTimestamp = rs.getTimestamp("created_at");
                c.setCreatedAt(createdTimestamp != null ? new Date(createdTimestamp.getTime()) : null);
                campaigns.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error in getCampaignsByUserId for userId " + userId + ": " + e.getMessage());
        }
        return campaigns;
    }

    public boolean addCampaign(Campaign campaign) {
        String sql = "INSERT INTO campaigns (user_id, title, description, goal_amount, current_amount, start_date, end_date, language, status, created_at, admin_status) "
                + "VALUES (?, ?, ?, ?, 0, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, campaign.getUserId());
            ps.setString(2, campaign.getTitle());
            ps.setString(3, campaign.getDescription());
            ps.setDouble(4, campaign.getGoalAmount());
            ps.setTimestamp(5, campaign.getStartDate() != null ? new java.sql.Timestamp(campaign.getStartDate().getTime()) : null);
            ps.setTimestamp(6, campaign.getEndDate() != null ? new java.sql.Timestamp(campaign.getEndDate().getTime()) : null);
            ps.setString(7, campaign.getLanguage());
            ps.setString(8, "news");
            ps.setTimestamp(9, campaign.getCreatedAt() != null ? new java.sql.Timestamp(campaign.getCreatedAt().getTime()) : new java.sql.Timestamp(System.currentTimeMillis()));
            ps.setString(10, "pending"); // Thêm giá trị mặc định cho admin_status

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateCampaign(Campaign campaign) {
        String sql = "UPDATE campaigns SET title=?, description=?, goal_amount=?, start_date=?, end_date=?, language=? WHERE campaign_id=?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, campaign.getTitle());
            ps.setString(2, campaign.getDescription());
            ps.setDouble(3, campaign.getGoalAmount());
            ps.setTimestamp(4, campaign.getStartDate() != null ? new java.sql.Timestamp(campaign.getStartDate().getTime()) : null);
            ps.setTimestamp(5, campaign.getEndDate() != null ? new java.sql.Timestamp(campaign.getEndDate().getTime()) : null);
            ps.setString(6, campaign.getLanguage());
            ps.setInt(7, campaign.getCampaignId());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Thêm phương thức để lấy danh sách chiến dịch theo admin_status
    public List<Campaign> getCampaignsByAdminStatus(String adminStatus) {
        List<Campaign> campaigns = new ArrayList<>();
        String sql = "SELECT * FROM campaigns WHERE admin_status = ?";

        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, adminStatus.toLowerCase());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Campaign c = new Campaign();
                c.setCampaignId(rs.getInt("campaign_id"));
                c.setUserId(rs.getInt("user_id"));
                c.setTitle(rs.getString("title"));
                c.setDescription(rs.getString("description"));
                c.setGoalAmount(rs.getDouble("goal_amount"));
                c.setCurrentAmount(rs.getDouble("current_amount"));
                Timestamp startTimestamp = rs.getTimestamp("start_date");
                c.setStartDate(startTimestamp != null ? new Date(startTimestamp.getTime()) : null);
                Timestamp endTimestamp = rs.getTimestamp("end_date");
                c.setEndDate(endTimestamp != null ? new Date(endTimestamp.getTime()) : null);
                c.setLanguage(rs.getString("language"));
                c.setStatus(rs.getString("status"));
                c.setAdminStatus(rs.getString("admin_status"));
                Timestamp createdTimestamp = rs.getTimestamp("created_at");
                c.setCreatedAt(createdTimestamp != null ? new Date(createdTimestamp.getTime()) : null);
                campaigns.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return campaigns;
    }

    // Thêm phương thức để cập nhật admin_status
    public boolean updateAdminStatus(int campaignId, String adminStatus) {
        String sql = "UPDATE campaigns SET admin_status = ? WHERE campaign_id = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, adminStatus.toLowerCase());
            ps.setInt(2, campaignId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Campaign> getApprovedActiveCampaigns() {
        List<Campaign> list = new ArrayList<>();
        String sql = "SELECT * FROM campaigns WHERE status = 'active' AND admin_status = 'approved' AND GETDATE() BETWEEN start_date AND end_date";

        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Campaign c = new Campaign();
                c.setCampaignId(rs.getInt("campaign_id"));
                c.setUserId(rs.getInt("user_id"));
                c.setTitle(rs.getString("title"));
                c.setDescription(rs.getString("description"));
                c.setGoalAmount(rs.getDouble("goal_amount"));
                c.setCurrentAmount(rs.getDouble("current_amount"));

                Timestamp startTimestamp = rs.getTimestamp("start_date");
                c.setStartDate(startTimestamp != null ? new Date(startTimestamp.getTime()) : null);

                Timestamp endTimestamp = rs.getTimestamp("end_date");
                c.setEndDate(endTimestamp != null ? new Date(endTimestamp.getTime()) : null);

                c.setLanguage(rs.getString("language"));
                c.setStatus(rs.getString("status"));
                c.setAdminStatus(rs.getString("admin_status"));

                Timestamp createdTimestamp = rs.getTimestamp("created_at");
                c.setCreatedAt(createdTimestamp != null ? new Date(createdTimestamp.getTime()) : null);

                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public static List<Campaign> searchAndSortCampaigns(String title, String sort) {
        List<Campaign> campaigns = new ArrayList<>();
        String sql = "SELECT * FROM campaigns WHERE status = 'active'";

        if (title != null && !title.isEmpty()) {
            sql += " AND title LIKE ?";
        }

        if ("asc".equalsIgnoreCase(sort)) {
            sql += " ORDER BY goal_amount ASC";
        } else if ("desc".equalsIgnoreCase(sort)) {
            sql += " ORDER BY goal_amount DESC";
        }

        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            int paramIndex = 1;
            if (title != null && !title.isEmpty()) {
                stmt.setString(paramIndex++, "%" + title + "%");
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Campaign c = new Campaign();
                c.setCampaignId(rs.getInt("campaign_id"));
                c.setUserId(rs.getInt("user_id"));
                c.setTitle(rs.getString("title"));
                c.setDescription(rs.getString("description"));
                c.setGoalAmount(rs.getDouble("goal_amount"));
                c.setCurrentAmount(rs.getDouble("current_amount"));
                c.setStartDate(rs.getTimestamp("start_date"));
                c.setEndDate(rs.getTimestamp("end_date"));
                campaigns.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return campaigns;
    }

    public List<Campaign> getCampaignsByTitle(int userId, String title) {
        List<Campaign> list = new ArrayList<>();
        String sql = "SELECT * FROM Campaigns WHERE user_id = ? AND title LIKE ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, "%" + title + "%");

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Campaign c = new Campaign();
                c.setCampaignId(rs.getInt("campaign_id"));
                c.setTitle(rs.getString("title"));
                c.setDescription(rs.getString("description"));
                c.setGoalAmount(rs.getDouble("goal_amount"));
                c.setCurrentAmount(rs.getDouble("current_amount"));
                c.setStartDate(rs.getDate("start_date"));
                c.setEndDate(rs.getDate("end_date"));
                c.setStatus(rs.getString("status"));
                c.setLanguage(rs.getString("language"));
                c.setAdminStatus(rs.getString("admin_status"));
                c.setUserId(rs.getInt("user_id"));
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean updateCampaignStatus(int campaignId, String status) {
        String sql = "UPDATE Campaign SET status = ? WHERE campaignId = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, campaignId);

            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}
