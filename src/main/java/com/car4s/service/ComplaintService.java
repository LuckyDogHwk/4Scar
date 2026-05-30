package com.car4s.service;

import com.car4s.dao.ComplaintDao;
import com.car4s.entity.Complaint;

import java.sql.SQLException;
import java.util.List;

/**
 * 投诉业务逻辑服务类
 * 提供投诉提交、查询和处理等功能
 */
public class ComplaintService {
    private final ComplaintDao complaintDao = new ComplaintDao();

    public Complaint getComplaintById(Long id) {
        try {
            return complaintDao.findById(id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Complaint> getComplaintsByOwnerId(Long ownerId) {
        try {
            return complaintDao.findByOwnerId(ownerId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return List.of();
    }

    public List<Complaint> getPendingComplaints() {
        try {
            return complaintDao.findByStatus("pending");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return List.of();
    }

    public List<Complaint> getAllComplaints() {
        try {
            return complaintDao.findAll();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return List.of();
    }

    public boolean addComplaint(Complaint complaint) {
        try {
            return complaintDao.save(complaint) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean handleComplaint(Long id, String handleResult) {
        try {
            int result = complaintDao.handle(id, handleResult);
            System.out.println("DAO更新结果: " + result + " 行受影响");
            return result > 0;
        } catch (SQLException e) {
            System.out.println("处理投诉SQL错误: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteComplaint(Long id) {
        try {
            return complaintDao.delete(id) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getPendingCount() {
        try {
            return complaintDao.countPending();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
