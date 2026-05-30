package com.car4s.service;

import com.car4s.dao.PartDao;
import com.car4s.entity.Part;

import java.sql.SQLException;
import java.util.List;

/**
 * 配件业务逻辑服务类
 * 提供配件管理、搜索和库存更新等功能
 */
public class PartService {
    private final PartDao partDao = new PartDao();

    public Part getPartById(Long id) {
        try {
            return partDao.findById(id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Part getPartByPartNo(String partNo) {
        try {
            return partDao.findByPartNo(partNo);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Part> getAllParts() {
        try {
            return partDao.findAll();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return List.of();
    }

    public List<Part> searchParts(String keyword) {
        try {
            return partDao.search(keyword);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return List.of();
    }

    public boolean addPart(Part part) {
        try {
            if (partDao.findByPartNo(part.getPartNo()) != null) {
                return false;
            }
            return partDao.save(part) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updatePart(Part part) {
        try {
            return partDao.update(part) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateStock(Long id, int stock) {
        try {
            return partDao.updateStock(id, stock) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deletePart(Long id) {
        try {
            return partDao.delete(id) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getPartCount() {
        try {
            return partDao.count();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
