<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.car4s.service.*" %>
<%@ page import="com.car4s.entity.*" %>
<%@ page import="java.util.*" %>
<html>
<head><title>调试信息</title>
<style>body{font-family:Arial;padding:20px;} table{border-collapse:collapse;width:100%;} th,td{border:1px solid #ddd;padding:8px;text-align:left;} th{background:#f4f4f4;}</style>
</head>
<body>
<h2>数据库调试信息</h2>
<%
    try {
        CarService carService = new CarService();
        UserService userService = new UserService();
        
        // 显示所有用户
        out.println("<h3>所有用户:</h3>");
        List<User> users = userService.getAllUsers();
        out.println("<table><tr><th>ID</th><th>用户名</th><th>姓名</th><th>角色</th></tr>");
        for (User u : users) {
            out.println("<tr><td>" + u.getId() + "</td><td>" + u.getUsername() + "</td><td>" + u.getRealName() + "</td><td>" + u.getRole() + "</td></tr>");
        }
        out.println("</table>");
        
        // 显示所有车辆
        out.println("<h3>所有车辆:</h3>");
        List<Car> allCars = carService.getAllCars();
        out.println("<p>车辆总数: " + allCars.size() + "</p>");
        out.println("<table><tr><th>ID</th><th>Owner ID</th><th>车牌</th><th>品牌</th><th>型号</th></tr>");
        for (Car c : allCars) {
            out.println("<tr><td>" + c.getId() + "</td><td>" + c.getOwnerId() + "</td><td>" + c.getPlateNumber() + "</td><td>" + c.getBrand() + "</td><td>" + c.getModel() + "</td></tr>");
        }
        out.println("</table>");
        
        // 当前登录用户
        User currentUser = (User) session.getAttribute("user");
        if (currentUser != null) {
            out.println("<h3>当前登录用户:</h3>");
            out.println("<p>用户名: " + currentUser.getUsername() + ", ID: " + currentUser.getId() + ", 角色: " + currentUser.getRole() + "</p>");
            
            // 该用户的车辆
            List<Car> myCars = carService.getCarsByOwnerId(currentUser.getId());
            out.println("<h3>该用户的车辆 (" + myCars.size() + "辆):</h3>");
            out.println("<table><tr><th>车牌</th><th>品牌</th><th>型号</th></tr>");
            for (Car c : myCars) {
                out.println("<tr><td>" + c.getPlateNumber() + "</td><td>" + c.getBrand() + "</td><td>" + c.getModel() + "</td></tr>");
            }
            out.println("</table>");
        } else {
            out.println("<p style='color:red'>未登录</p>");
        }
        
    } catch (Exception e) {
        out.println("<p style='color:red'>错误: " + e.getMessage() + "</p>");
        e.printStackTrace(new java.io.PrintWriter(out));
    }
%>
</body>
</html>
