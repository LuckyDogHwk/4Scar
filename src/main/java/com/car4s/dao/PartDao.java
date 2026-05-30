package com.car4s.dao;

import com.car4s.entity.Part;
import com.car4s.util.DBUtil;
import com.car4s.util.CustomBeanHandler;
import com.car4s.util.CustomBeanListHandler;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.sql.SQLException;
import java.util.List;

/**
 * 配件数据访问对象
 * 提供配件的增删改查和库存更新操作
 */
public class PartDao {
    private final QueryRunner qr = new QueryRunner(DBUtil.getDataSource());

    public Part findById(Long id) throws SQLException {
        String sql = "SELECT * FROM part WHERE id = ?";
        return qr.query(sql, new CustomBeanHandler<>(Part.class), id);
    }

    public Part findByPartNo(String partNo) throws SQLException {
        String sql = "SELECT * FROM part WHERE part_no = ?";
        return qr.query(sql, new CustomBeanHandler<>(Part.class), partNo);
    }

    public List<Part> findAll() throws SQLException {
        String sql = "SELECT * FROM part ORDER BY create_time DESC";
        return qr.query(sql, new CustomBeanListHandler<>(Part.class));
    }

    public List<Part> search(String keyword) throws SQLException {
        String sql = "SELECT * FROM part WHERE part_name LIKE ? OR part_no LIKE ? OR brand LIKE ?";
        String pattern = "%" + keyword + "%";
        return qr.query(sql, new CustomBeanListHandler<>(Part.class), pattern, pattern, pattern);
    }

    public int save(Part part) throws SQLException {
        String sql = "INSERT INTO part(part_no, part_name, brand, model, price, stock, description, image_url) VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
        return qr.update(sql, part.getPartNo(), part.getPartName(), part.getBrand(), part.getModel(),
                part.getPrice(), part.getStock(), part.getDescription(), part.getImageUrl());
    }

    public int update(Part part) throws SQLException {
        String sql = "UPDATE part SET part_name=?, brand=?, model=?, price=?, stock=?, description=?, image_url=? WHERE id=?";
        return qr.update(sql, part.getPartName(), part.getBrand(), part.getModel(),
                part.getPrice(), part.getStock(), part.getDescription(), part.getImageUrl(), part.getId());
    }

    public int updateStock(Long id, int stock) throws SQLException {
        String sql = "UPDATE part SET stock = ? WHERE id = ?";
        return qr.update(sql, stock, id);
    }

    public int delete(Long id) throws SQLException {
        String sql = "DELETE FROM part WHERE id = ?";
        return qr.update(sql, id);
    }

    public int count() throws SQLException {
        String sql = "SELECT COUNT(*) FROM part";
        return ((Number) qr.query(sql, new ScalarHandler<>())).intValue();
    }
}
