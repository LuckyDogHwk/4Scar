package com.car4s.entity;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * 汽车实体类
 * 包含车辆的基本信息和维护周期等属性
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Car {
    private Long id;
    private Long ownerId;
    private String plateNumber;
    private String brand;
    private String model;
    private LocalDate purchaseDate;
    private String vin;
    private Integer maintenanceCycle;
    private LocalDate lastMaintenanceDate;
    private String imageUrl;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    
    private String ownerName;
}
