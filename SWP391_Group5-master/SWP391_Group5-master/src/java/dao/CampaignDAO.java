package dao;

import model.Campaign;
import utils.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class CampaignDAO {

    public static Campaign getCampaignById(int id) {
        Campaign campaign = null;
        String sql = "SELECT * FROM campaigns WHERE campaign_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                campaign = new Campaign(
                    rs.getInt("campaign_id"),
                    rs.getString("title"),
                    rs.getString("description"),
                    rs.getDouble("goal_amount"),
                    rs.getDouble("current_amount"),
                    rs.getDate("start_date").toLocalDate(),
                    rs.getDate("end_date").toLocalDate()
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return campaign;
    }

   
}
