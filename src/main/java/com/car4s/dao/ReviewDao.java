package com.car4s.dao;

import com.car4s.entity.Review;
import com.car4s.util.DBUtil;
import com.car4s.util.CustomBeanHandler;
import com.car4s.util.CustomBeanListHandler;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.sql.SQLException;
import java.util.List;

/**
 * 评价数据访问对象
 * 提供评价的增删改查和平均评分计算
 */
public class ReviewDao {
    private final QueryRunner qr = new QueryRunner(DBUtil.getDataSource());

    public Review findById(Long id) throws SQLException {
        String sql = "SELECT r.*, u.real_name as owner_name, s.order_no " +
                "FROM review r " +
                "LEFT JOIN user u ON r.owner_id = u.id " +
                "LEFT JOIN service_order s ON r.order_id = s.id " +
                "WHERE r.id = ?";
        return qr.query(sql, new CustomBeanHandler<>(Review.class), id);
    }

    public Review findByOrderId(Long orderId) throws SQLException {
        String sql = "SELECT * FROM review WHERE order_id = ?";
        return qr.query(sql, new CustomBeanHandler<>(Review.class), orderId);
    }

    public List<Review> findAll() throws SQLException {
        String sql = "SELECT r.*, u.real_name as owner_name, s.order_no " +
                "FROM review r " +
                "LEFT JOIN user u ON r.owner_id = u.id " +
                "LEFT JOIN service_order s ON r.order_id = s.id " +
                "ORDER BY r.create_time DESC";
        return qr.query(sql, new CustomBeanListHandler<>(Review.class));
    }

    public List<Review> findByOwnerId(Long ownerId) throws SQLException {
        String sql = "SELECT r.*, u.real_name as owner_name, s.order_no " +
                "FROM review r " +
                "LEFT JOIN user u ON r.owner_id = u.id " +
                "LEFT JOIN service_order s ON r.order_id = s.id " +
                "WHERE r.owner_id = ? " +
                "ORDER BY r.create_time DESC";
        return qr.query(sql, new CustomBeanListHandler<>(Review.class), ownerId);
    }

    public int save(Review review) throws SQLException {
        String sql = "INSERT INTO review(order_id, owner_id, rating, content) VALUES(?, ?, ?, ?)";
        return qr.update(sql, review.getOrderId(), review.getOwnerId(), review.getRating(), review.getContent());
    }

    public int delete(Long id) throws SQLException {
        String sql = "DELETE FROM review WHERE id = ?";
        return qr.update(sql, id);
    }

    public double getAverageRating() throws SQLException {
        String sql = "SELECT AVG(rating) FROM review";
        Double avg = qr.query(sql, new ScalarHandler<>());
        return avg != null ? avg : 0.0;
    }
}
