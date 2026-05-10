package com.netforum.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import org.apache.commons.dbcp2.BasicDataSource;

/**
 * 数据库连接工具类 - 使用DBCP连接池
 */
public class DBUtil {

    private static String driver;
    private static String url;
    private static String username;
    private static String password;

    private static BasicDataSource dataSource;

    static {
        try {
            Properties props = new Properties();
            InputStream in = DBUtil.class.getClassLoader().getResourceAsStream("db.properties");
            if (in == null) {
                driver = "com.mysql.cj.jdbc.Driver";
                url = "jdbc:mysql://localhost:3306/netforum?useSSL=false&serverTimezone=Asia/Shanghai&characterEncoding=utf8&allowPublicKeyRetrieval=true";
                username = "root";
                password = "root";
            } else {
                props.load(in);
                driver = props.getProperty("driver", "com.mysql.cj.jdbc.Driver");
                url = props.getProperty("url");
                username = props.getProperty("username", "root");
                password = props.getProperty("password", "root");
                in.close();
            }
            Class.forName(driver);

            dataSource = new BasicDataSource();
            dataSource.setDriverClassName(driver);
            dataSource.setUrl(url);
            dataSource.setUsername(username);
            dataSource.setPassword(password);
            dataSource.setMaxTotal(20);
            dataSource.setMaxIdle(10);
            dataSource.setInitialSize(5);

        } catch (IOException | ClassNotFoundException e) {
            throw new RuntimeException("数据库初始化失败", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }

    public static void close(Connection conn, PreparedStatement ps, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void close(Connection conn, PreparedStatement ps) {
        close(conn, ps, null);
    }
}