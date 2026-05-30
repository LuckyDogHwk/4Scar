package com.car4s.service;

import com.car4s.dao.UserDao;
import com.car4s.entity.User;
import java.sql.SQLException;
import java.util.List;

/**
 * 用户业务逻辑服务类
 * 提供用户登录、注册、信息更新等业务功能
 */
public class UserService {
    private final UserDao userDao = new UserDao();

    public User login(String username, String password) {
        try {
            User user = userDao.findByUsername(username);
            if (user != null && user.getPassword().equals(password) && user.getStatus() == 1) {
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
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
            e.printStackTrace();
        }
        return false;
    }

    public User getUserById(Long id) {
        try {
            return userDao.findById(id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateUser(User user) {
        try {
            return userDao.update(user) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
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
            e.printStackTrace();
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
            e.printStackTrace();
        }
        return false;
    }

    public boolean updatePassword(Long userId, String newPassword) {
        try {
            return userDao.updatePassword(userId, newPassword) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<User> getAllUsers() {
        try {
            return userDao.findAll();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return List.of();
    }

    public List<User> getOwners() {
        try {
            return userDao.findOwners();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return List.of();
    }

    public List<User> getMechanics() {
        try {
            return userDao.findMechanics();
        } catch (SQLException e) {
            e.printStackTrace();
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
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteUser(Long id) {
        try {
            return userDao.delete(id) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
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
            e.printStackTrace();
        }
        return false;
    }
}
