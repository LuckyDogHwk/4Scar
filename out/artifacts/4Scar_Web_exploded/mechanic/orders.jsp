<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.25, maximum-scale=5.0, user-scalable=yes">
    <title>工单管理 - 汽车4S店售后管理系统</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif; background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); min-height: 100vh; }
        .header { background: rgba(255,255,255,0.1); backdrop-filter: blur(10px); color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid rgba(255,255,255,0.2); }
        .header h1 { font-size: 22px; font-weight: 600; }
        .header .user-info { display: flex; align-items: center; gap: 20px; }
        .header a { color: white; text-decoration: none; opacity: 0.9; transition: opacity 0.3s; }
        .header a:hover { opacity: 1; }
        .container { max-width: 1400px; margin: 0 auto; padding: 20px; }
        .nav { display: flex; gap: 10px; margin-bottom: 25px; flex-wrap: wrap; }
        .nav a { padding: 12px 24px; background: rgba(255,255,255,0.2); color: white; text-decoration: none; border-radius: 25px; backdrop-filter: blur(5px); transition: all 0.3s; font-weight: 500; }
        .nav a:hover, .nav a.active { background: white; color: #11998e; transform: translateY(-2px); box-shadow: 0 4px 15px rgba(0,0,0,0.2); }
        .page-title { color: white; font-size: 28px; margin-bottom: 25px; text-shadow: 0 2px 4px rgba(0,0,0,0.2); }
        .order-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(400px, 1fr)); gap: 25px; }
        .order-card { background: white; border-radius: 20px; overflow: hidden; box-shadow: 0 10px 40px rgba(0,0,0,0.15); transition: all 0.3s; }
        .order-card:hover { transform: translateY(-5px); box-shadow: 0 15px 50px rgba(0,0,0,0.2); }
        .order-header { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); color: white; padding: 15px 20px; display: flex; justify-content: space-between; align-items: center; }
        .order-no { font-weight: 600; font-size: 14px; }
        .status-badge { padding: 6px 14px; border-radius: 20px; font-size: 12px; font-weight: 600; }
        .status-pending { background: #fff3cd; color: #856404; }
        .status-processing { background: #cce5ff; color: #004085; }
        .status-completed { background: #d4edda; color: #155724; }
        .order-body { padding: 20px; }
        .order-info { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; margin-bottom: 15px; }
        .info-item { display: flex; flex-direction: column; }
        .info-label { font-size: 12px; color: #888; margin-bottom: 3px; }
        .info-value { font-size: 14px; color: #333; font-weight: 500; }
        .car-info { display: flex; align-items: center; gap: 15px; padding: 15px; background: #f8f9fa; border-radius: 12px; margin-bottom: 15px; }
        .car-info-icon { font-size: 30px; }
        .car-info-text h4 { font-size: 16px; color: #333; margin-bottom: 3px; }
        .car-info-text p { font-size: 13px; color: #888; }
        .order-actions { display: flex; gap: 10px; }
        .btn { padding: 12px 24px; background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); color: white; border: none; border-radius: 10px; cursor: pointer; text-decoration: none; display: inline-block; font-weight: 600; transition: all 0.3s; text-align: center; }
        .btn:hover { transform: translateY(-2px); box-shadow: 0 5px 20px rgba(17,153,142,0.4); }
        .btn-primary { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
        .btn-primary:hover { box-shadow: 0 5px 20px rgba(102,126,234,0.4); }
        .btn-success { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); }
        .btn-full { width: 100%; }
        .empty-state { text-align: center; padding: 60px 20px; color: white; }
        .empty-state h3 { font-size: 24px; margin-bottom: 10px; }
        .empty-state p { opacity: 0.8; }
        .service-type-tag { display: inline-block; padding: 4px 12px; background: #e8f5e9; color: #2e7d32; border-radius: 15px; font-size: 12px; font-weight: 600; }
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
            <a href="${pageContext.request.contextPath}/index.jsp">📊 首页</a>
            <c:choose>
                <c:when test="${param.action == 'my'}">
                    <a href="${pageContext.request.contextPath}/order?action=my" class="active">🔧 我的工单</a>
                    <a href="${pageContext.request.contextPath}/order?action=pending">📋 待接工单</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/order?action=my">🔧 我的工单</a>
                    <a href="${pageContext.request.contextPath}/order?action=pending" class="active">📋 待接工单</a>
                </c:otherwise>
            </c:choose>
            <a href="${pageContext.request.contextPath}/message?action=pending">💬 咨询回复</a>
        </div>
        
        <c:choose>
            <c:when test="${param.action == 'my'}">
                <h2 class="page-title">🔧 我的工单</h2>
            </c:when>
            <c:otherwise>
                <h2 class="page-title">📋 待接工单</h2>
            </c:otherwise>
        </c:choose>
        
        <c:choose>
            <c:when test="${not empty orders}">
                <div class="order-grid">
                    <c:forEach var="order" items="${orders}">
                        <div class="order-card">
                            <div class="order-header">
                                <span class="order-no">🔧 ${order.orderNo}</span>
                                <span class="status-badge status-${order.status}">
                                    <c:choose>
                                        <c:when test="${order.status == 'pending'}">⏳ 待接单</c:when>
                                        <c:when test="${order.status == 'processing'}">🔧 处理中</c:when>
                                        <c:when test="${order.status == 'completed'}">✅ 已完成</c:when>
                                    </c:choose>
                                </span>
                            </div>
                            <div class="order-body">
                                <div class="car-info">
                                    <div class="car-info-icon">🚗</div>
                                    <div class="car-info-text">
                                        <h4>${order.carInfo}</h4>
                                        <p>车主: ${order.ownerName}</p>
                                    </div>
                                </div>
                                <div class="order-info">
                                    <div class="info-item">
                                        <span class="info-label">服务类型</span>
                                        <span class="service-type-tag">${order.serviceType}</span>
                                    </div>
                                    <div class="info-item">
                                        <span class="info-label">预约时间</span>
                                        <span class="info-value">${order.appointmentTime}</span>
                                    </div>
                                </div>
                                <div class="info-item" style="margin-bottom: 15px;">
                                    <span class="info-label">服务内容</span>
                                    <span class="info-value">${order.serviceContent}</span>
                                </div>
                                <c:choose>
                                    <c:when test="${order.status == 'pending'}">
                                        <div class="order-actions">
                                            <a href="${pageContext.request.contextPath}/order?action=accept&amp;id=${order.id}" 
                                               class="btn btn-success btn-full"
                                               onclick="return confirm('确定要接取这个工单吗？')">
                                                ✅ 立即接单
                                            </a>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="order-actions">
                                            <a href="${pageContext.request.contextPath}/order?action=process&amp;id=${order.id}" class="btn btn-primary btn-full">
                                                🔧 处理工单
                                            </a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <h3>🎉 暂无工单</h3>
                    <p>暂时没有需要处理的工单</p>
                </div>
            </c:otherwise>
        </c:choose>
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