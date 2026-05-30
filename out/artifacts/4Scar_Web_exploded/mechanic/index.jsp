<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.25, maximum-scale=5.0, user-scalable=yes">
    <title>维修人员首页 - 汽车4S店售后管理系统</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        html {
            touch-action: manipulation;
            -webkit-text-size-adjust: 100%;
            -ms-text-size-adjust: 100%;
            text-size-adjust: 100%;
        }
        body { 
            font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif; 
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            min-height: 100vh;
            overflow-x: hidden;
            overflow-y: auto;
            -webkit-overflow-scrolling: touch;
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
            color: #11998e;
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
        .stat-card.green { border-top: 4px solid #11998e; }
        .stat-card.orange { border-top: 4px solid #f39c12; }
        .stat-card.blue { border-top: 4px solid #3498db; }
        
        .section-title {
            color: white;
            font-size: 24px;
            margin-bottom: 20px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.2);
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
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
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
            box-shadow: 0 5px 20px rgba(17,153,142,0.4);
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .btn-primary:hover {
            box-shadow: 0 5px 20px rgba(102,126,234,0.4);
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
            color: #11998e;
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
        /* 缩放控制按钮 */
        .zoom-controls {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background: white;
            border-radius: 30px;
            padding: 8px 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            display: flex;
            align-items: center;
            gap: 10px;
            z-index: 1000;
        }
        .zoom-controls button {
            width: 32px;
            height: 32px;
            border: none;
            border-radius: 50%;
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .zoom-controls button:hover {
            transform: scale(1.1);
            box-shadow: 0 3px 10px rgba(17,153,142,0.4);
        }
        .zoom-controls span {
            font-size: 14px;
            font-weight: 600;
            color: #333;
            min-width: 45px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>🔧 汽车4S店售后管理系统 - 维修人员</h1>
        <div class="user-info">
            <span>欢迎, ${sessionScope.user.realName}</span>
            <a href="${pageContext.request.contextPath}/auth?action=profile">👤 个人信息</a>
            <a href="${pageContext.request.contextPath}/auth?action=logout">退出登录</a>
        </div>
    </div>
    <div class="container">
        <div class="nav">
            <a href="${pageContext.request.contextPath}/index.jsp" class="active">📊 首页</a>
            <a href="${pageContext.request.contextPath}/order?action=my">🔧 我的工单</a>
            <a href="${pageContext.request.contextPath}/order?action=pending">📋 待接工单</a>
            <a href="${pageContext.request.contextPath}/message?action=pending">💬 咨询回复</a>
        </div>
        
        <div class="welcome-section">
            <h2>您好，${sessionScope.user.realName}！</h2>
            <p>今天有新的维修任务等待您处理，祝工作顺利！</p>
        </div>
        
        <div class="stats">
            <div class="stat-card orange">
                <div class="stat-icon">⏳</div>
                <h3>${pendingCount}</h3>
                <p>待接工单</p>
            </div>
            <div class="stat-card blue">
                <div class="stat-icon">🔧</div>
                <h3>${processingCount}</h3>
                <p>处理中</p>
            </div>
            <div class="stat-card green">
                <div class="stat-icon">✅</div>
                <h3>${completedCount}</h3>
                <p>已完成</p>
            </div>
        </div>
        
        <div class="quick-actions">
            <a href="${pageContext.request.contextPath}/order?action=pending" class="quick-action">
                <div class="quick-action-icon">📋</div>
                <div class="quick-action-title">查看待接工单</div>
            </a>
            <a href="${pageContext.request.contextPath}/order?action=my" class="quick-action">
                <div class="quick-action-icon">🔧</div>
                <div class="quick-action-title">我的工单</div>
            </a>
            <a href="${pageContext.request.contextPath}/message?action=my" class="quick-action">
                <div class="quick-action-icon">💬</div>
                <div class="quick-action-title">咨询回复</div>
            </a>
        </div>
        
        <h3 class="section-title">⏳ 待接工单</h3>
        <div class="card">
            <c:choose>
                <c:when test="${not empty pendingOrders}">
                    <table>
                        <thead>
                            <tr>
                                <th>订单号</th>
                                <th>车辆信息</th>
                                <th>服务类型</th>
                                <th>预约时间</th>
                                <th>服务内容</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${pendingOrders}">
                            <tr>
                                <td><strong>${order.orderNo}</strong></td>
                                <td>${order.carInfo}</td>
                                <td>${order.serviceType}</td>
                                <td>${order.appointmentTime}</td>
                                <td>${order.serviceContent}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/order?action=accept&id=${order.id}" class="btn">接单</a>
                                </td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <p>暂无待接工单</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <!-- 页面缩放控制 -->
    <div class="zoom-controls">
        <button onclick="zoomOut()" title="缩小">➖</button>
        <span id="zoom-level">100%</span>
        <button onclick="zoomIn()" title="放大">➕</button>
        <button onclick="resetZoom()" title="重置">⟲</button>
    </div>
    
    <script>
        let currentZoom = 100;
        const zoomStep = 10;
        const minZoom = 50;
        const maxZoom = 200;
        
        function updateZoom() {
            document.body.style.zoom = currentZoom + '%';
            document.getElementById('zoom-level').textContent = currentZoom + '%';
        }
        
        function zoomIn() {
            if (currentZoom < maxZoom) {
                currentZoom += zoomStep;
                updateZoom();
            }
        }
        
        function zoomOut() {
            if (currentZoom > minZoom) {
                currentZoom -= zoomStep;
                updateZoom();
            }
        }
        
        function resetZoom() {
            currentZoom = 100;
            updateZoom();
        }
        
        // 键盘快捷键支持
        document.addEventListener('keydown', function(e) {
            if (e.ctrlKey || e.metaKey) {
                if (e.key === '=' || e.key === '+') {
                    e.preventDefault();
                    zoomIn();
                } else if (e.key === '-') {
                    e.preventDefault();
                    zoomOut();
                } else if (e.key === '0') {
                    e.preventDefault();
                    resetZoom();
                }
            }
        });
    </script>
</body>
</html>
