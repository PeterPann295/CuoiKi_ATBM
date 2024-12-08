package database;

import model.KeyPairModel;
import utils.JDBCUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.Comparator;

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
    public int insertWithStatusUpdate(KeyPairModel keyPair) {
        Connection con = null;
        PreparedStatement pstUpdateStatus = null;
        PreparedStatement pstInsertKeyPair = null;

        try {
            con = JDBCUtil.getConnection();
            con.setAutoCommit(false); // Bắt đầu transaction

            // 1. Cập nhật trạng thái tất cả các key_pairs khác của user thành "revoked" và thêm thời gian revoked_at
            String updateStatusSql = "UPDATE key_pairs SET status = 'revoked', revoked_at = ? WHERE customer_id = ? AND status = 'active'";
            pstUpdateStatus = con.prepareStatement(updateStatusSql);
            pstUpdateStatus.setTimestamp(1, new Timestamp(System.currentTimeMillis())); // Thời gian revoked là thời gian hiện tại
            pstUpdateStatus.setInt(2, keyPair.getCustomerId());
            pstUpdateStatus.executeUpdate();

            // 2. Thêm bản ghi key_pair mới với trạng thái "active"
            String insertSql = "INSERT INTO key_pairs (customer_id, public_key, status, created_at, revoked_at) VALUES (?, ?, ?, ?, ?)";
            pstInsertKeyPair = con.prepareStatement(insertSql);

            pstInsertKeyPair.setInt(1, keyPair.getCustomerId());
            pstInsertKeyPair.setString(2, keyPair.getPublicKey());
            pstInsertKeyPair.setString(3, keyPair.getStatus() != null ? keyPair.getStatus() : "active");
            pstInsertKeyPair.setTimestamp(4, keyPair.getCreatedAt() != null ? keyPair.getCreatedAt() : new Timestamp(System.currentTimeMillis()));
            pstInsertKeyPair.setTimestamp(5, keyPair.getRevokedAt()); // Có thể null nếu không bị thu hồi

            int rowsAffected = pstInsertKeyPair.executeUpdate();

            con.commit(); // Commit transaction
            return rowsAffected;

        } catch (Exception e) {
            e.printStackTrace();
            if (con != null) {
                try {
                    con.rollback(); // Rollback nếu có lỗi
                } catch (SQLException rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
        } finally {
            try {
                if (pstUpdateStatus != null) pstUpdateStatus.close();
                if (pstInsertKeyPair != null) pstInsertKeyPair.close();
                if (con != null) JDBCUtil.closeConnection(con);
            } catch (SQLException closeEx) {
                closeEx.printStackTrace();
            }
        }
        return 0;
    }

    public ArrayList<KeyPairModel> selectAllByCustomerId(int customerId) {
        ArrayList<KeyPairModel> keyPairModels = new ArrayList<>();
        try {
            Connection con = JDBCUtil.getConnection();

            String sql = "Select * from key_pairs where customer_id = ? order by id desc ";
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
//        keyPairModels.sort(new Comparator<KeyPairModel>() {
//            @Override
//            public int compare(KeyPairModel o1, KeyPairModel o2) {
//                return Integer.compare(o1.getId(), o2.getId()); // So sánh theo id
//            }
//        });
        return keyPairModels;

    }
    public void revokeAllKeyByCustomerId(int id) throws SQLException {
        Connection con = JDBCUtil.getConnection();

        String sql = "UPDATE key_pairs SET status = 'revoked', revoked_at = ? WHERE customer_id = ? AND status = 'active'";

        PreparedStatement pst = con.prepareStatement(sql);
        pst.setTimestamp(1, new Timestamp(System.currentTimeMillis())); // Thời gian revoked là thời gian hiện tại
        pst.setInt(2, id);
        pst.executeUpdate();
    }

    public static void main(String[] args) {

    }
}
