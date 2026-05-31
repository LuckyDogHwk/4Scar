package com.car4s.service;

import com.car4s.dao.PartDao;
import com.car4s.entity.Part;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.SQLException;
import java.util.List;

/**
 * 配件业务逻辑服务类
 * 提供配件管理、搜索和库存更新等功能
 */
public class PartService {
    private static final Logger log = LoggerFactory.getLogger(PartService.class);
    private final PartDao partDao = new PartDao();

    public Part getPartById(Long id) {
        try {
            return partDao.findById(id);
        } catch (SQLException e) {
            log.error("查询配件失败, partId={}", id, e);
        }
        return null;
    }

    public Part getPartByPartNo(String partNo) {
        try {
            return partDao.findByPartNo(partNo);
        } catch (SQLException e) {
            log.error("根据配件编号查询失败, partNo={}", partNo, e);
        }
        return null;
    }

    public List<Part> getAllParts() {
        try {
            return partDao.findAll();
        } catch (SQLException e) {
            log.error("查询所有配件失败", e);
        }
        return List.of();
    }

    public List<Part> searchParts(String keyword) {
        try {
            return partDao.search(keyword);
        } catch (SQLException e) {
            log.error("搜索配件失败, keyword={}", keyword, e);
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
            log.error("添加配件失败, partNo={}", part.getPartNo(), e);
        }
        return false;
    }

    public boolean updatePart(Part part) {
        try {
            return partDao.update(part) > 0;
        } catch (SQLException e) {
            log.error("更新配件失败, partId={}", part.getId(), e);
        }
        return false;
    }

    public boolean updateStock(Long id, int stock) {
        try {
            return partDao.updateStock(id, stock) > 0;
        } catch (SQLException e) {
            log.error("更新配件库存失败, partId={}, stock={}", id, stock, e);
        }
        return false;
    }

    public boolean deletePart(Long id) {
        try {
            return partDao.delete(id) > 0;
        } catch (SQLException e) {
            log.error("删除配件失败, partId={}", id, e);
        }
        return false;
    }

    public int getPartCount() {
        try {
            return partDao.count();
        } catch (SQLException e) {
            log.error("统计配件数量失败", e);
        }
        return 0;
    }
}
