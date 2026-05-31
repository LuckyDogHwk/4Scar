package com.car4s.service;

import com.car4s.dao.MessageDao;
import com.car4s.entity.Message;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.SQLException;
import java.util.List;

/**
 * 留言业务逻辑服务类
 * 提供留言发送、查询和回复等功能
 */
public class MessageService {
    private static final Logger log = LoggerFactory.getLogger(MessageService.class);
    private final MessageDao messageDao = new MessageDao();

    public Message getMessageById(Long id) {
        try {
            return messageDao.findById(id);
        } catch (SQLException e) {
            log.error("查询留言失败, messageId={}", id, e);
        }
        return null;
    }

    public List<Message> getMessagesByOwnerId(Long ownerId) {
        try {
            return messageDao.findByOwnerId(ownerId);
        } catch (SQLException e) {
            log.error("查询用户留言列表失败, ownerId={}", ownerId, e);
        }
        return List.of();
    }

    public List<Message> getPendingMessages() {
        try {
            return messageDao.findPending();
        } catch (SQLException e) {
            log.error("查询待回复留言失败", e);
        }
        return List.of();
    }

    public List<Message> getAllMessages() {
        try {
            return messageDao.findAll();
        } catch (SQLException e) {
            log.error("查询所有留言失败", e);
        }
        return List.of();
    }

    public boolean addMessage(Message message) {
        try {
            return messageDao.save(message) > 0;
        } catch (SQLException e) {
            log.error("添加留言失败", e);
        }
        return false;
    }

    public boolean replyMessage(Long id, Long mechanicId, String replyContent) {
        try {
            return messageDao.reply(id, mechanicId, replyContent) > 0;
        } catch (SQLException e) {
            log.error("回复留言失败, messageId={}, mechanicId={}", id, mechanicId, e);
        }
        return false;
    }

    public boolean deleteMessage(Long id) {
        try {
            return messageDao.delete(id) > 0;
        } catch (SQLException e) {
            log.error("删除留言失败, messageId={}", id, e);
        }
        return false;
    }

    public int getPendingCount() {
        try {
            return messageDao.countPending();
        } catch (SQLException e) {
            log.error("统计待回复留言数量失败", e);
        }
        return 0;
    }
}
