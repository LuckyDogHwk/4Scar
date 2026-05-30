package com.car4s.servlet;

import com.car4s.entity.User;
import com.car4s.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * 用户管理控制器
 * 处理用户列表、添加、编辑和删除请求
 */
@WebServlet("/user")
public class UserServlet extends HttpServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if ("list".equals(action)) {
            listUsers(req, resp);
        } else if ("delete".equals(action)) {
            deleteUser(req, resp);
        } else if ("edit".equals(action)) {
            editUser(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if ("add".equals(action)) {
            addUser(req, resp);
        } else if ("update".equals(action)) {
            updateUser(req, resp);
        } else if ("status".equals(action)) {
            updateStatus(req, resp);
        }
    }

    private void listUsers(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String role = req.getParameter("role");
        List<User> users;
        if ("owner".equals(role)) {
            users = userService.getOwners();
        } else if ("mechanic".equals(role)) {
            users = userService.getMechanics();
        } else {
            users = userService.getAllUsers();
        }
        req.setAttribute("users", users);
        req.setAttribute("role", role);
        req.getRequestDispatcher("/admin/users.jsp").forward(req, resp);
    }

    private void addUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String realName = req.getParameter("realName");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        String role = req.getParameter("role");

        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setRealName(realName);
        user.setPhone(phone);
        user.setEmail(email);
        user.setRole(role);
        user.setStatus(1);

        if (userService.addUser(user)) {
            resp.sendRedirect(req.getContextPath() + "/user?action=list&role=" + role);
        } else {
            req.setAttribute("error", "用户名已存在");
            req.setAttribute("user", user);
            req.getRequestDispatcher("/admin/user-add.jsp").forward(req, resp);
        }
    }

    private void editUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        User user = userService.getUserById(id);
        req.setAttribute("user", user);
        req.getRequestDispatcher("/admin/user-edit.jsp").forward(req, resp);
    }

    private void updateUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        String realName = req.getParameter("realName");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");

        User user = userService.getUserById(id);
        user.setRealName(realName);
        user.setPhone(phone);
        user.setEmail(email);

        userService.updateUser(user);
        resp.sendRedirect(req.getContextPath() + "/user?action=list&role=" + user.getRole());
    }

    private void deleteUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        userService.deleteUser(id);
        resp.sendRedirect(req.getContextPath() + "/user?action=list");
    }

    private void updateStatus(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        Integer status = Integer.parseInt(req.getParameter("status"));
        userService.updateUserStatus(id, status);
        resp.sendRedirect(req.getContextPath() + "/user?action=list");
    }
}
