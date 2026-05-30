<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.car4s.util.DBUtil" %>
<%@ page import="com.car4s.dao.CarDao" %>
<%@ page import="com.car4s.entity.Car" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>数据库调试页面</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        .success { color: green; }
        .error { color: red; }
        table { border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 10px; }
    </style>
</head>
<body>
    <h1>🚗 数据库调试页面</h1>
    
    <%
        try {
            CarDao carDao = new CarDao();
            
            out.println("<h2 class='success'>✅ 数据库连接成功！</h2>");
            
            out.println("<h3>所有车辆列表：</h3>");
            List<Car> allCars = carDao.findAll();
            out.println("<p>总共 " + allCars.size() + " 辆车</p>");
            
            if (!allCars.isEmpty()) {
                out.println("<table>");
                out.println("<tr><th>ID</th><th>车主ID</th><th>车牌号</th><th>品牌</th><th>型号</th><th>图片URL</th></tr>");
                for (Car c : allCars) {
                    out.println("<tr>");
                    out.println("<td>" + c.getId() + "</td>");
                    out.println("<td>" + c.getOwnerId() + "</td>");
                    out.println("<td>" + c.getPlateNumber() + "</td>");
                    out.println("<td>" + c.getBrand() + "</td>");
                    out.println("<td>" + c.getModel() + "</td>");
                    out.println("<td>" + (c.getImageUrl() != null ? c.getImageUrl().substring(0, Math.min(50, c.getImageUrl().length())) + "..." : "null") + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
            }
            
            out.println("<h3>测试查询车主ID为2的车辆（李四）：</h3>");
            List<Car> ownerCars = carDao.findByOwnerId(2L);
            out.println("<p>车主ID=2 有 " + ownerCars.size() + " 辆车</p>");
            
            if (!ownerCars.isEmpty()) {
                out.println("<table>");
                out.println("<tr><th>ID</th><th>车牌号</th><th>品牌</th><th>型号</th></tr>");
                for (Car c : ownerCars) {
                    out.println("<tr>");
                    out.println("<td>" + c.getId() + "</td>");
                    out.println("<td>" + c.getPlateNumber() + "</td>");
                    out.println("<td>" + c.getBrand() + "</td>");
                    out.println("<td>" + c.getModel() + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
            }
            
        } catch (Exception e) {
            out.println("<h2 class='error'>❌ 错误：</h2>");
            out.println("<pre>" + e.getMessage() + "</pre>");
            e.printStackTrace(new java.io.PrintWriter(out));
        }
    %>
    
    <p><a href="index.jsp">返回首页</a></p>
</body>
</html>
