package database;

import model.KeyPairModel;
import utils.JDBCUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Timestamp;

public class KeyPairModelDao {
    public int insert(KeyPairModel keyPair) {
        try {
            Connection con = JDBCUtil.getConnection();

            String sql = "INSERT INTO key_pairs (customer_id, public_key, status, created_at, revoked_at) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pst = con.prepareStatement(sql);

            pst.setInt(1, keyPair.getCustomerId());
            pst.setString(2, keyPair.getPublicKey());
            pst.setString(3, keyPair.getStatus() != null ? keyPair.getStatus() : "active"); // Giá trị mặc định
            pst.setTimestamp(4, keyPair.getCreatedAt() != null ? keyPair.getCreatedAt() : new Timestamp(System.currentTimeMillis()));
            pst.setTimestamp(5, keyPair.getRevokedAt()); // Có thể null nếu không bị thu hồi

            int rowsAffected = pst.executeUpdate();
            JDBCUtil.closeConnection(con);

            return rowsAffected;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
