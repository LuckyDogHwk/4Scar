<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>订单详情 - 汽车4S店售后管理系统</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, sans-serif; background: #f5f5f5; }
        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 15px 30px; }
        .header h1 { font-size: 20px; }
        .header a { color: white; text-decoration: none; float: right; }
        .container { max-width: 800px; margin: 20px auto; padding: 0 20px; }
        .card { background: white; border-radius: 10px; padding: 30px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .card h2 { margin-bottom: 20px; color: #333; }
        .info-row { display: flex; margin-bottom: 15px; border-bottom: 1px solid #eee; padding-bottom: 10px; }
        .info-row .label { width: 120px; font-weight: bold; color: #666; }
        .info-row .value { flex: 1; }
        .btn { padding: 10px 20px; background: #667eea; color: white; border: none; border-radius: 5px; cursor: pointer; text-decoration: none; display: inline-block; }
    </style>
</head>
<body>
    <div class="header">
        <h1>订单详情 <a href="javascript:history.back()">返回</a></h1>
    </div>
    <div class="container">
        <div class="card">
            <h2>订单信息</h2>
            <div class="info-row"><span class="label">订单号:</span><span class="value">${order.orderNo}</span></div>
            <div class="info-row"><span class="label">车主:</span><span class="value">${order.ownerName}</span></div>
            <div class="info-row"><span class="label">车辆信息:</span><span class="value">${order.carInfo}</span></div>
            <div class="info-row"><span class="label">维修人员:</span><span class="value">${order.mechanicName}</span></div>
            <div class="info-row"><span class="label">服务类型:</span><span class="value">${order.serviceType}</span></div>
            <div class="info-row"><span class="label">预约时间:</span><span class="value">${order.appointmentTime}</span></div>
            <div class="info-row"><span class="label">服务内容:</span><span class="value">${order.serviceContent}</span></div>
            <div class="info-row"><span class="label">订单金额:</span><span class="value">${order.orderAmount}</span></div>
            <div class="info-row"><span class="label">状态:</span><span class="value">${order.status}</span></div>
            <div class="info-row"><span class="label">创建时间:</span><span class="value">${order.createTime}</span></div>
        </div>
    </div>
</body>
</html>
