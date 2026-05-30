package com.car4s.dao;

import com.car4s.entity.Message;
import com.car4s.util.DBUtil;
import com.car4s.util.CustomBeanHandler;
import com.car4s.util.CustomBeanListHandler;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;

/**
 * 留言数据访问对象
 * 提供留言的增删改查和回复操作
 */
public class MessageDao {
    private final QueryRunner qr = new QueryRunner(DBUtil.getDataSource());

    public Message findById(Long id) throws SQLException {
        String sql = "SELECT m.*, u.real_name as owner_name, " +
                "mech.real_name as mechanic_name " +
                "FROM message m " +
                "LEFT JOIN user u ON m.owner_id = u.id " +
                "LEFT JOIN user mech ON m.mechanic_id = mech.id " +
                "WHERE m.id = ?";
        return qr.query(sql, new CustomBeanHandler<>(Message.class), id);
    }

    public List<Message> findByOwnerId(Long ownerId) throws SQLException {
        String sql = "SELECT m.*, u.real_name as owner_name, " +
                "mech.real_name as mechanic_name " +
                "FROM message m " +
                "LEFT JOIN user u ON m.owner_id = u.id " +
                "LEFT JOIN user mech ON m.mechanic_id = mech.id " +
                "WHERE m.owner_id = ? ORDER BY m.create_time DESC";
        return qr.query(sql, new CustomBeanListHandler<>(Message.class), ownerId);
    }

    public List<Message> findPending() throws SQLException {
        String sql = "SELECT m.*, u.real_name as owner_name, " +
                "mech.real_name as mechanic_name " +
                "FROM message m " +
                "LEFT JOIN user u ON m.owner_id = u.id " +
                "LEFT JOIN user mech ON m.mechanic_id = mech.id " +
                "WHERE m.status = 'pending' ORDER BY m.create_time DESC";
        return qr.query(sql, new CustomBeanListHandler<>(Message.class));
    }

    public List<Message> findAll() throws SQLException {
        String sql = "SELECT m.*, u.real_name as owner_name, " +
                "mech.real_name as mechanic_name " +
                "FROM message m " +
                "LEFT JOIN user u ON m.owner_id = u.id " +
                "LEFT JOIN user mech ON m.mechanic_id = mech.id " +
                "ORDER BY m.create_time DESC";
        return qr.query(sql, new CustomBeanListHandler<>(Message.class));
    }

    public int save(Message message) throws SQLException {
        String sql = "INSERT INTO message(owner_id, title, content, status) VALUES(?, ?, ?, 'pending')";
        return qr.update(sql, message.getOwnerId(), message.getTitle(), message.getContent());
    }

    public int reply(Long id, Long mechanicId, String replyContent) throws SQLException {
        String sql = "UPDATE message SET mechanic_id = ?, reply_content = ?, status = 'replied', reply_time = ? WHERE id = ?";
        return qr.update(sql, mechanicId, replyContent, LocalDateTime.now(), id);
    }

    public int delete(Long id) throws SQLException {
        String sql = "DELETE FROM message WHERE id = ?";
        return qr.update(sql, id);
    }

    public int countPending() throws SQLException {
        String sql = "SELECT COUNT(*) FROM message WHERE status = 'pending'";
        return ((Number) qr.query(sql, new ScalarHandler<>())).intValue();
    }
}
