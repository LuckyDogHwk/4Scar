<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.car4s.entity.User" %>
<%@ page import="com.car4s.service.*" %>
<%@ page import="java.util.*" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    UserService userService = new UserService();
    CarService carService = new CarService();
    ServiceOrderService orderService = new ServiceOrderService();
    MessageService messageService = new MessageService();
    ComplaintService complaintService = new ComplaintService();
    PartService partService = new PartService();
    ReviewService reviewService = new ReviewService();
    
    System.out.println("DEBUG - User logged in: " + user.getUsername() + ", ID: " + user.getId());
    
    if (user.isAdmin()) {
        request.setAttribute("userCount", userService.getAllUsers().size());
        request.setAttribute("carCount", carService.getCarCount());
        request.setAttribute("orderCount", orderService.getOrderCount());
        request.setAttribute("pendingCount", orderService.getPendingCount());
        request.setAttribute("complaintCount", complaintService.getPendingCount());
        request.setAttribute("partCount", partService.getPartCount());
        request.getRequestDispatcher("/admin/index.jsp").forward(request, response);
    } else if (user.isMechanic()) {
        request.setAttribute("pendingCount", orderService.getPendingCount());
        request.setAttribute("pendingOrders", orderService.getPendingOrders());
        List<com.car4s.entity.ServiceOrder> myOrders = orderService.getOrdersByMechanicId(user.getId());
        int processing = 0, completed = 0;
        for (com.car4s.entity.ServiceOrder o : myOrders) {
            if ("processing".equals(o.getStatus())) processing++;
            if ("completed".equals(o.getStatus())) completed++;
        }
        request.setAttribute("processingCount", processing);
        request.setAttribute("completedCount", completed);
        request.getRequestDispatcher("/mechanic/index.jsp").forward(request, response);
    } else {
        List<com.car4s.entity.Car> cars = carService.getCarsByOwnerId(user.getId());
        System.out.println("DEBUG - Owner ID: " + user.getId() + ", Cars found: " + cars.size());
        for (com.car4s.entity.Car c : cars) {
            System.out.println("DEBUG - Car: " + c.getBrand() + " " + c.getModel() + ", plate: " + c.getPlateNumber());
        }
        
        List<com.car4s.entity.ServiceOrder> orders = orderService.getOrdersByOwnerId(user.getId());
        List<com.car4s.entity.Message> messages = messageService.getMessagesByOwnerId(user.getId());
        List<com.car4s.entity.Review> reviews = reviewService.getReviewsByOwnerId(user.getId());
        
        int pending = 0, completed = 0;
        for (com.car4s.entity.ServiceOrder o : orders) {
            if ("pending".equals(o.getStatus()) || "processing".equals(o.getStatus())) pending++;
            if ("completed".equals(o.getStatus())) completed++;
        }
        request.setAttribute("carCount", cars.size());
        request.setAttribute("orderCount", orders.size());
        request.setAttribute("pendingCount", pending);
        request.setAttribute("completedCount", completed);
        request.setAttribute("messageCount", messages.size());
        request.setAttribute("reviewCount", reviews.size());
        
        request.setAttribute("myCars", cars);
        
        int displayCount = Math.min(5, orders.size());
        request.setAttribute("recentOrders", orders.subList(0, displayCount > 0 ? displayCount : 0));
        request.getRequestDispatcher("/owner/index.jsp").forward(request, response);
    }
%>
