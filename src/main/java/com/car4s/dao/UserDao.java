package com.car4s.dao;

import com.car4s.entity.User;
import com.car4s.util.DBUtil;
import com.car4s.util.CustomBeanHandler;
import com.car4s.util.CustomBeanListHandler;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.sql.SQLException;
import java.util.List;

/**
 * 用户数据访问对象
 * 提供用户的增删改查操作
 */
public class UserDao {
    private final QueryRunner qr = new QueryRunner(DBUtil.getDataSource());

    public User findByUsername(String username) throws SQLException {
        String sql = "SELECT * FROM user WHERE username = ?";
        return qr.query(sql, new CustomBeanHandler<>(User.class), username);
    }

    public User findById(Long id) throws SQLException {
        String sql = "SELECT * FROM user WHERE id = ?";
        return qr.query(sql, new CustomBeanHandler<>(User.class), id);
    }

    public int save(User user) throws SQLException {
        String sql = "INSERT INTO user(username, password, real_name, phone, email, role, status) VALUES(?, ?, ?, ?, ?, ?, ?)";
        return qr.update(sql, user.getUsername(), user.getPassword(), user.getRealName(), 
                user.getPhone(), user.getEmail(), user.getRole(), user.getStatus());
    }

    public int update(User user) throws SQLException {
        String sql = "UPDATE user SET real_name=?, phone=?, email=?, status=? WHERE id=?";
        return qr.update(sql, user.getRealName(), user.getPhone(), user.getEmail(), user.getStatus(), user.getId());
    }

    public int updatePassword(Long id, String password) throws SQLException {
        String sql = "UPDATE user SET password=? WHERE id=?";
        return qr.update(sql, password, id);
    }

    public int updateUsername(Long id, String username) throws SQLException {
        String sql = "UPDATE user SET username=? WHERE id=?";
        return qr.update(sql, username, id);
    }

    public boolean existsByUsername(String username) throws SQLException {
        String sql = "SELECT COUNT(*) FROM user WHERE username = ?";
        return ((Number) qr.query(sql, new ScalarHandler<>(), username)).intValue() > 0;
    }

    public boolean existsByUsernameExcludeId(String username, Long excludeId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM user WHERE username = ? AND id != ?";
        return ((Number) qr.query(sql, new ScalarHandler<>(), username, excludeId)).intValue() > 0;
    }

    public List<User> findByRole(String role) throws SQLException {
        String sql = "SELECT * FROM user WHERE role = ?";
        return qr.query(sql, new CustomBeanListHandler<>(User.class), role);
    }

    public List<User> findAll() throws SQLException {
        String sql = "SELECT * FROM user ORDER BY create_time DESC";
        return qr.query(sql, new CustomBeanListHandler<>(User.class));
    }

    public List<User> findOwners() throws SQLException {
        return findByRole("owner");
    }

    public List<User> findMechanics() throws SQLException {
        return findByRole("mechanic");
    }

    public int count() throws SQLException {
        String sql = "SELECT COUNT(*) FROM user";
        return ((Number) qr.query(sql, new ScalarHandler<>())).intValue();
    }

    public int delete(Long id) throws SQLException {
        String sql = "DELETE FROM user WHERE id = ?";
        return qr.update(sql, id);
    }
}
