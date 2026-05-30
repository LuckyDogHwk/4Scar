package com.car4s.dao;

import com.car4s.entity.ServiceOrder;
import com.car4s.util.DBUtil;
import com.car4s.util.CustomBeanHandler;
import com.car4s.util.CustomBeanListHandler;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;

/**
 * 服务订单数据访问对象
 * 提供订单的增删改查和状态更新操作
 */
public class ServiceOrderDao {
    private final QueryRunner qr = new QueryRunner(DBUtil.getDataSource());

    public ServiceOrder findById(Long id) throws SQLException {
        String sql = "SELECT s.*, u.real_name as owner_name, " +
                "CONCAT(c.brand, ' ', c.model) as car_info, " +
                "c.plate_number as car_plate_number, " +
                "m.real_name as mechanic_name " +
                "FROM service_order s " +
                "LEFT JOIN user u ON s.owner_id = u.id " +
                "LEFT JOIN car c ON s.car_id = c.id " +
                "LEFT JOIN user m ON s.mechanic_id = m.id " +
                "WHERE s.id = ?";
        return qr.query(sql, new CustomBeanHandler<>(ServiceOrder.class), id);
    }

    public ServiceOrder findByOrderNo(String orderNo) throws SQLException {
        String sql = "SELECT * FROM service_order WHERE order_no = ?";
        return qr.query(sql, new CustomBeanHandler<>(ServiceOrder.class), orderNo);
    }

    public List<ServiceOrder> findByOwnerId(Long ownerId) throws SQLException {
        String sql = "SELECT s.*, u.real_name as owner_name, " +
                "CONCAT(c.brand, ' ', c.model) as car_info, " +
                "c.plate_number as car_plate_number, " +
                "m.real_name as mechanic_name " +
                "FROM service_order s " +
                "LEFT JOIN user u ON s.owner_id = u.id " +
                "LEFT JOIN car c ON s.car_id = c.id " +
                "LEFT JOIN user m ON s.mechanic_id = m.id " +
                "WHERE s.owner_id = ? ORDER BY s.create_time DESC";
        return qr.query(sql, new CustomBeanListHandler<>(ServiceOrder.class), ownerId);
    }

    public List<ServiceOrder> findByMechanicId(Long mechanicId) throws SQLException {
        String sql = "SELECT s.*, u.real_name as owner_name, " +
                "CONCAT(c.brand, ' ', c.model) as car_info, " +
                "c.plate_number as car_plate_number, " +
                "m.real_name as mechanic_name " +
                "FROM service_order s " +
                "LEFT JOIN user u ON s.owner_id = u.id " +
                "LEFT JOIN car c ON s.car_id = c.id " +
                "LEFT JOIN user m ON s.mechanic_id = m.id " +
                "WHERE s.mechanic_id = ? ORDER BY s.create_time DESC";
        return qr.query(sql, new CustomBeanListHandler<>(ServiceOrder.class), mechanicId);
    }

    public List<ServiceOrder> findPending() throws SQLException {
        String sql = "SELECT s.*, u.real_name as owner_name, " +
                "CONCAT(c.brand, ' ', c.model) as car_info, " +
                "c.plate_number as car_plate_number, " +
                "m.real_name as mechanic_name " +
                "FROM service_order s " +
                "LEFT JOIN user u ON s.owner_id = u.id " +
                "LEFT JOIN car c ON s.car_id = c.id " +
                "LEFT JOIN user m ON s.mechanic_id = m.id " +
                "WHERE s.status = 'pending' ORDER BY s.appointment_time ASC";
        return qr.query(sql, new CustomBeanListHandler<>(ServiceOrder.class));
    }

    public List<ServiceOrder> findAll() throws SQLException {
        String sql = "SELECT s.*, u.real_name as owner_name, " +
                "CONCAT(c.brand, ' ', c.model) as car_info, " +
                "c.plate_number as car_plate_number, " +
                "m.real_name as mechanic_name " +
                "FROM service_order s " +
                "LEFT JOIN user u ON s.owner_id = u.id " +
                "LEFT JOIN car c ON s.car_id = c.id " +
                "LEFT JOIN user m ON s.mechanic_id = m.id " +
                "ORDER BY s.create_time DESC";
        return qr.query(sql, new CustomBeanListHandler<>(ServiceOrder.class));
    }

    public int save(ServiceOrder order) throws SQLException {
        String sql = "INSERT INTO service_order(order_no, owner_id, car_id, mechanic_id, appointment_time, service_type, service_content, order_amount, status) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";
        return qr.update(sql, order.getOrderNo(), order.getOwnerId(), order.getCarId(), order.getMechanicId(),
                order.getAppointmentTime(), order.getServiceType(), order.getServiceContent(), order.getOrderAmount(), order.getStatus());
    }

    public int update(ServiceOrder order) throws SQLException {
        String sql = "UPDATE service_order SET mechanic_id=?, appointment_time=?, service_type=?, service_content=?, order_amount=?, status=?, complete_time=? WHERE id=?";
        return qr.update(sql, order.getMechanicId(), order.getAppointmentTime(), order.getServiceType(),
                order.getServiceContent(), order.getOrderAmount(), order.getStatus(), order.getCompleteTime(), order.getId());
    }

    public int updateStatus(Long id, String status) throws SQLException {
        String sql = "UPDATE service_order SET status = ? WHERE id = ?";
        return qr.update(sql, status, id);
    }

    public int assignMechanic(Long orderId, Long mechanicId) throws SQLException {
        String sql = "UPDATE service_order SET mechanic_id = ?, status = 'processing' WHERE id = ?";
        return qr.update(sql, mechanicId, orderId);
    }

    public int complete(Long id) throws SQLException {
        String sql = "UPDATE service_order SET status = 'completed', complete_time = ? WHERE id = ?";
        return qr.update(sql, LocalDateTime.now(), id);
    }

    public int delete(Long id) throws SQLException {
        String sql = "DELETE FROM service_order WHERE id = ?";
        return qr.update(sql, id);
    }

    public int count() throws SQLException {
        String sql = "SELECT COUNT(*) FROM service_order";
        return ((Number) qr.query(sql, new ScalarHandler<>())).intValue();
    }

    public int countByStatus(String status) throws SQLException {
        String sql = "SELECT COUNT(*) FROM service_order WHERE status = ?";
        return ((Number) qr.query(sql, new ScalarHandler<>(), status)).intValue();
    }

    public List<ServiceOrder> findCompletedWithoutReview(Long ownerId) throws SQLException {
        String sql = "SELECT s.*, u.real_name as owner_name, " +
                "CONCAT(c.brand, ' ', c.model) as car_info, " +
                "c.plate_number as car_plate_number, " +
                "m.real_name as mechanic_name " +
                "FROM service_order s " +
                "LEFT JOIN user u ON s.owner_id = u.id " +
                "LEFT JOIN car c ON s.car_id = c.id " +
                "LEFT JOIN user m ON s.mechanic_id = m.id " +
                "WHERE s.owner_id = ? AND s.status = 'completed' " +
                "AND s.id NOT IN (SELECT order_id FROM review WHERE owner_id = ?) " +
                "ORDER BY s.complete_time DESC";
        return qr.query(sql, new CustomBeanListHandler<>(ServiceOrder.class), ownerId, ownerId);
    }
}
