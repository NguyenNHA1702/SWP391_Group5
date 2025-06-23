package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DBUtil {

    public static Connection getConnection() throws Exception {
        String url = "jdbc:sqlserver://localhost:1433;databaseName=AgriRescue_DB2";
        String user = "sa";
        String password = "123"; // mật khẩu của bạn
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(url, user, password);
    }

    public static void closeQuietly(AutoCloseable ac) {
        if (ac != null) {
            try {
                ac.close();
            } catch (Exception ignored) {
            }
        }
    }

    
    public static void close(Connection conn, PreparedStatement ps, ResultSet rs) {
        closeQuietly(rs);
        closeQuietly(ps);
        closeQuietly(conn);
    }

    // (Tùy chọn) Thêm overload cho tiện gọi
    public static void close(Connection conn, PreparedStatement ps) {
        closeQuietly(ps);
        closeQuietly(conn);
    }

    public static void close(Connection conn) {
        closeQuietly(conn);
    }
}
