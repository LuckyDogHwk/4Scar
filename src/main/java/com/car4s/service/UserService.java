package com.car4s.service;

import com.car4s.dao.UserDao;
import com.car4s.entity.User;
import com.car4s.util.MD5Util;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.SQLException;
import java.util.List;

/**
 * 用户业务逻辑服务类
 * 提供用户登录、注册、信息更新等业务功能
 */
public class UserService {
    private static final Logger log = LoggerFactory.getLogger(UserService.class);
    private final UserDao userDao = new UserDao();

    public User login(String username, String password) {
        try {
            User user = userDao.findByUsername(username);
            if (user != null && MD5Util.encrypt(password).equals(user.getPassword()) && user.getStatus() == 1) {
                return user;
            }
        } catch (SQLException e) {
            log.error("登录失败, username={}", username, e);
        }
        return null;
    }

    public boolean register(User user) {
        try {
            if (userDao.findByUsername(user.getUsername()) != null) {
                return false;
            }
            user.setRole("owner");
            user.setStatus(1);
            return userDao.save(user) > 0;
        } catch (SQLException e) {
            log.error("注册失败, username={}", user.getUsername(), e);
        }
        return false;
    }

    public User getUserById(Long id) {
        try {
            return userDao.findById(id);
        } catch (SQLException e) {
            log.error("查询用户失败, userId={}", id, e);
        }
        return null;
    }

    public boolean updateUser(User user) {
        try {
            return userDao.update(user) > 0;
        } catch (SQLException e) {
            log.error("更新用户失败, userId={}", user.getId(), e);
        }
        return false;
    }

    public boolean changePassword(Long userId, String oldPassword, String newPassword) {
        try {
            User user = userDao.findById(userId);
            if (user != null && user.getPassword().equals(oldPassword)) {
                return userDao.updatePassword(userId, newPassword) > 0;
            }
        } catch (SQLException e) {
            log.error("修改密码失败, userId={}", userId, e);
        }
        return false;
    }

    public boolean updateUsername(Long userId, String newUsername) {
        try {
            // 检查用户名是否已被其他用户使用
            if (userDao.existsByUsernameExcludeId(newUsername, userId)) {
                return false;
            }
            return userDao.updateUsername(userId, newUsername) > 0;
        } catch (SQLException e) {
            log.error("修改用户名失败, userId={}, newUsername={}", userId, newUsername, e);
        }
        return false;
    }

    public boolean updatePassword(Long userId, String newPassword) {
        try {
            return userDao.updatePassword(userId, newPassword) > 0;
        } catch (SQLException e) {
            log.error("重置密码失败, userId={}", userId, e);
        }
        return false;
    }

    public List<User> getAllUsers() {
        try {
            return userDao.findAll();
        } catch (SQLException e) {
            log.error("查询所有用户失败", e);
        }
        return List.of();
    }

    public List<User> getOwners() {
        try {
            return userDao.findOwners();
        } catch (SQLException e) {
            log.error("查询车主列表失败", e);
        }
        return List.of();
    }

    public List<User> getMechanics() {
        try {
            return userDao.findMechanics();
        } catch (SQLException e) {
            log.error("查询维修技师列表失败", e);
        }
        return List.of();
    }

    public boolean addUser(User user) {
        try {
            if (userDao.findByUsername(user.getUsername()) != null) {
                return false;
            }
            if (user.getRole() == null) {
                user.setRole("owner");
            }
            if (user.getStatus() == null) {
                user.setStatus(1);
            }
            return userDao.save(user) > 0;
        } catch (SQLException e) {
            log.error("添加用户失败, username={}", user.getUsername(), e);
        }
        return false;
    }

    public boolean deleteUser(Long id) {
        try {
            return userDao.delete(id) > 0;
        } catch (SQLException e) {
            log.error("删除用户失败, userId={}", id, e);
        }
        return false;
    }

    public boolean updateUserStatus(Long id, Integer status) {
        try {
            User user = userDao.findById(id);
            if (user != null) {
                user.setStatus(status);
                return userDao.update(user) > 0;
            }
        } catch (SQLException e) {
            log.error("更新用户状态失败, userId={}, status={}", id, status, e);
        }
        return false;
    }
}
