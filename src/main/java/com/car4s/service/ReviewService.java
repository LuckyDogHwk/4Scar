package com.car4s.service;

import com.car4s.dao.ReviewDao;
import com.car4s.entity.Review;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.SQLException;
import java.util.List;

/**
 * 评价业务逻辑服务类
 * 提供评价提交、查询和平均评分计算等功能
 */
public class ReviewService {
    private static final Logger log = LoggerFactory.getLogger(ReviewService.class);
    private final ReviewDao reviewDao = new ReviewDao();

    public Review getReviewById(Long id) {
        try {
            return reviewDao.findById(id);
        } catch (SQLException e) {
            log.error("查询评价失败, reviewId={}", id, e);
        }
        return null;
    }

    public Review getReviewByOrderId(Long orderId) {
        try {
            return reviewDao.findByOrderId(orderId);
        } catch (SQLException e) {
            log.error("根据订单查询评价失败, orderId={}", orderId, e);
        }
        return null;
    }

    public List<Review> getAllReviews() {
        try {
            return reviewDao.findAll();
        } catch (SQLException e) {
            log.error("查询所有评价失败", e);
        }
        return List.of();
    }

    public List<Review> getReviewsByOwnerId(Long ownerId) {
        try {
            return reviewDao.findByOwnerId(ownerId);
        } catch (SQLException e) {
            log.error("查询用户评价列表失败, ownerId={}", ownerId, e);
        }
        return List.of();
    }

    public boolean addReview(Review review) {
        try {
            if (reviewDao.findByOrderId(review.getOrderId()) != null) {
                return false;
            }
            return reviewDao.save(review) > 0;
        } catch (SQLException e) {
            log.error("添加评价失败, orderId={}", review.getOrderId(), e);
        }
        return false;
    }

    public boolean deleteReview(Long id) {
        try {
            return reviewDao.delete(id) > 0;
        } catch (SQLException e) {
            log.error("删除评价失败, reviewId={}", id, e);
        }
        return false;
    }

    public double getAverageRating() {
        try {
            return reviewDao.getAverageRating();
        } catch (SQLException e) {
            log.error("获取平均评分失败", e);
        }
        return 0.0;
    }

    public boolean hasReview(Long orderId, Long ownerId) {
        try {
            return reviewDao.findByOrderId(orderId) != null;
        } catch (SQLException e) {
            log.error("检查评价是否存在失败, orderId={}", orderId, e);
        }
        return false;
    }
}
