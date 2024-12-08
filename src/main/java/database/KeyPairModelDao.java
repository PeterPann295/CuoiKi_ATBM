package database;

import model.KeyPairModel;
import utils.JDBCUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

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
    public ArrayList<KeyPairModel> selectAllByCustomerId(int customerId) {
        ArrayList<KeyPairModel> keyPairModels = new ArrayList<>();
        try {
            Connection con = JDBCUtil.getConnection();

            String sql = "Select * from key_pairs where customer_id = ?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setInt(1, customerId);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                KeyPairModel keyPairModel = new KeyPairModel();
                keyPairModel.setId(rs.getInt("id"));
                keyPairModel.setCustomerId(rs.getInt("customer_id"));
                keyPairModel.setPublicKey(rs.getString("public_key"));
                keyPairModel.setStatus(rs.getString("status"));
                keyPairModel.setCreatedAt(rs.getTimestamp("created_at"));
                keyPairModel.setRevokedAt(rs.getTimestamp("revoked_at"));
                keyPairModels.add(keyPairModel);
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return keyPairModels;
    }

    public static void main(String[] args) {

    }
}
