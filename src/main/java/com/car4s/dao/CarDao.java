package com.car4s.dao;

import com.car4s.entity.Car;
import com.car4s.util.DBUtil;
import com.car4s.util.CustomBeanHandler;
import com.car4s.util.CustomBeanListHandler;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.sql.SQLException;
import java.util.List;

/**
 * 汽车数据访问对象
 * 提供汽车信息的增删改查操作
 */
public class CarDao {
    private final QueryRunner qr = new QueryRunner(DBUtil.getDataSource());

    public Car findById(Long id) throws SQLException {
        String sql = "SELECT c.*, u.real_name as owner_name FROM car c LEFT JOIN user u ON c.owner_id = u.id WHERE c.id = ?";
        return qr.query(sql, new CustomBeanHandler<>(Car.class), id);
    }

    public Car findByPlateNumber(String plateNumber) throws SQLException {
        String sql = "SELECT * FROM car WHERE plate_number = ?";
        return qr.query(sql, new CustomBeanHandler<>(Car.class), plateNumber);
    }

    public List<Car> findByOwnerId(Long ownerId) throws SQLException {
        String sql = "SELECT c.*, u.real_name as owner_name FROM car c LEFT JOIN user u ON c.owner_id = u.id WHERE c.owner_id = ? ORDER BY c.create_time DESC";
        return qr.query(sql, new CustomBeanListHandler<>(Car.class), ownerId);
    }

    public List<Car> findAll() throws SQLException {
        String sql = "SELECT c.*, u.real_name as owner_name FROM car c LEFT JOIN user u ON c.owner_id = u.id ORDER BY c.create_time DESC";
        return qr.query(sql, new CustomBeanListHandler<>(Car.class));
    }

    public int save(Car car) throws SQLException {
        String sql = "INSERT INTO car(owner_id, plate_number, brand, model, purchase_date, vin, maintenance_cycle, last_maintenance_date, image_url) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";
        return qr.update(sql, car.getOwnerId(), car.getPlateNumber(), car.getBrand(), car.getModel(),
                car.getPurchaseDate(), car.getVin(), car.getMaintenanceCycle(), car.getLastMaintenanceDate(), car.getImageUrl());
    }

    public int update(Car car) throws SQLException {
        String sql = "UPDATE car SET plate_number=?, brand=?, model=?, purchase_date=?, vin=?, maintenance_cycle=?, last_maintenance_date=?, image_url=? WHERE id=?";
        return qr.update(sql, car.getPlateNumber(), car.getBrand(), car.getModel(), car.getPurchaseDate(),
                car.getVin(), car.getMaintenanceCycle(), car.getLastMaintenanceDate(), car.getImageUrl(), car.getId());
    }

    public int delete(Long id) throws SQLException {
        String sql = "DELETE FROM car WHERE id = ?";
        return qr.update(sql, id);
    }

    public int count() throws SQLException {
        String sql = "SELECT COUNT(*) FROM car";
        return ((Number) qr.query(sql, new ScalarHandler<>())).intValue();
    }

    public int updateMaintenanceDate(Long id, java.time.LocalDate date) throws SQLException {
        String sql = "UPDATE car SET last_maintenance_date = ? WHERE id = ?";
        return qr.update(sql, date, id);
    }
}
