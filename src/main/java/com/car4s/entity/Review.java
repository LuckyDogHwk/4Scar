package com.car4s.entity;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.time.LocalDateTime;

/**
 * 评价实体类
 * 用于记录客户对服务的评价和评分
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Review {
    private Long id;
    private Long orderId;
    private Long ownerId;
    private Integer rating;
    private String content;
    private LocalDateTime createTime;
    
    private String ownerName;
    private String orderNo;
}
