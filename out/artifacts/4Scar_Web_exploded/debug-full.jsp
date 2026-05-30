<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.car4s.util.DBUtil" %>
<%@ page import="com.car4s.dao.CarDao" %>
<%@ page import="com.car4s.dao.UserDao" %>
<%@ page import="com.car4s.entity.Car" %>
<%@ page import="com.car4s.entity.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>完整调试页面</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; background: #f5f5f5; }
        .container { max-width: 1200px; margin: 0 auto; }
        .section { background: white; padding: 20px; margin: 20px 0; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h1 { color: #333; }
        h2 { color: #667eea; border-bottom: 2px solid #667eea; padding-bottom: 10px; }
        .success { color: green; font-weight: bold; }
        .error { color: red; font-weight: bold; }
        table { border-collapse: collapse; width: 100%; margin-top: 15px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background: #667eea; color: white; }
        tr:nth-child(even) { background: #f9f9f9; }
        .highlight { background: #fff3cd !important; }
        .btn { display: inline-block; padding: 10px 20px; background: #667eea; color: white; text-decoration: none; border-radius: 5px; margin: 5px; }
        .btn:hover { background: #5a6fd6; }
        pre { background: #f5f5f5; padding: 15px; border-radius: 5px; overflow-x: auto; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔍 完整调试页面</h1>
        
        <%
            try {
                CarDao carDao = new CarDao();
                UserDao userDao = new UserDao();
                
                out.println("<div class='section'>");
                out.println("<h2>1. 数据库连接状态</h2>");
                out.println("<p class='success'>✅ 数据库连接成功！</p>");
                out.println("</div>");
                
                out.println("<div class='section'>");
                out.println("<h2>2. 所有用户列表</h2>");
                List<User> allUsers = userDao.findAll();
                out.println("<p>总共 " + allUsers.size() + " 个用户</p>");
                
                if (!allUsers.isEmpty()) {
                    out.println("<table>");
                    out.println("<tr><th>ID</th><th>用户名</th><th>姓名</th><th>角色</th><th>状态</th></tr>");
                    for (User u : allUsers) {
                        String highlight = "";
                        if ("owner2".equals(u.getUsername()) || "李四".equals(u.getRealName())) {
                            highlight = "class='highlight'";
                        }
                        out.println("<tr " + highlight + ">");
                        out.println("<td>" + u.getId() + "</td>");
                        out.println("<td>" + u.getUsername() + "</td>");
                        out.println("<td>" + u.getRealName() + "</td>");
                        out.println("<td>" + u.getRole() + "</td>");
                        out.println("<td>" + u.getStatus() + "</td>");
                        out.println("</tr>");
                    }
                    out.println("</table>");
                }
                out.println("</div>");
                
                out.println("<div class='section'>");
                out.println("<h2>3. 所有车辆列表</h2>");
                List<Car> allCars = carDao.findAll();
                out.println("<p>总共 " + allCars.size() + " 辆车</p>");
                
                if (!allCars.isEmpty()) {
                    out.println("<table>");
                    out.println("<tr><th>ID</th><th>车主ID</th><th>车牌号</th><th>品牌</th><th>型号</th><th>图片</th></tr>");
                    for (Car c : allCars) {
                        out.println("<tr>");
                        out.println("<td>" + c.getId() + "</td>");
                        out.println("<td>" + c.getOwnerId() + "</td>");
                        out.println("<td>" + c.getPlateNumber() + "</td>");
                        out.println("<td>" + c.getBrand() + "</td>");
                        out.println("<td>" + c.getModel() + "</td>");
                        out.println("<td>" + (c.getImageUrl() != null ? "有图片" : "无图片") + "</td>");
                        out.println("</tr>");
                    }
                    out.println("</table>");
                }
                out.println("</div>");
                
                out.println("<div class='section'>");
                out.println("<h2>4. 李四(owner2)的车辆查询</h2>");
                
                User lisi = userDao.findByUsername("owner2");
                if (lisi != null) {
                    out.println("<p>找到用户 owner2 (李四)，ID = <strong>" + lisi.getId() + "</strong></p>");
                    
                    List<Car> lisiCars = carDao.findByOwnerId(lisi.getId());
                    out.println("<p>该用户拥有 <strong>" + lisiCars.size() + "</strong> 辆车</p>");
                    
                    if (!lisiCars.isEmpty()) {
                        out.println("<table>");
                        out.println("<tr><th>ID</th><th>车牌号</th><th>品牌</th><th>型号</th><th>图片URL</th></tr>");
                        for (Car c : lisiCars) {
                            out.println("<tr>");
                            out.println("<td>" + c.getId() + "</td>");
                            out.println("<td>" + c.getPlateNumber() + "</td>");
                            out.println("<td>" + c.getBrand() + "</td>");
                            out.println("<td>" + c.getModel() + "</td>");
                            out.println("<td>" + (c.getImageUrl() != null ? c.getImageUrl().substring(0, Math.min(40, c.getImageUrl().length())) + "..." : "null") + "</td>");
                            out.println("</tr>");
                        }
                        out.println("</table>");
                    } else {
                        out.println("<p class='error'>❌ 该用户没有车辆数据！</p>");
                    }
                } else {
                    out.println("<p class='error'>❌ 未找到 owner2 用户！</p>");
                }
                out.println("</div>");
                
                out.println("<div class='section'>");
                out.println("<h2>5. 直接SQL查询验证</h2>");
                try {
                    Connection conn = DBUtil.getConnection();
                    Statement stmt = conn.createStatement();
                    
                    out.println("<h3>查询 owner2 用户：</h3>");
                    ResultSet rs = stmt.executeQuery("SELECT * FROM user WHERE username = 'owner2'");
                    out.println("<pre>");
                    while (rs.next()) {
                        out.println("ID: " + rs.getLong("id") + ", ");
                        out.println("Username: " + rs.getString("username") + ", ");
                        out.println("Real Name: " + rs.getString("real_name") + ", ");
                        out.println("Role: " + rs.getString("role"));
                    }
                    out.println("</pre>");
                    rs.close();
                    
                    out.println("<h3>查询 owner_id=6 的车辆：</h3>");
                    rs = stmt.executeQuery("SELECT * FROM car WHERE owner_id = 6");
                    out.println("<pre>");
                    while (rs.next()) {
                        out.println("ID: " + rs.getLong("id") + ", ");
                        out.println("Plate: " + rs.getString("plate_number") + ", ");
                        out.println("Brand: " + rs.getString("brand") + ", ");
                        out.println("Model: " + rs.getString("model") + "\n");
                    }
                    out.println("</pre>");
                    rs.close();
                    
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    out.println("<p class='error'>SQL Error: " + e.getMessage() + "</p>");
                }
                out.println("</div>");
                
            } catch (Exception e) {
                out.println("<div class='section'>");
                out.println("<h2 class='error'>❌ 错误：</h2>");
                out.println("<pre>" + e.getMessage() + "</pre>");
                e.printStackTrace(new java.io.PrintWriter(out));
                out.println("</div>");
            }
        %>
        
        <div class="section">
            <h2>导航链接</h2>
            <a href="login.jsp" class="btn">登录页面</a>
            <a href="index.jsp" class="btn">首页</a>
            <a href="owner/car-add.jsp" class="btn">添加车辆页面</a>
        </div>
    </div>
</body>
</html>
