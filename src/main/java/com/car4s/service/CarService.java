package com.car4s.service;

import com.car4s.dao.CarDao;
import com.car4s.entity.Car;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

/**
 * 汽车业务逻辑服务类
 * 提供汽车信息管理和维护日期更新等功能
 */
public class CarService {
    private final CarDao carDao = new CarDao();

    public Car getCarById(Long id) {
        try {
            return carDao.findById(id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Car getCarByPlateNumber(String plateNumber) {
        try {
            return carDao.findByPlateNumber(plateNumber);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Car> getCarsByOwnerId(Long ownerId) {
        try {
            return carDao.findByOwnerId(ownerId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return List.of();
    }
    
    public List<Car> getAllCars() {
        try {
            return carDao.findAll();
        } catch (SQLException e) {
            e.printStackTrace();
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
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateCar(Car car) {
        try {
            return carDao.update(car) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteCar(Long id) {
        try {
            return carDao.delete(id) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateMaintenanceDate(Long carId, LocalDate date) {
        try {
            return carDao.updateMaintenanceDate(carId, date) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getCarCount() {
        try {
            return carDao.count();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
