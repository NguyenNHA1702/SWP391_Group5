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
                c.setStartDate(rs.getTimestamp("start_date"));
                c.setEndDate(rs.getTimestamp("end_date"));
                c.setLanguage(rs.getString("language"));
                c.setStatus(rs.getString("status"));
                c.setCreatedAt(rs.getTimestamp("created_at"));
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
                c.setStartDate(rs.getTimestamp("start_date"));
                c.setEndDate(rs.getTimestamp("end_date"));
                c.setLanguage(rs.getString("language"));
                c.setStatus(rs.getString("status"));
                c.setCreatedAt(rs.getTimestamp("created_at"));
                campaigns.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return campaigns;
    }

    public boolean addCampaign(Campaign campaign) {
        String sql = "INSERT INTO campaigns (user_id, title, description, goal_amount, current_amount, start_date, end_date, language, status, created_at) "
                + "VALUES (?, ?, ?, ?, 0, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, campaign.getUserId());
            ps.setString(2, campaign.getTitle());
            ps.setString(3, campaign.getDescription());
            ps.setDouble(4, campaign.getGoalAmount());
            ps.setDate(5, new java.sql.Date(campaign.getStartDate().getTime()));
            ps.setDate(6, new java.sql.Date(campaign.getEndDate().getTime()));
            ps.setString(7, campaign.getLanguage());
            ps.setString(8, campaign.getStatus());
            ps.setTimestamp(9, new java.sql.Timestamp(System.currentTimeMillis()));

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateCampaign(Campaign campaign) {
        String sql = "UPDATE campaigns SET title=?, description=?, goal_amount=?, start_date=?, end_date=?, language=?, status=? WHERE campaign_id=?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, campaign.getTitle());
            ps.setString(2, campaign.getDescription());
            ps.setDouble(3, campaign.getGoalAmount());
            ps.setDate(4, new java.sql.Date(campaign.getStartDate().getTime()));
            ps.setDate(5, new java.sql.Date(campaign.getEndDate().getTime()));
            ps.setString(6, campaign.getLanguage());
            ps.setString(7, campaign.getStatus().toLowerCase());
            ps.setInt(8, campaign.getCampaignId());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
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
                c.setUserId(rs.getInt("user_id"));
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

}
