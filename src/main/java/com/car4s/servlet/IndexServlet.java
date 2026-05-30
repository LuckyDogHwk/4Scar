package com.car4s.servlet;

import com.car4s.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * 首页控制器
 * 根据用户角色重定向到对应的首页
 */
@WebServlet("/index")
public class IndexServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
        
        if (user.isAdmin()) {
            resp.sendRedirect(req.getContextPath() + "/admin/index.jsp");
        } else if (user.isMechanic()) {
            resp.sendRedirect(req.getContextPath() + "/mechanic/index.jsp");
        } else {
            resp.sendRedirect(req.getContextPath() + "/owner/index.jsp");
        }
    }
}
