package com.car4s.dao;

import com.car4s.entity.Complaint;
import com.car4s.util.DBUtil;
import com.car4s.util.CustomBeanHandler;
import com.car4s.util.CustomBeanListHandler;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;

/**
 * 投诉数据访问对象
 * 提供投诉的增删改查和处理操作
 */
public class ComplaintDao {
    private final QueryRunner qr = new QueryRunner(DBUtil.getDataSource());

    public Complaint findById(Long id) throws SQLException {
        String sql = "SELECT c.*, u.real_name as owner_name, s.order_no " +
                "FROM complaint c " +
                "LEFT JOIN user u ON c.owner_id = u.id " +
                "LEFT JOIN service_order s ON c.order_id = s.id " +
                "WHERE c.id = ?";
        return qr.query(sql, new CustomBeanHandler<>(Complaint.class), id);
    }

    public List<Complaint> findByOwnerId(Long ownerId) throws SQLException {
        String sql = "SELECT c.*, u.real_name as owner_name, s.order_no " +
                "FROM complaint c " +
                "LEFT JOIN user u ON c.owner_id = u.id " +
                "LEFT JOIN service_order s ON c.order_id = s.id " +
                "WHERE c.owner_id = ? ORDER BY c.create_time DESC";
        return qr.query(sql, new CustomBeanListHandler<>(Complaint.class), ownerId);
    }

    public List<Complaint> findByStatus(String status) throws SQLException {
        String sql = "SELECT c.*, u.real_name as owner_name, s.order_no " +
                "FROM complaint c " +
                "LEFT JOIN user u ON c.owner_id = u.id " +
                "LEFT JOIN service_order s ON c.order_id = s.id " +
                "WHERE c.status = ? ORDER BY c.create_time DESC";
        return qr.query(sql, new CustomBeanListHandler<>(Complaint.class), status);
    }

    public List<Complaint> findAll() throws SQLException {
        String sql = "SELECT c.*, u.real_name as owner_name, s.order_no " +
                "FROM complaint c " +
                "LEFT JOIN user u ON c.owner_id = u.id " +
                "LEFT JOIN service_order s ON c.order_id = s.id " +
                "ORDER BY c.create_time DESC";
        return qr.query(sql, new CustomBeanListHandler<>(Complaint.class));
    }

    public int save(Complaint complaint) throws SQLException {
        String sql = "INSERT INTO complaint(owner_id, order_id, title, content, status) VALUES(?, ?, ?, ?, 'pending')";
        return qr.update(sql, complaint.getOwnerId(), complaint.getOrderId(), complaint.getTitle(), complaint.getContent());
    }

    public int handle(Long id, String handleResult) throws SQLException {
        String sql = "UPDATE complaint SET status = 'processed', handle_result = ?, handle_time = NOW() WHERE id = ?";
        return qr.update(sql, handleResult, id);
    }

    public int delete(Long id) throws SQLException {
        String sql = "DELETE FROM complaint WHERE id = ?";
        return qr.update(sql, id);
    }

    public int countPending() throws SQLException {
        String sql = "SELECT COUNT(*) FROM complaint WHERE status = 'pending'";
        return ((Number) qr.query(sql, new ScalarHandler<>())).intValue();
    }
}
