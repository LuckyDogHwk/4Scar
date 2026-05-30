<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head><title>数据库连接测试</title>
<style>body{font-family:Arial;padding:20px;} .success{color:green;} .error{color:red;} table{border-collapse:collapse;margin:10px 0;} th,td{border:1px solid #ddd;padding:8px;}</style>
</head>
<body>
<h2>数据库连接测试</h2>
<%
    String url = "jdbc:mysql://localhost:3306/car_4s?useUnicode=true&characterEncoding=utf-8&useSSL=false&serverTimezone=Asia/Shanghai&allowPublicKeyRetrieval=true";
    String user = "root";
    String password = "123456";
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, user, password);
        out.println("<p class='success'>✅ 数据库连接成功!</p>");
        
        // 检查用户表
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM user");
        rs.next();
        int userCount = rs.getInt(1);
        out.println("<p>用户数量: " + userCount + "</p>");
        
        // 检查车辆表
        rs = stmt.executeQuery("SELECT COUNT(*) FROM car");
        rs.next();
        int carCount = rs.getInt(1);
        out.println("<p>车辆数量: " + carCount + "</p>");
        
        if (userCount == 0 || carCount == 0) {
            out.println("<p class='error'>⚠️ 数据库中没有数据！请先导入 init.sql 文件！</p>");
        } else {
            // 显示所有用户
            out.println("<h3>所有用户:</h3>");
            rs = stmt.executeQuery("SELECT id, username, real_name, role FROM user ORDER BY id");
            out.println("<table><tr><th>ID</th><th>用户名</th><th>姓名</th><th>角色</th></tr>");
            while (rs.next()) {
                out.println("<tr><td>" + rs.getLong("id") + "</td><td>" + rs.getString("username") + "</td><td>" + rs.getString("real_name") + "</td><td>" + rs.getString("role") + "</td></tr>");
            }
            out.println("</table>");
            
            // 显示owner2 (李四) 的用户ID
            rs = stmt.executeQuery("SELECT id, username, real_name FROM user WHERE username='owner2'");
            if (rs.next()) {
                long ownerId = rs.getLong("id");
                out.println("<h3>李四 (owner2) 的信息:</h3>");
                out.println("<p>用户名: " + rs.getString("username") + "</p>");
                out.println("<p>姓名: " + rs.getString("real_name") + "</p>");
                out.println("<p>ID: " + ownerId + "</p>");
                
                // 显示该用户的车辆
                PreparedStatement ps = conn.prepareStatement("SELECT plate_number, brand, model FROM car WHERE owner_id = ?");
                ps.setLong(1, ownerId);
                ResultSet carRs = ps.executeQuery();
                out.println("<h3>李四的车辆:</h3>");
                out.println("<table><tr><th>车牌</th><th>品牌</th><th>型号</th></tr>");
                int count = 0;
                while (carRs.next()) {
                    count++;
                    out.println("<tr><td>" + carRs.getString("plate_number") + "</td><td>" + carRs.getString("brand") + "</td><td>" + carRs.getString("model") + "</td></tr>");
                }
                out.println("</table>");
                out.println("<p>共 " + count + " 辆车</p>");
                
                if (count == 0) {
                    out.println("<p class='error'>李四没有车辆数据！请检查数据库中的数据。</p>");
                }
            } else {
                out.println("<p class='error'>找不到 owner2 (李四) 用户!</p>");
            }
        }
        
        conn.close();
    } catch (Exception e) {
        out.println("<p class='error'>❌ 错误: " + e.getMessage() + "</p>");
        e.printStackTrace(new java.io.PrintWriter(out));
    }
%>
</body>
</html>
