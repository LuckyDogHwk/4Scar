package com.car4s.servlet;

import com.car4s.entity.Review;
import com.car4s.entity.ServiceOrder;
import com.car4s.entity.User;
import com.car4s.service.ReviewService;
import com.car4s.service.ServiceOrderService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

/**
 * 评价管理控制器
 * 处理评价提交和查询请求
 */
@WebServlet("/review")
public class ReviewServlet extends HttpServlet {
    private final ReviewService reviewService = new ReviewService();
    private final ServiceOrderService orderService = new ServiceOrderService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if ("list".equals(action)) {
            listReviews(req, resp);
        } else if ("my".equals(action)) {
            myReviews(req, resp);
        } else if ("delete".equals(action)) {
            deleteReview(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if ("add".equals(action)) {
            addReview(req, resp);
        }
    }

    private void listReviews(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Review> reviews = reviewService.getAllReviews();
        req.setAttribute("reviews", reviews);
        req.getRequestDispatcher("/admin/reviews.jsp").forward(req, resp);
    }

    private void myReviews(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        List<Review> reviews = reviewService.getReviewsByOwnerId(user.getId());
        List<ServiceOrder> ordersForReview = orderService.getCompletedOrdersWithoutReview(user.getId());
        req.setAttribute("reviews", reviews);
        req.setAttribute("ordersForReview", ordersForReview);
        req.getRequestDispatcher("/owner/reviews.jsp").forward(req, resp);
    }

    private void addReview(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        
        Long orderId = Long.parseLong(req.getParameter("orderId"));
        Integer rating = Integer.parseInt(req.getParameter("rating"));
        String content = req.getParameter("content");
        
        Review review = new Review();
        review.setOrderId(orderId);
        review.setOwnerId(user.getId());
        review.setRating(rating);
        review.setContent(content);
        
        reviewService.addReview(review);
        resp.sendRedirect(req.getContextPath() + "/order?action=my");
    }

    private void deleteReview(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        reviewService.deleteReview(id);
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user.isAdmin()) {
            resp.sendRedirect(req.getContextPath() + "/review?action=list");
        } else {
            resp.sendRedirect(req.getContextPath() + "/review?action=my");
        }
    }
}
