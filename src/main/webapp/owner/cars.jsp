<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=3.0">
    <title>车辆管理 - 汽车4S店售后管理系统</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        .header { 
            background: rgba(255,255,255,0.1); 
            backdrop-filter: blur(10px);
            color: white; 
            padding: 15px 30px; 
            display: flex; 
            justify-content: space-between; 
            align-items: center;
            border-bottom: 1px solid rgba(255,255,255,0.2);
        }
        .header h1 { font-size: 22px; font-weight: 600; }
        .header .user-info { display: flex; align-items: center; gap: 20px; }
        .header a { color: white; text-decoration: none; opacity: 0.9; transition: opacity 0.3s; }
        .header a:hover { opacity: 1; }
        .container { max-width: 1400px; margin: 0 auto; padding: 20px; }
        .nav { 
            display: flex; 
            gap: 10px; 
            margin-bottom: 25px;
            flex-wrap: wrap;
        }
        .nav a { 
            padding: 12px 24px; 
            background: rgba(255,255,255,0.2); 
            color: white; 
            text-decoration: none; 
            border-radius: 25px;
            backdrop-filter: blur(5px);
            transition: all 0.3s;
            font-weight: 500;
        }
        .nav a:hover, .nav a.active { 
            background: white; 
            color: #667eea;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }
        .page-title {
            color: white;
            font-size: 28px;
            margin-bottom: 25px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }
        .car-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
        }
        .car-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 40px rgba(0,0,0,0.15);
            transition: all 0.3s;
        }
        .car-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 50px rgba(0,0,0,0.25);
        }
        .car-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        }
        .car-content { padding: 20px; }
        .car-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 15px;
        }
        .car-brand {
            font-size: 22px;
            font-weight: 700;
            color: #333;
        }
        .car-model {
            font-size: 14px;
            color: #888;
            margin-top: 5px;
        }
        .car-plate {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }
        .car-info {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
            margin-bottom: 20px;
        }
        .info-item {
            display: flex;
            flex-direction: column;
        }
        .info-label {
            font-size: 12px;
            color: #999;
            margin-bottom: 3px;
        }
        .info-value {
            font-size: 14px;
            color: #333;
            font-weight: 500;
        }
        .car-actions {
            display: flex;
            gap: 10px;
            padding-top: 15px;
            border-top: 1px solid #eee;
        }
        .btn { 
            flex: 1;
            padding: 12px 20px; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white; 
            border: none; 
            border-radius: 10px; 
            cursor: pointer; 
            text-decoration: none; 
            text-align: center;
            font-weight: 600;
            transition: all 0.3s;
        }
        .btn:hover { 
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102,126,234,0.4);
        }
        .btn-edit { 
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
        }
        .btn-edit:hover {
            box-shadow: 0 5px 20px rgba(17,153,142,0.4);
        }
        .btn-danger { 
            background: linear-gradient(135deg, #eb3349 0%, #f45c43 100%);
        }
        .btn-danger:hover {
            box-shadow: 0 5px 20px rgba(235,51,73,0.4);
        }
        .btn-add {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 14px 28px;
            background: white;
            color: #667eea;
            font-size: 16px;
            margin-bottom: 20px;
        }
        .btn-add:hover {
            color: #764ba2;
        }
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: white;
        }
        .empty-state h3 {
            font-size: 24px;
            margin-bottom: 10px;
        }
        .empty-state p {
            opacity: 0.8;
            margin-bottom: 20px;
        }
        .maintenance-alert {
            background: #fff3cd;
            color: #856404;
            padding: 8px 12px;
            border-radius: 8px;
            font-size: 12px;
            margin-top: 10px;
            display: flex;
            align-items: center;
            gap: 6px;
        }
        .maintenance-alert.urgent {
            background: #f8d7da;
            color: #721c24;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>🚗 汽车4S店售后管理系统</h1>
        <div class="user-info">
            <span>欢迎, ${sessionScope.user.realName}</span>
            <a href="${pageContext.request.contextPath}/auth?action=profile">👤 个人信息</a>
            <a href="${pageContext.request.contextPath}/auth?action=logout">退出登录</a>
        </div>
    </div>
    <div class="container">
        <div class="nav">
            <a href="${pageContext.request.contextPath}/index.jsp">📊 首页</a>
            <a href="${pageContext.request.contextPath}/car?action=my" class="active">🚗 车辆管理</a>
            <a href="${pageContext.request.contextPath}/order?action=my">📅 预约服务</a>
            <a href="${pageContext.request.contextPath}/message?action=my">💬 咨询留言</a>
            <a href="${pageContext.request.contextPath}/complaint?action=my">📝 意见反馈</a>
            <a href="${pageContext.request.contextPath}/review?action=my">⭐ 我的评价</a>
        </div>
        
        <h2 class="page-title">我的车辆</h2>
        <a href="${pageContext.request.contextPath}/owner/car-add.jsp" class="btn btn-add">➕ 添加车辆</a>
        
        <c:choose>
            <c:when test="${not empty cars}">
                <div class="car-grid">
                    <c:forEach var="car" items="${cars}">
                        <div class="car-card">
                            <img src="${not empty car.imageUrl ? car.imageUrl : 'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=400&q=80'}" 
                                 alt="${car.brand} ${car.model}" 
                                 class="car-image"
                                 onerror="this.src='https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=400&q=80'">
                            <div class="car-content">
                                <div class="car-header">
                                    <div>
                                        <div class="car-brand">${car.brand}</div>
                                        <div class="car-model">${car.model}</div>
                                    </div>
                                    <span class="car-plate">${car.plateNumber}</span>
                                </div>
                                <div class="car-info">
                                    <div class="info-item">
                                        <span class="info-label">购买日期</span>
                                        <span class="info-value">${car.purchaseDate}</span>
                                    </div>
                                    <div class="info-item">
                                        <span class="info-label">VIN码</span>
                                        <span class="info-value">${car.vin}</span>
                                    </div>
                                    <div class="info-item">
                                        <span class="info-label">保养周期</span>
                                        <span class="info-value">${car.maintenanceCycle}公里</span>
                                    </div>
                                    <div class="info-item">
                                        <span class="info-label">上次保养</span>
                                        <span class="info-value">${not empty car.lastMaintenanceDate ? car.lastMaintenanceDate : '暂无记录'}</span>
                                    </div>
                                </div>
                                <div class="car-actions">
                                    <a href="${pageContext.request.contextPath}/car?action=edit&id=${car.id}" class="btn btn-edit">编辑</a>
                                    <a href="${pageContext.request.contextPath}/car?action=delete&id=${car.id}" 
                                       class="btn btn-danger" 
                                       onclick="return confirm('确定要删除这辆车吗？')">删除</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <h3>暂无车辆信息</h3>
                    <p>您还没有添加任何车辆，点击上方按钮添加您的第一辆车</p>
                    <a href="${pageContext.request.contextPath}/owner/car-add.jsp" class="btn btn-add">➕ 添加车辆</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
