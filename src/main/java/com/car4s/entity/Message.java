package com.car4s.entity;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.time.LocalDateTime;

/**
 * 留言实体类
 * 用于车主与维修人员之间的沟通
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Message {
    private Long id;
    private Long ownerId;
    private Long mechanicId;
    private String title;
    private String content;
    private String replyContent;
    private String status;
    private LocalDateTime createTime;
    private LocalDateTime replyTime;
    
    private String ownerName;
    private String mechanicName;
}
