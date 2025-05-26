package test;

import java.sql.Connection;
import java.sql.SQLException;
import utils.DBUtil;

public class TestDBConnection {
    public static void main(String[] args) {
        try {
            Connection conn = DBUtil.getConnection();
            if (conn != null && !conn.isClosed()) {
                System.out.println("✅ Connected to SQL Server successfully.");
                conn.close();
            } else {
                System.out.println("❌ Connection failed.");
            }
        } catch (Exception e) {
            System.out.println("❌ Exception occurred: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
}
