package com.car4s.service;

import com.car4s.dao.ServiceOrderDao;
import com.car4s.entity.ServiceOrder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

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
    private static final Logger log = LoggerFactory.getLogger(ServiceOrderService.class);
    private final ServiceOrderDao orderDao = new ServiceOrderDao();
    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");

    public ServiceOrder getOrderById(Long id) {
        try {
            return orderDao.findById(id);
        } catch (SQLException e) {
            log.error("查询订单失败, orderId={}", id, e);
        }
        return null;
    }

    public List<ServiceOrder> getOrdersByOwnerId(Long ownerId) {
        try {
            return orderDao.findByOwnerId(ownerId);
        } catch (SQLException e) {
            log.error("查询用户订单列表失败, ownerId={}", ownerId, e);
        }
        return List.of();
    }

    public List<ServiceOrder> getCompletedOrdersWithoutReview(Long ownerId) {
        try {
            return orderDao.findCompletedWithoutReview(ownerId);
        } catch (SQLException e) {
            log.error("查询已完成未评价订单失败, ownerId={}", ownerId, e);
        }
        return List.of();
    }

    public List<ServiceOrder> getOrdersByMechanicId(Long mechanicId) {
        try {
            return orderDao.findByMechanicId(mechanicId);
        } catch (SQLException e) {
            log.error("查询技师订单列表失败, mechanicId={}", mechanicId, e);
        }
        return List.of();
    }

    public List<ServiceOrder> getPendingOrders() {
        try {
            return orderDao.findPending();
        } catch (SQLException e) {
            log.error("查询待处理订单失败", e);
        }
        return List.of();
    }

    public List<ServiceOrder> getAllOrders() {
        try {
            return orderDao.findAll();
        } catch (SQLException e) {
            log.error("查询所有订单失败", e);
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
            log.error("创建订单失败", e);
        }
        return false;
    }

    public boolean updateOrder(ServiceOrder order) {
        try {
            return orderDao.update(order) > 0;
        } catch (SQLException e) {
            log.error("更新订单失败, orderId={}", order.getId(), e);
        }
        return false;
    }

    public boolean assignMechanic(Long orderId, Long mechanicId) {
        try {
            return orderDao.assignMechanic(orderId, mechanicId) > 0;
        } catch (SQLException e) {
            log.error("分配技师失败, orderId={}, mechanicId={}", orderId, mechanicId, e);
        }
        return false;
    }

    public boolean completeOrder(Long orderId) {
        try {
            return orderDao.complete(orderId) > 0;
        } catch (SQLException e) {
            log.error("完成订单失败, orderId={}", orderId, e);
        }
        return false;
    }

    public boolean cancelOrder(Long orderId) {
        try {
            return orderDao.updateStatus(orderId, "cancelled") > 0;
        } catch (SQLException e) {
            log.error("取消订单失败, orderId={}", orderId, e);
        }
        return false;
    }

    public boolean deleteOrder(Long id) {
        try {
            return orderDao.delete(id) > 0;
        } catch (SQLException e) {
            log.error("删除订单失败, orderId={}", id, e);
        }
        return false;
    }

    public int getOrderCount() {
        try {
            return orderDao.count();
        } catch (SQLException e) {
            log.error("统计订单数量失败", e);
        }
        return 0;
    }

    public int getPendingCount() {
        try {
            return orderDao.countByStatus("pending");
        } catch (SQLException e) {
            log.error("统计待处理订单数量失败", e);
        }
        return 0;
    }
}
