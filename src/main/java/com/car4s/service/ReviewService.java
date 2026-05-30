package com.car4s.service;

import com.car4s.dao.ReviewDao;
import com.car4s.entity.Review;

import java.sql.SQLException;
import java.util.List;

/**
 * 评价业务逻辑服务类
 * 提供评价提交、查询和平均评分计算等功能
 */
public class ReviewService {
    private final ReviewDao reviewDao = new ReviewDao();

    public Review getReviewById(Long id) {
        try {
            return reviewDao.findById(id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Review getReviewByOrderId(Long orderId) {
        try {
            return reviewDao.findByOrderId(orderId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Review> getAllReviews() {
        try {
            return reviewDao.findAll();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return List.of();
    }

    public List<Review> getReviewsByOwnerId(Long ownerId) {
        try {
            return reviewDao.findByOwnerId(ownerId);
        } catch (SQLException e) {
            e.printStackTrace();
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
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteReview(Long id) {
        try {
            return reviewDao.delete(id) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public double getAverageRating() {
        try {
            return reviewDao.getAverageRating();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    public boolean hasReview(Long orderId, Long ownerId) {
        try {
            return reviewDao.findByOrderId(orderId) != null;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
