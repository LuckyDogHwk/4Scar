package com.car4s.entity;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 配件实体类
 * 包含配件的基本信息、价格和库存
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Part {
    private Long id;
    private String partNo;
    private String partName;
    private String brand;
    private String model;
    private BigDecimal price;
    private Integer stock;
    private String description;
    private String imageUrl;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
