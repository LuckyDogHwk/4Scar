package com.car4s.service;

import com.car4s.dao.CarDao;
import com.car4s.entity.Car;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

/**
 * 汽车业务逻辑服务类
 * 提供汽车信息管理和维护日期更新等功能
 */
public class CarService {
    private static final Logger log = LoggerFactory.getLogger(CarService.class);
    private final CarDao carDao = new CarDao();

    public Car getCarById(Long id) {
        try {
            return carDao.findById(id);
        } catch (SQLException e) {
            log.error("查询车辆失败, carId={}", id, e);
        }
        return null;
    }

    public Car getCarByPlateNumber(String plateNumber) {
        try {
            return carDao.findByPlateNumber(plateNumber);
        } catch (SQLException e) {
            log.error("根据车牌号查询车辆失败, plateNumber={}", plateNumber, e);
        }
        return null;
    }

    public List<Car> getCarsByOwnerId(Long ownerId) {
        try {
            return carDao.findByOwnerId(ownerId);
        } catch (SQLException e) {
            log.error("查询用户车辆列表失败, ownerId={}", ownerId, e);
        }
        return List.of();
    }

    public List<Car> getAllCars() {
        try {
            return carDao.findAll();
        } catch (SQLException e) {
            log.error("查询所有车辆失败", e);
        }
        return List.of();
    }

    public boolean addCar(Car car) {
        try {
            if (carDao.findByPlateNumber(car.getPlateNumber()) != null) {
                return false;
            }
            return carDao.save(car) > 0;
        } catch (SQLException e) {
            log.error("添加车辆失败, plateNumber={}", car.getPlateNumber(), e);
        }
        return false;
    }

    public boolean updateCar(Car car) {
        try {
            return carDao.update(car) > 0;
        } catch (SQLException e) {
            log.error("更新车辆失败, carId={}", car.getId(), e);
        }
        return false;
    }

    public boolean deleteCar(Long id) {
        try {
            return carDao.delete(id) > 0;
        } catch (SQLException e) {
            log.error("删除车辆失败, carId={}", id, e);
        }
        return false;
    }

    public boolean updateMaintenanceDate(Long carId, LocalDate date) {
        try {
            return carDao.updateMaintenanceDate(carId, date) > 0;
        } catch (SQLException e) {
            log.error("更新维护日期失败, carId={}", carId, e);
        }
        return false;
    }

    public int getCarCount() {
        try {
            return carDao.count();
        } catch (SQLException e) {
            log.error("统计车辆数量失败", e);
        }
        return 0;
    }
}
