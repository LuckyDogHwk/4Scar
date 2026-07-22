<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=3.0">
    <title>车主首页 - 汽车4S店售后管理系统</title>
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
        .welcome-section {
            color: white;
            margin-bottom: 30px;
        }
        .welcome-section h2 {
            font-size: 32px;
            margin-bottom: 10px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }
        .welcome-section p {
            opacity: 0.9;
            font-size: 16px;
        }
        .stats { 
            display: grid; 
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); 
            gap: 20px; 
            margin-bottom: 30px; 
        }
        .stat-card { 
            background: white; 
            border-radius: 20px; 
            padding: 25px; 
            text-align: center;
            box-shadow: 0 10px 40px rgba(0,0,0,0.15);
            transition: all 0.3s;
        }
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 50px rgba(0,0,0,0.2);
        }
        .stat-icon {
            font-size: 40px;
            margin-bottom: 10px;
        }
        .stat-card h3 { 
            color: #333; 
            font-size: 36px; 
            margin-bottom: 5px; 
            font-weight: 700;
        }
        .stat-card p { 
            color: #888; 
            font-size: 14px;
        }
        .stat-card.purple { border-top: 4px solid #667eea; }
        .stat-card.green { border-top: 4px solid #11998e; }
        .stat-card.orange { border-top: 4px solid #f39c12; }
        .stat-card.blue { border-top: 4px solid #3498db; }
        
        .section-title {
            color: white;
            font-size: 24px;
            margin-bottom: 20px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.2);
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .card { 
            background: white; 
            border-radius: 20px; 
            padding: 25px; 
            margin-bottom: 25px; 
            box-shadow: 0 10px 40px rgba(0,0,0,0.15); 
        }
        .card h2 { 
            margin-bottom: 20px; 
            color: #333;
            font-size: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        table { 
            width: 100%; 
            border-collapse: collapse; 
        }
        th, td { 
            padding: 15px; 
            text-align: left; 
            border-bottom: 1px solid #eee; 
        }
        th { 
            background: #f8f9fa; 
            color: #666;
            font-weight: 600;
            font-size: 13px;
            text-transform: uppercase;
        }
        td {
            color: #333;
        }
        .btn { 
            padding: 10px 20px; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white; 
            border: none; 
            border-radius: 10px; 
            cursor: pointer; 
            text-decoration: none; 
            display: inline-block;
            font-weight: 600;
            transition: all 0.3s;
        }
        .btn:hover { 
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102,126,234,0.4);
        }
        .status-badge {
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }
        .status-pending { 
            background: #fff3cd;
            color: #856404; 
        }
        .status-processing { 
            background: #cce5ff;
            color: #004085; 
        }
        .status-completed { 
            background: #d4edda;
            color: #155724; 
        }
        .status-cancelled { 
            background: #e2e3e5;
            color: #383d41; 
        }
        .my-cars {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .car-mini-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            display: flex;
            transition: all 0.3s;
        }
        .car-mini-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }
        .car-mini-img {
            width: 100px;
            height: 100px;
            object-fit: cover;
        }
        .car-mini-info {
            padding: 15px;
            flex: 1;
        }
        .car-mini-brand {
            font-size: 18px;
            font-weight: 700;
            color: #333;
        }
        .car-mini-model {
            font-size: 13px;
            color: #888;
            margin-bottom: 8px;
        }
        .car-mini-plate {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 4px 10px;
            border-radius: 15px;
            font-size: 12px;
            display: inline-block;
        }
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-bottom: 30px;
        }
        .quick-action {
            background: white;
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            text-decoration: none;
            color: #333;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            transition: all 0.3s;
        }
        .quick-action:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            color: #667eea;
        }
        .quick-action-icon {
            font-size: 40px;
            margin-bottom: 10px;
        }
        .quick-action-title {
            font-weight: 600;
            font-size: 16px;
        }
        .empty-state {
            text-align: center;
            padding: 40px 20px;
            color: #888;
        }
        .amount {
            font-weight: 700;
            color: #667eea;
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
            <a href="${pageContext.request.contextPath}/index.jsp" class="active">📊 首页</a>
            <a href="${pageContext.request.contextPath}/car?action=my">🚗 车辆管理</a>
            <a href="${pageContext.request.contextPath}/order?action=my">📅 预约服务</a>
            <a href="${pageContext.request.contextPath}/message?action=my">💬 咨询留言</a>
            <a href="${pageContext.request.contextPath}/complaint?action=my">📝 意见反馈</a>
            <a href="${pageContext.request.contextPath}/review?action=my">⭐ 我的评价</a>
        </div>
        
        <div class="welcome-section">
            <h2>您好，${sessionScope.user.realName}！</h2>
            <p>欢迎使用汽车4S店售后管理系统，祝您用车愉快！</p>
        </div>
        
        <div class="stats">
            <div class="stat-card purple">
                <div class="stat-icon">🚗</div>
                <h3>${carCount}</h3>
                <p>我的车辆</p>
            </div>
            <div class="stat-card green">
                <div class="stat-icon">📋</div>
                <h3>${orderCount}</h3>
                <p>服务工单</p>
            </div>
            <div class="stat-card orange">
                <div class="stat-icon">💬</div>
                <h3>${messageCount}</h3>
                <p>咨询留言</p>
            </div>
            <div class="stat-card blue">
                <div class="stat-icon">⭐</div>
                <h3>${reviewCount}</h3>
                <p>我的评价</p>
            </div>
        </div>
        
        <div class="quick-actions">
            <a href="${pageContext.request.contextPath}/owner/car-add.jsp" class="quick-action">
                <div class="quick-action-icon">➕</div>
                <div class="quick-action-title">添加车辆</div>
            </a>
            <a href="${pageContext.request.contextPath}/order?action=add" class="quick-action">
                <div class="quick-action-icon">📅</div>
                <div class="quick-action-title">预约服务</div>
            </a>
            <a href="${pageContext.request.contextPath}/message?action=my" class="quick-action">
                <div class="quick-action-icon">💬</div>
                <div class="quick-action-title">在线咨询</div>
            </a>
            <a href="${pageContext.request.contextPath}/complaint?action=my" class="quick-action">
                <div class="quick-action-icon">📝</div>
                <div class="quick-action-title">意见反馈</div>
            </a>
        </div>
        
        <h3 class="section-title">🚗 我的车辆</h3>
        <c:choose>
            <c:when test="${not empty myCars}">
                <div class="my-cars">
                    <c:forEach var="car" items="${myCars}">
                        <div class="car-mini-card">
                            <img src="${not empty car.imageUrl ? car.imageUrl : ''}" 
                                 alt="${car.brand}" 
                                 class="car-mini-img"
                                 onerror="this.src=''">
                            <div class="car-mini-info">
                                <div class="car-mini-brand">${car.brand}</div>
                                <div class="car-mini-model">${car.model}</div>
                                <span class="car-mini-plate">${car.plateNumber}</span>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card">
                    <div class="empty-state">
                        <p>您还没有添加车辆，<a href="${pageContext.request.contextPath}/owner/car-add.jsp" style="color: #667eea;">立即添加</a></p>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
        
        <h3 class="section-title">📋 最近工单</h3>
        <div class="card">
            <c:choose>
                <c:when test="${not empty recentOrders}">
                    <table>
                        <thead>
                            <tr>
                                <th>工单号</th>
                                <th>车辆信息</th>
                                <th>服务类型</th>
                                <th>预约时间</th>
                                <th>状态</th>
                                <th>金额</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${recentOrders}">
                            <tr>
                                <td><strong>${order.orderNo}</strong></td>
                                <td>${order.carInfo}</td>
                                <td>${order.serviceType}</td>
                                <td>${order.appointmentTime}</td>
                                <td>
                                    <span class="status-badge status-${order.status}">
                                        <c:choose>
                                            <c:when test="${order.status == 'pending'}">待处理</c:when>
                                            <c:when test="${order.status == 'processing'}">处理中</c:when>
                                            <c:when test="${order.status == 'completed'}">已完成</c:when>
                                            <c:when test="${order.status == 'cancelled'}">已取消</c:when>
                                        </c:choose>
                                    </span>
                                </td>
                                <td class="amount">¥${order.orderAmount}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/order?action=detail&id=${order.id}" class="btn">查看</a>
                                </td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <p>暂无工单记录，<a href="${pageContext.request.contextPath}/order?action=add" style="color: #667eea;">立即预约服务</a></p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
