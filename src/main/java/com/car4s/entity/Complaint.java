package com.car4s.entity;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.time.LocalDateTime;

/**
 * 投诉实体类
 * 用于记录客户投诉和处理结果
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Complaint {
    private Long id;
    private Long ownerId;
    private Long orderId;
    private String title;
    private String content;
    private String status;
    private String handleResult;
    private LocalDateTime handleTime;
    private LocalDateTime createTime;
    
    private String ownerName;
    private String orderNo;
}
