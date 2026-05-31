package com.car4s.service;

import com.car4s.dao.ComplaintDao;
import com.car4s.entity.Complaint;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.SQLException;
import java.util.List;

/**
 * 投诉业务逻辑服务类
 * 提供投诉提交、查询和处理等功能
 */
public class ComplaintService {
    private static final Logger log = LoggerFactory.getLogger(ComplaintService.class);
    private final ComplaintDao complaintDao = new ComplaintDao();

    public Complaint getComplaintById(Long id) {
        try {
            return complaintDao.findById(id);
        } catch (SQLException e) {
            log.error("查询投诉失败, complaintId={}", id, e);
        }
        return null;
    }

    public List<Complaint> getComplaintsByOwnerId(Long ownerId) {
        try {
            return complaintDao.findByOwnerId(ownerId);
        } catch (SQLException e) {
            log.error("查询用户投诉列表失败, ownerId={}", ownerId, e);
        }
        return List.of();
    }

    public List<Complaint> getPendingComplaints() {
        try {
            return complaintDao.findByStatus("pending");
        } catch (SQLException e) {
            log.error("查询待处理投诉失败", e);
        }
        return List.of();
    }

    public List<Complaint> getAllComplaints() {
        try {
            return complaintDao.findAll();
        } catch (SQLException e) {
            log.error("查询所有投诉失败", e);
        }
        return List.of();
    }

    public boolean addComplaint(Complaint complaint) {
        try {
            return complaintDao.save(complaint) > 0;
        } catch (SQLException e) {
            log.error("提交投诉失败", e);
        }
        return false;
    }

    public boolean handleComplaint(Long id, String handleResult) {
        try {
            int result = complaintDao.handle(id, handleResult);
            log.info("处理投诉完成, complaintId={}, 影响行数={}", id, result);
            return result > 0;
        } catch (SQLException e) {
            log.error("处理投诉失败, complaintId={}", id, e);
        }
        return false;
    }

    public boolean deleteComplaint(Long id) {
        try {
            return complaintDao.delete(id) > 0;
        } catch (SQLException e) {
            log.error("删除投诉失败, complaintId={}", id, e);
        }
        return false;
    }

    public int getPendingCount() {
        try {
            return complaintDao.countPending();
        } catch (SQLException e) {
            log.error("统计待处理投诉数量失败", e);
        }
        return 0;
    }
}
