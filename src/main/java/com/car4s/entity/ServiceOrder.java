package com.car4s.entity;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 服务订单实体类
 * 包含维修服务订单的完整信息
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ServiceOrder {
    private Long id;
    private String orderNo;
    private Long ownerId;
    private Long carId;
    private Long mechanicId;
    private LocalDateTime appointmentTime;
    private String serviceType;
    private String serviceContent;
    private BigDecimal orderAmount;
    private String status;
    private LocalDateTime completeTime;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    
    private String ownerName;
    private String carInfo;
    private String carPlateNumber;
    private String mechanicName;
    private boolean reviewed;
}
