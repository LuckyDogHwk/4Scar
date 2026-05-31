package com.car4s.util;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * 分页结果封装类
 * @param <T> 数据类型
 */
@Data
@NoArgsConstructor
public class PageBean<T> {
    private int currentPage;    // 当前页码
    private int pageSize;       // 每页条数
    private int totalCount;     // 总记录数
    private int totalPages;     // 总页数
    private List<T> data;        // 当前页数据

    public PageBean(int currentPage, int pageSize, int totalCount, List<T> data) {
        this.currentPage = currentPage;
        this.pageSize = pageSize;
        this.totalCount = totalCount;
        this.data = data;
        this.totalPages = (totalCount + pageSize - 1) / pageSize;
    }
}
