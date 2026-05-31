package com.car4s.entity;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.time.LocalDateTime;

/**
 * 用户实体类
 * 包含用户的基本信息和角色判断方法
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
    private Long id;
    private String username;
    private String password;
    private String realName;
    private String phone;
    private String email;
    private String role;
    private Integer status;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    public boolean isAdmin() { return "admin".equals(role); }
    public boolean isMechanic() { return "mechanic".equals(role); }
    public boolean isOwner() { return "owner".equals(role); }
}
