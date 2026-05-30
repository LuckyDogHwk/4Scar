package com.car4s.util;

import com.alibaba.druid.pool.DruidDataSource;
import com.alibaba.druid.pool.DruidDataSourceFactory;

import javax.sql.DataSource;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

/**
 * 数据库连接工具类
 * 使用Druid连接池管理数据库连接
 */
public class DBUtil {
    private static final DruidDataSource DATA_SOURCE;

    static {
        Properties properties = new Properties();
        try {
            InputStream is = DBUtil.class.getClassLoader().getResourceAsStream("druid.properties");
            if (is == null) {
                properties.setProperty("driverClassName", "com.mysql.cj.jdbc.Driver");
                properties.setProperty("url", "jdbc:mysql://localhost:3306/car_4s?useSSL=false&serverTimezone=Asia/Shanghai&allowPublicKeyRetrieval=true");
                properties.setProperty("username", "root");
                properties.setProperty("password", "123456");
                properties.setProperty("initialSize", "5");
                properties.setProperty("minIdle", "5");
                properties.setProperty("maxActive", "20");
                properties.setProperty("maxWait", "60000");
            } else {
                properties.load(is);
            }
            DATA_SOURCE = (DruidDataSource) DruidDataSourceFactory.createDataSource(properties);
        } catch (Exception e) {
            throw new RuntimeException("数据库连接池初始化失败", e);
        }
    }

    public static DataSource getDataSource() {
        return DATA_SOURCE;
    }

    public static Connection getConnection() throws SQLException {
        return DATA_SOURCE.getConnection();
    }

    public static void close(AutoCloseable... closeables) {
        for (AutoCloseable closeable : closeables) {
            if (closeable != null) {
                try {
                    closeable.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
