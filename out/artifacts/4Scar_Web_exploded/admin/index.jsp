<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=3.0">
    <title>管理员首页 - 汽车4S店售后管理系统</title>
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
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); 
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
            font-size: 36px;
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
        .stat-card.red { border-top: 4px solid #eb3349; }
        .stat-card.pink { border-top: 4px solid #e91e63; }
        
        .section-title {
            color: white;
            font-size: 24px;
            margin-bottom: 20px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
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
            font-size: 36px;
            margin-bottom: 10px;
        }
        .quick-action-title {
            font-weight: 600;
            font-size: 15px;
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
        .recent-section {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
        }
        @media (max-width: 900px) {
            .recent-section {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>🔧 汽车4S店售后管理系统 - 管理员</h1>
        <div class="user-info">
            <span>欢迎, ${sessionScope.user.realName}</span>
            <a href="${pageContext.request.contextPath}/auth?action=profile">👤 个人信息</a>
        <a href="${pageContext.request.contextPath}/auth?action=logout">退出登录</a>
        </div>
    </div>
    <div class="container">
        <div class="nav">
            <a href="${pageContext.request.contextPath}/index.jsp" class="active">📊 首页</a>
            <a href="${pageContext.request.contextPath}/user?action=list">👥 用户管理</a>
            <a href="${pageContext.request.contextPath}/car?action=list">🚗 车辆管理</a>
            <a href="${pageContext.request.contextPath}/order?action=list">📋 订单管理</a>
            <a href="${pageContext.request.contextPath}/part?action=list">🔧 配件管理</a>
            <a href="${pageContext.request.contextPath}/complaint?action=list">📝 投诉处理</a>
            <a href="${pageContext.request.contextPath}/review?action=list">⭐ 评价管理</a>
        </div>
        
        <div class="welcome-section">
            <h2>管理员控制台</h2>
            <p>欢迎回来，${sessionScope.user.realName}！以下是系统运营概况。</p>
        </div>
        
        <div class="stats">
            <div class="stat-card purple">
                <div class="stat-icon">👥</div>
                <h3>${userCount}</h3>
                <p>用户总数</p>
            </div>
            <div class="stat-card blue">
                <div class="stat-icon">🚗</div>
                <h3>${carCount}</h3>
                <p>车辆总数</p>
            </div>
            <div class="stat-card green">
                <div class="stat-icon">📋</div>
                <h3>${orderCount}</h3>
                <p>订单总数</p>
            </div>
            <div class="stat-card orange">
                <div class="stat-icon">⏳</div>
                <h3>${pendingCount}</h3>
                <p>待处理订单</p>
            </div>
            <div class="stat-card red">
                <div class="stat-icon">📝</div>
                <h3>${complaintCount}</h3>
                <p>客户投诉</p>
            </div>
            <div class="stat-card pink">
                <div class="stat-icon">🔧</div>
                <h3>${partCount}</h3>
                <p>配件种类</p>
            </div>
        </div>
        
        <h3 class="section-title">⚡ 快捷操作</h3>
        <div class="quick-actions">
            <a href="${pageContext.request.contextPath}/user?action=list" class="quick-action">
                <div class="quick-action-icon">👥</div>
                <div class="quick-action-title">用户管理</div>
            </a>
            <a href="${pageContext.request.contextPath}/order?action=list" class="quick-action">
                <div class="quick-action-icon">📋</div>
                <div class="quick-action-title">订单管理</div>
            </a>
            <a href="${pageContext.request.contextPath}/part?action=list" class="quick-action">
                <div class="quick-action-icon">🔧</div>
                <div class="quick-action-title">配件管理</div>
            </a>
            <a href="${pageContext.request.contextPath}/complaint?action=list" class="quick-action">
                <div class="quick-action-icon">📝</div>
                <div class="quick-action-title">投诉处理</div>
            </a>
            <a href="${pageContext.request.contextPath}/review?action=list" class="quick-action">
                <div class="quick-action-icon">⭐</div>
                <div class="quick-action-title">评价管理</div>
            </a>
        </div>
    </div>
</body>
</html>
