package com.car4s.servlet;

import com.car4s.entity.Complaint;
import com.car4s.entity.User;
import com.car4s.service.ComplaintService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.List;

/**
 * 投诉管理控制器
 * 处理投诉提交、查询和处理请求
 */
@WebServlet("/complaint")
public class ComplaintServlet extends HttpServlet {
    private static final Logger log = LoggerFactory.getLogger(ComplaintServlet.class);
    private final ComplaintService complaintService = new ComplaintService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if ("list".equals(action)) {
            listComplaints(req, resp);
        } else if ("my".equals(action)) {
            myComplaints(req, resp);
        } else if ("pending".equals(action)) {
            pendingComplaints(req, resp);
        } else if ("handle".equals(action)) {
            showHandleForm(req, resp);
        } else if ("delete".equals(action)) {
            deleteComplaint(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if ("add".equals(action)) {
            addComplaint(req, resp);
        } else if ("handle".equals(action)) {
            handleComplaint(req, resp);
        }
    }

    private void listComplaints(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Complaint> complaints = complaintService.getAllComplaints();
        req.setAttribute("complaints", complaints);
        req.getRequestDispatcher("/admin/complaints.jsp").forward(req, resp);
    }

    private void myComplaints(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        List<Complaint> complaints = complaintService.getComplaintsByOwnerId(user.getId());
        req.setAttribute("complaints", complaints);
        req.getRequestDispatcher("/owner/complaints.jsp").forward(req, resp);
    }

    private void pendingComplaints(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Complaint> complaints = complaintService.getPendingComplaints();
        req.setAttribute("complaints", complaints);
        req.getRequestDispatcher("/admin/complaints.jsp").forward(req, resp);
    }

    private void addComplaint(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        
        String orderId = req.getParameter("orderId");
        String title = req.getParameter("title");
        String content = req.getParameter("content");
        
        Complaint complaint = new Complaint();
        complaint.setOwnerId(user.getId());
        if (orderId != null && !orderId.isEmpty()) {
            complaint.setOrderId(Long.parseLong(orderId));
        }
        complaint.setTitle(title);
        complaint.setContent(content);
        
        complaintService.addComplaint(complaint);
        resp.sendRedirect(req.getContextPath() + "/complaint?action=my");
    }

    private void showHandleForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/complaint?action=list&error=invalid_id");
            return;
        }
        Long id = Long.parseLong(idStr);
        Complaint complaint = complaintService.getComplaintById(id);
        if (complaint == null) {
            resp.sendRedirect(req.getContextPath() + "/complaint?action=list&error=not_found");
            return;
        }
        req.setAttribute("complaint", complaint);
        req.getRequestDispatcher("/admin/complaint-handle.jsp").forward(req, resp);
    }

    private void handleComplaint(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String idStr = req.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/complaint?action=list&error=invalid_id");
            return;
        }
        Long id = Long.parseLong(idStr);
        String handleResult = req.getParameter("handleResult");
        
        log.info("处理投诉: id={}, handleResult={}", id, handleResult);
        
        boolean success = complaintService.handleComplaint(id, handleResult);
        log.info("处理结果: {}", success);
        
        resp.sendRedirect(req.getContextPath() + "/complaint?action=list");
    }

    private void deleteComplaint(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        complaintService.deleteComplaint(id);
        resp.sendRedirect(req.getContextPath() + "/complaint?action=list");
    }
}
