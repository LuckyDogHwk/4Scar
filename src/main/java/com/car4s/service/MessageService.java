package com.car4s.service;

import com.car4s.dao.MessageDao;
import com.car4s.entity.Message;

import java.sql.SQLException;
import java.util.List;

/**
 * 留言业务逻辑服务类
 * 提供留言发送、查询和回复等功能
 */
public class MessageService {
    private final MessageDao messageDao = new MessageDao();

    public Message getMessageById(Long id) {
        try {
            return messageDao.findById(id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Message> getMessagesByOwnerId(Long ownerId) {
        try {
            return messageDao.findByOwnerId(ownerId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return List.of();
    }

    public List<Message> getPendingMessages() {
        try {
            return messageDao.findPending();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return List.of();
    }

    public List<Message> getAllMessages() {
        try {
            return messageDao.findAll();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return List.of();
    }

    public boolean addMessage(Message message) {
        try {
            return messageDao.save(message) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean replyMessage(Long id, Long mechanicId, String replyContent) {
        try {
            return messageDao.reply(id, mechanicId, replyContent) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteMessage(Long id) {
        try {
            return messageDao.delete(id) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getPendingCount() {
        try {
            return messageDao.countPending();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
