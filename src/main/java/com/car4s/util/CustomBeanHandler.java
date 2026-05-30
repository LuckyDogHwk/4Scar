package com.car4s.util;

import org.apache.commons.dbutils.BasicRowProcessor;
import org.apache.commons.dbutils.RowProcessor;
import org.apache.commons.dbutils.handlers.BeanHandler;

/**
 * 自定义Bean处理器
 * 支持下划线转驼峰命名和Java 8时间类型
 * @param <T> Bean类型
 */
public class CustomBeanHandler<T> extends BeanHandler<T> {
    private static final RowProcessor processor = new BasicRowProcessor(new CustomBeanProcessor());

    public CustomBeanHandler(Class<T> type) {
        super(type, processor);
    }
}
