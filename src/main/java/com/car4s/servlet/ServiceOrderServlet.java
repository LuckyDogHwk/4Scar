package com.car4s.servlet;

import com.car4s.entity.Car;
import com.car4s.entity.ServiceOrder;
import com.car4s.entity.User;
import com.car4s.service.CarService;
import com.car4s.service.ReviewService;
import com.car4s.service.ServiceOrderService;
import com.car4s.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 * 服务订单控制器
 * 处理订单创建、分配、完成和取消等请求
 */
@WebServlet("/order")
public class ServiceOrderServlet extends HttpServlet {
    private static final Logger log = LoggerFactory.getLogger(ServiceOrderServlet.class);
    private final ServiceOrderService orderService = new ServiceOrderService();
    private final CarService carService = new CarService();
    private final UserService userService = new UserService();
    private final ReviewService reviewService = new ReviewService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if ("list".equals(action)) {
            listOrders(req, resp);
        } else if ("my".equals(action)) {
            myOrders(req, resp);
        } else if ("pending".equals(action)) {
            pendingOrders(req, resp);
        } else if ("delete".equals(action)) {
            deleteOrder(req, resp);
        } else if ("detail".equals(action)) {
            orderDetail(req, resp);
        } else if ("add".equals(action)) {
            showAddForm(req, resp);
        } else if ("process".equals(action)) {
            showProcessForm(req, resp);
        } else if ("accept".equals(action)) {
            acceptOrder(req, resp);
        } else if ("assign".equals(action)) {
            assignMechanic(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if ("add".equals(action)) {
            createOrder(req, resp);
        } else if ("assign".equals(action)) {
            assignMechanic(req, resp);
        } else if ("complete".equals(action)) {
            completeOrder(req, resp);
        } else if ("cancel".equals(action)) {
            cancelOrder(req, resp);
        } else if ("update".equals(action)) {
            updateOrder(req, resp);
        }
    }

    private void listOrders(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<ServiceOrder> orders = orderService.getAllOrders();
        List<User> mechanics = userService.getMechanics();
        req.setAttribute("orders", orders);
        req.setAttribute("mechanics", mechanics);
        req.getRequestDispatcher("/admin/orders.jsp").forward(req, resp);
    }

    private void myOrders(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        List<ServiceOrder> orders;
        
        if (user.isMechanic()) {
            orders = orderService.getOrdersByMechanicId(user.getId());
            req.setAttribute("orders", orders);
            req.getRequestDispatcher("/mechanic/orders.jsp").forward(req, resp);
        } else {
            orders = orderService.getOrdersByOwnerId(user.getId());
            // 检查每个订单是否已评价
            for (ServiceOrder order : orders) {
                boolean reviewed = reviewService.hasReview(order.getId(), user.getId());
                order.setReviewed(reviewed);
            }
            req.setAttribute("orders", orders);
            req.getRequestDispatcher("/owner/orders.jsp").forward(req, resp);
        }
    }

    private void showAddForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        List<Car> cars = carService.getCarsByOwnerId(user.getId());
        req.setAttribute("cars", cars);
        req.getRequestDispatcher("/owner/order-add.jsp").forward(req, resp);
    }

    private void pendingOrders(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<ServiceOrder> orders = orderService.getPendingOrders();
        req.setAttribute("orders", orders);
        req.getRequestDispatcher("/mechanic/orders.jsp").forward(req, resp);
    }

    private void showProcessForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        ServiceOrder order = orderService.getOrderById(id);
        req.setAttribute("order", order);
        req.getRequestDispatcher("/mechanic/order-process.jsp").forward(req, resp);
    }

    private void acceptOrder(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        Long orderId = Long.parseLong(req.getParameter("id"));
        
        if (orderService.assignMechanic(orderId, user.getId())) {
            resp.sendRedirect(req.getContextPath() + "/order?action=my");
        } else {
            req.setAttribute("error", "接单失败，订单可能已被其他维修人员接取");
            resp.sendRedirect(req.getContextPath() + "/order?action=pending");
        }
    }

    private void createOrder(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        
        Long carId = Long.parseLong(req.getParameter("carId"));
        String appointmentTime = req.getParameter("appointmentTime");
        String serviceType = req.getParameter("serviceType");
        String serviceContent = req.getParameter("serviceContent");
        
        ServiceOrder order = new ServiceOrder();
        order.setOwnerId(user.getId());
        order.setCarId(carId);
        if (appointmentTime != null && !appointmentTime.isEmpty()) {
            order.setAppointmentTime(LocalDateTime.parse(appointmentTime, DateTimeFormatter.ISO_LOCAL_DATE_TIME));
        }
        order.setServiceType(serviceType);
        order.setServiceContent(serviceContent);
        order.setOrderAmount(BigDecimal.ZERO);
        
        if (orderService.createOrder(order)) {
            resp.sendRedirect(req.getContextPath() + "/order?action=my");
        } else {
            req.setAttribute("error", "创建订单失败");
            List<Car> cars = carService.getCarsByOwnerId(user.getId());
            req.setAttribute("cars", cars);
            req.getRequestDispatcher("/owner/order-add.jsp").forward(req, resp);
        }
    }

    private void assignMechanic(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long orderId = Long.parseLong(req.getParameter("id"));
        Long mechanicId = Long.parseLong(req.getParameter("mechanicId"));
        
        orderService.assignMechanic(orderId, mechanicId);
        resp.sendRedirect(req.getContextPath() + "/order?action=list");
    }

    private void completeOrder(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long orderId = Long.parseLong(req.getParameter("id"));
        String amount = req.getParameter("amount");
        
        ServiceOrder order = orderService.getOrderById(orderId);
        if (amount != null && !amount.isEmpty()) {
            order.setOrderAmount(new BigDecimal(amount));
        }
        order.setStatus("completed");
        order.setCompleteTime(LocalDateTime.now());
        
        carService.updateMaintenanceDate(order.getCarId(), LocalDateTime.now().toLocalDate());
        
        orderService.updateOrder(order);
        resp.sendRedirect(req.getContextPath() + "/order?action=pending");
    }

    private void cancelOrder(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long orderId = Long.parseLong(req.getParameter("id"));
        orderService.cancelOrder(orderId);
        resp.sendRedirect(req.getContextPath() + "/order?action=my");
    }

    private void updateOrder(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long orderId = Long.parseLong(req.getParameter("id"));
        String serviceContent = req.getParameter("serviceContent");
        String amount = req.getParameter("amount");
        
        ServiceOrder order = orderService.getOrderById(orderId);
        order.setServiceContent(serviceContent);
        if (amount != null && !amount.isEmpty()) {
            order.setOrderAmount(new BigDecimal(amount));
        }
        
        orderService.updateOrder(order);
        resp.sendRedirect(req.getContextPath() + "/order?action=pending");
    }

    private void orderDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        ServiceOrder order = orderService.getOrderById(id);
        req.setAttribute("order", order);
        req.getRequestDispatcher("/order-detail.jsp").forward(req, resp);
    }

    private void deleteOrder(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        orderService.deleteOrder(id);
        resp.sendRedirect(req.getContextPath() + "/order?action=list");
    }
}
