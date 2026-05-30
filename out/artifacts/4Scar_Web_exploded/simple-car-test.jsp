<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.car4s.entity.Car" %>
<%@ page import="com.car4s.service.CarService" %>
<%@ page import="java.util.List" %>
<html>
<head><title>简单车辆测试</title>
<style>body{font-family:Arial;padding:20px;} .success{color:green;} .error{color:red;} table{border-collapse:collapse;margin:10px 0;} th,td{border:1px solid #ddd;padding:8px;}</style>
</head>
<body>
<h2>简单车辆测试</h2>
<%
    try {
        CarService carService = new CarService();
        out.println("<p class='success'>✅ CarService 初始化成功!</p>");
        
        // 获取所有车辆
        List<Car> allCars = carService.getAllCars();
        out.println("<h3>所有车辆 (" + allCars.size() + " 辆):</h3>");
        
        if (allCars.isEmpty()) {
            out.println("<p class='error'>❌ 没有找到车辆!</p>");
        } else {
            out.println("<table><tr><th>ID</th><th>Owner ID</th><th>车牌</th><th>品牌</th><th>型号</th><th>图片URL</th></tr>");
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
        
    } catch (Exception e) {
        out.println("<p class='error'>❌ 错误: " + e.getMessage() + "</p>");
        e.printStackTrace(new java.io.PrintWriter(out));
    }
%>
</body>
</html>
