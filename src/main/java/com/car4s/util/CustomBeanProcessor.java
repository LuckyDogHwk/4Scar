package com.car4s.util;

import org.apache.commons.dbutils.BeanProcessor;

import java.beans.PropertyDescriptor;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Arrays;

/**
 * 自定义Bean处理器
 * 支持数据库下划线命名转Java驼峰命名
 * 支持Java 8时间类型（LocalDate、LocalDateTime）
 */
public class CustomBeanProcessor extends BeanProcessor {
    private static final java.util.List<String> IGNORED_COLUMNS = Arrays.asList();

    @Override
    protected int[] mapColumnsToProperties(ResultSetMetaData rsmd, PropertyDescriptor[] props) throws SQLException {
        int cols = rsmd.getColumnCount();
        int[] columnToProperty = new int[cols + 1];
        Arrays.fill(columnToProperty, PROPERTY_NOT_FOUND);

        for (int col = 1; col <= cols; col++) {
            String columnName = rsmd.getColumnLabel(col);
            if (columnName == null || columnName.isEmpty()) {
                columnName = rsmd.getColumnName(col);
            }
            
            String propertyName = toCamelCase(columnName);
            
            for (int i = 0; i < props.length; i++) {
                if (propertyName.equalsIgnoreCase(props[i].getName())) {
                    columnToProperty[col] = i;
                    break;
                }
            }
        }
        return columnToProperty;
    }

    @Override
    protected Object processColumn(ResultSet rs, int index, Class<?> propType) throws SQLException {
        if (propType.equals(LocalDate.class)) {
            Date date = rs.getDate(index);
            return date != null ? date.toLocalDate() : null;
        } else if (propType.equals(LocalDateTime.class)) {
            Timestamp timestamp = rs.getTimestamp(index);
            return timestamp != null ? timestamp.toLocalDateTime() : null;
        }
        return super.processColumn(rs, index, propType);
    }

    private String toCamelCase(String columnName) {
        StringBuilder result = new StringBuilder();
        boolean nextUpper = false;
        
        for (int i = 0; i < columnName.length(); i++) {
            char c = columnName.charAt(i);
            if (c == '_') {
                nextUpper = true;
            } else {
                if (nextUpper) {
                    result.append(Character.toUpperCase(c));
                    nextUpper = false;
                } else {
                    result.append(Character.toLowerCase(c));
                }
            }
        }
        return result.toString();
    }
}
