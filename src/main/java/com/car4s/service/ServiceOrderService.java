package com.car4s.service;

import com.car4s.dao.ServiceOrderDao;
import com.car4s.entity.ServiceOrder;

import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;

/**
 * 服务订单业务逻辑服务类
 * 提供订单创建、分配、完成和取消等功能
 */
public class ServiceOrderService {
    private final ServiceOrderDao orderDao = new ServiceOrderDao();
    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");

    public ServiceOrder getOrderById(Long id) {
        try {
            return orderDao.findById(id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<ServiceOrder> getOrdersByOwnerId(Long ownerId) {
        try {
            return orderDao.findByOwnerId(ownerId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return List.of();
    }

    public List<ServiceOrder> getCompletedOrdersWithoutReview(Long ownerId) {
        try {
            return orderDao.findCompletedWithoutReview(ownerId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return List.of();
    }

    public List<ServiceOrder> getOrdersByMechanicId(Long mechanicId) {
        try {
            return orderDao.findByMechanicId(mechanicId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return List.of();
    }

    public List<ServiceOrder> getPendingOrders() {
        try {
            return orderDao.findPending();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return List.of();
    }

    public List<ServiceOrder> getAllOrders() {
        try {
            return orderDao.findAll();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return List.of();
    }

    public boolean createOrder(ServiceOrder order) {
        try {
            order.setOrderNo("ORD" + LocalDateTime.now().format(FORMATTER) + UUID.randomUUID().toString().substring(0, 4).toUpperCase());
            order.setStatus("pending");
            if (order.getOrderAmount() == null) {
                order.setOrderAmount(java.math.BigDecimal.ZERO);
            }
            return orderDao.save(order) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateOrder(ServiceOrder order) {
        try {
            return orderDao.update(order) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean assignMechanic(Long orderId, Long mechanicId) {
        try {
            return orderDao.assignMechanic(orderId, mechanicId) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean completeOrder(Long orderId) {
        try {
            return orderDao.complete(orderId) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean cancelOrder(Long orderId) {
        try {
            return orderDao.updateStatus(orderId, "cancelled") > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteOrder(Long id) {
        try {
            return orderDao.delete(id) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getOrderCount() {
        try {
            return orderDao.count();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getPendingCount() {
        try {
            return orderDao.countByStatus("pending");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
