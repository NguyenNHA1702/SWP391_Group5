/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
import model.JoinRequest;
import utils.DBUtil;
import java.sql.ResultSet;


/**
 *
 * @author HP
 */
public class JoinRequestDAO {
    public static boolean insertRequest(int campaignId, String fullName, String email, String phone, String reason) {
        String sql = "INSERT INTO join_requests (campaign_id, full_name, email, phone, reason, status, created_at) " +
                     "VALUES (?, ?, ?, ?, ?, 'pending', GETDATE())";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, campaignId);
            ps.setString(2, fullName);
            ps.setString(3, email);
            ps.setString(4, phone);
            ps.setString(5, reason);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public static List<JoinRequest> getPendingRequestsByUser(String username) {
    List<JoinRequest> list = new ArrayList<>();
    String sql = """
        SELECT r.id, c.title AS campaignTitle, r.full_name, r.email, r.phone, r.reason
        FROM join_requests r
        JOIN campaigns c ON r.campaign_id = c.campaign_id
        JOIN users u ON c.user_id = u.user_id
        WHERE u.username = ? AND r.status = 'pending'
        """;
    try (Connection conn = DBUtil.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            JoinRequest jr = new JoinRequest();
            jr.setId(rs.getInt("id"));
            jr.setCampaignTitle(rs.getString("campaignTitle"));
            jr.setFullName(rs.getString("full_name"));
            jr.setEmail(rs.getString("email"));
            jr.setPhone(rs.getString("phone"));
            jr.setReason(rs.getString("reason"));
            list.add(jr);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}

public static boolean updateRequestStatus(int requestId, String status) {
    String sql = "UPDATE join_requests SET status = ? WHERE request_id = ?";
    try (Connection conn = DBUtil.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, status);
        ps.setInt(2, requestId);
        return ps.executeUpdate() > 0;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}

public static int countPendingRequestsForFarmer(String username) {
    int count = 0;
    String sql = """
        SELECT COUNT(*) 
        FROM join_requests r
        JOIN campaigns c ON r.campaign_id = c.campaign_id
        JOIN users u ON c.user_id = u.user_id
        WHERE u.username = ? AND r.status = 'pending'
    """;
    try (Connection conn = DBUtil.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            count = rs.getInt(1);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return count;
}

public static List<JoinRequest> getPendingRequestsByUserId(int userId) {
    List<JoinRequest> list = new ArrayList<>();
    String sql = """
        SELECT r.request_id, c.title AS campaignTitle, r.full_name, r.email, r.phone, r.reason
        FROM join_requests r
        JOIN campaigns c ON r.campaign_id = c.campaign_id
        WHERE c.user_id = ? AND r.status = 'pending'
    """;

    try (Connection conn = DBUtil.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            JoinRequest jr = new JoinRequest();
            jr.setId(rs.getInt("request_id"));
            jr.setCampaignTitle(rs.getString("campaignTitle"));
            jr.setFullName(rs.getString("full_name"));
            jr.setEmail(rs.getString("email"));
            jr.setPhone(rs.getString("phone"));
            jr.setReason(rs.getString("reason"));
            list.add(jr);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}



}



