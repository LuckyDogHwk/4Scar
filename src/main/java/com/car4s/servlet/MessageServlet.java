package com.car4s.servlet;

import com.car4s.entity.Message;
import com.car4s.entity.User;
import com.car4s.service.MessageService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

/**
 * 留言管理控制器
 * 处理留言发送、查询和回复请求
 */
@WebServlet("/message")
public class MessageServlet extends HttpServlet {
    private final MessageService messageService = new MessageService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if ("list".equals(action)) {
            listMessages(req, resp);
        } else if ("my".equals(action)) {
            myMessages(req, resp);
        } else if ("pending".equals(action)) {
            pendingMessages(req, resp);
        } else if ("delete".equals(action)) {
            deleteMessage(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if ("add".equals(action)) {
            addMessage(req, resp);
        } else if ("reply".equals(action)) {
            replyMessage(req, resp);
        }
    }

    private void listMessages(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Message> messages = messageService.getAllMessages();
        req.setAttribute("messages", messages);
        req.getRequestDispatcher("/admin/messages.jsp").forward(req, resp);
    }

    private void myMessages(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        List<Message> messages = messageService.getMessagesByOwnerId(user.getId());
        req.setAttribute("messages", messages);
        req.getRequestDispatcher("/owner/messages.jsp").forward(req, resp);
    }

    private void pendingMessages(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Message> messages = messageService.getPendingMessages();
        req.setAttribute("messages", messages);
        req.getRequestDispatcher("/mechanic/messages.jsp").forward(req, resp);
    }

    private void addMessage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        
        String title = req.getParameter("title");
        String content = req.getParameter("content");
        
        Message message = new Message();
        message.setOwnerId(user.getId());
        message.setTitle(title);
        message.setContent(content);
        
        messageService.addMessage(message);
        resp.sendRedirect(req.getContextPath() + "/message?action=my");
    }

    private void replyMessage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        
        Long id = Long.parseLong(req.getParameter("id"));
        String replyContent = req.getParameter("replyContent");
        
        messageService.replyMessage(id, user.getId(), replyContent);
        resp.sendRedirect(req.getContextPath() + "/message?action=pending");
    }

    private void deleteMessage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        messageService.deleteMessage(id);
        resp.sendRedirect(req.getContextPath() + "/message?action=list");
    }
}
