package com.car4s.entity;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * 汽车实体类
 * 包含车辆的基本信息和维护周期等属性
 */
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

    public Car() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getOwnerId() { return ownerId; }
    public void setOwnerId(Long ownerId) { this.ownerId = ownerId; }
    public String getPlateNumber() { return plateNumber; }
    public void setPlateNumber(String plateNumber) { this.plateNumber = plateNumber; }
    public String getBrand() { return brand; }
    public void setBrand(String brand) { this.brand = brand; }
    public String getModel() { return model; }
    public void setModel(String model) { this.model = model; }
    public LocalDate getPurchaseDate() { return purchaseDate; }
    public void setPurchaseDate(LocalDate purchaseDate) { this.purchaseDate = purchaseDate; }
    public String getVin() { return vin; }
    public void setVin(String vin) { this.vin = vin; }
    public Integer getMaintenanceCycle() { return maintenanceCycle; }
    public void setMaintenanceCycle(Integer maintenanceCycle) { this.maintenanceCycle = maintenanceCycle; }
    public LocalDate getLastMaintenanceDate() { return lastMaintenanceDate; }
    public void setLastMaintenanceDate(LocalDate lastMaintenanceDate) { this.lastMaintenanceDate = lastMaintenanceDate; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public LocalDateTime getCreateTime() { return createTime; }
    public void setCreateTime(LocalDateTime createTime) { this.createTime = createTime; }
    public LocalDateTime getUpdateTime() { return updateTime; }
    public void setUpdateTime(LocalDateTime updateTime) { this.updateTime = updateTime; }
    public String getOwnerName() { return ownerName; }
    public void setOwnerName(String ownerName) { this.ownerName = ownerName; }
}
