package com.car4s.servlet;

import com.car4s.entity.User;
import com.car4s.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

/**
 * 认证控制器
 * 处理用户登录、注册和登出请求
 */
@WebServlet("/auth")
public class AuthServlet extends HttpServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        
        System.out.println("AuthServlet doPost called, action: " + action);
        
        try {
            if ("login".equals(action)) {
                login(req, resp);
            } else if ("register".equals(action)) {
                register(req, resp);
            } else if ("logout".equals(action)) {
                logout(req, resp);
            } else if ("updateProfile".equals(action)) {
                updateProfile(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            showError(resp, "操作失败: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("logout".equals(action)) {
            logout(req, resp);
        } else if ("profile".equals(action)) {
            showProfile(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
        }
    }

    private void login(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        
        System.out.println("Login attempt: " + username);
        
        User user = userService.login(username, password);
        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            System.out.println("Login success, redirecting to index.jsp");
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
        } else {
            System.out.println("Login failed");
            req.setAttribute("error", "用户名或密码错误");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }

    private void register(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String realName = req.getParameter("realName");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        
        System.out.println("Register attempt: " + username);
        
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setRealName((realName != null && !realName.trim().isEmpty()) ? realName : username);
        user.setPhone(phone);
        user.setEmail(email);
        
        boolean success = userService.register(user);
        System.out.println("Register result: " + success);
        
        if (success) {
            System.out.println("Register success, redirecting to login.jsp");
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
        } else {
            System.out.println("Register failed: username exists");
            req.setAttribute("error", "用户名已存在");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        }
    }

    private void logout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        resp.sendRedirect(req.getContextPath() + "/login.jsp");
    }

    private void showProfile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
        // 重新从数据库获取最新信息
        User latestUser = userService.getUserById(user.getId());
        req.setAttribute("user", latestUser);
        session.setAttribute("user", latestUser);
        
        String targetPage;
        if (latestUser.isAdmin()) {
            targetPage = "/admin/profile.jsp";
        } else if (latestUser.isMechanic()) {
            targetPage = "/mechanic/profile.jsp";
        } else {
            targetPage = "/owner/profile.jsp";
        }
        req.getRequestDispatcher(targetPage).forward(req, resp);
    }

    private void updateProfile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
        
        String newUsername = req.getParameter("username");
        String newPassword = req.getParameter("newPassword");
        String realName = req.getParameter("realName");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        
        // 更新基本信息
        user.setRealName(realName);
        user.setPhone(phone);
        user.setEmail(email);
        
        boolean success = userService.updateUser(user);
        
        // 更新用户名（如果改变且未被使用）
        if (newUsername != null && !newUsername.trim().isEmpty() 
                && !newUsername.equals(user.getUsername())) {
            if (userService.updateUsername(user.getId(), newUsername)) {
                user.setUsername(newUsername);
            } else {
                req.setAttribute("error", "用户名已被使用，请选择其他用户名");
                String errorPage = getProfilePage(user);
                req.getRequestDispatcher(errorPage).forward(req, resp);
                return;
            }
        }
        
        // 更新密码（如果填写了新密码）
        if (newPassword != null && !newPassword.trim().isEmpty()) {
            userService.updatePassword(user.getId(), newPassword);
        }
        
        if (success) {
            // 更新session中的用户信息
            User latestUser = userService.getUserById(user.getId());
            session.setAttribute("user", latestUser);
            resp.sendRedirect(req.getContextPath() + "/auth?action=profile&success=true");
        } else {
            req.setAttribute("error", "修改失败，请重试");
            String errorPage = getProfilePage(user);
            req.getRequestDispatcher(errorPage).forward(req, resp);
        }
    }
    
    private String getProfilePage(User user) {
        if (user.isAdmin()) {
            return "/admin/profile.jsp";
        } else if (user.isMechanic()) {
            return "/mechanic/profile.jsp";
        } else {
            return "/owner/profile.jsp";
        }
    }
    
    private void showError(HttpServletResponse resp, String message) throws IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        out.println("<!DOCTYPE html>");
        out.println("<html><head><meta charset='UTF-8'><title>错误</title></head><body>");
        out.println("<h2>" + message + "</h2>");
        out.println("<a href='javascript:history.back()'>返回</a>");
        out.println("</body></html>");
    }
}
