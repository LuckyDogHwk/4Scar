<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.25, maximum-scale=5.0, user-scalable=yes">
    <title>订单管理 - 汽车4S店售后管理系统</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; }
        .header { background: rgba(255,255,255,0.1); backdrop-filter: blur(10px); color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid rgba(255,255,255,0.2); }
        .header h1 { font-size: 22px; font-weight: 600; }
        .header a { color: white; text-decoration: none; opacity: 0.9; transition: opacity 0.3s; }
        .header a:hover { opacity: 1; }
        .container { max-width: 1400px; margin: 0 auto; padding: 20px; }
        .nav { display: flex; gap: 10px; margin-bottom: 25px; flex-wrap: wrap; }
        .nav a { padding: 12px 24px; background: rgba(255,255,255,0.2); color: white; text-decoration: none; border-radius: 25px; backdrop-filter: blur(5px); transition: all 0.3s; font-weight: 500; }
        .nav a:hover, .nav a.active { background: white; color: #667eea; transform: translateY(-2px); box-shadow: 0 4px 15px rgba(0,0,0,0.2); }
        .page-title { color: white; font-size: 28px; margin-bottom: 25px; text-shadow: 0 2px 4px rgba(0,0,0,0.2); }
        .btn { padding: 10px 20px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border: none; border-radius: 10px; cursor: pointer; text-decoration: none; display: inline-block; font-weight: 600; transition: all 0.3s; }
        .btn:hover { transform: translateY(-2px); box-shadow: 0 5px 20px rgba(102,126,234,0.4); }
        .btn-sm { padding: 8px 16px; font-size: 13px; }
        .btn-success { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); }
        .btn-success:hover { box-shadow: 0 5px 20px rgba(17,153,142,0.4); }
        .card { background: white; border-radius: 20px; padding: 25px; margin-bottom: 25px; box-shadow: 0 10px 40px rgba(0,0,0,0.15); }
        .card h2 { margin-bottom: 20px; color: #333; font-size: 20px; }
        .table-container { overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; table-layout: fixed; }
        th, td { padding: 12px 10px; text-align: left; border-bottom: 1px solid #eee; vertical-align: middle; }
        th { background: #f8f9fa; color: #666; font-weight: 600; font-size: 13px; text-transform: uppercase; white-space: nowrap; }
        td { color: #333; word-wrap: break-word; }
        /* 固定列宽 */
        th:nth-child(1), td:nth-child(1) { width: 180px; }
        th:nth-child(2), td:nth-child(2) { width: 80px; }
        th:nth-child(3), td:nth-child(3) { width: 120px; }
        th:nth-child(4), td:nth-child(4) { width: 180px; }
        th:nth-child(5), td:nth-child(5) { width: 80px; }
        th:nth-child(6), td:nth-child(6) { width: 140px; }
        th:nth-child(7), td:nth-child(7) { width: 90px; }
        th:nth-child(8), td:nth-child(8) { width: 80px; }
        th:nth-child(9), td:nth-child(9) { width: 80px; }
        .status-badge { padding: 6px 14px; border-radius: 20px; font-size: 12px; font-weight: 600; display: inline-block; }
        .status-pending { background: #fff3cd; color: #856404; }
        .status-processing { background: #cce5ff; color: #004085; }
        .status-completed { background: #d4edda; color: #155724; }
        .status-cancelled { background: #e2e3e5; color: #383d41; }
        .amount { font-weight: 700; color: #667eea; }
        
        /* 分配维修人员样式 */
        .mechanic-cell { width: 180px; }
        .mechanic-name { font-weight: 600; color: #333; font-size: 13px; }
        .mechanic-pending { color: #ffc107; font-weight: 600; font-size: 13px; }
        .assign-select { 
            padding: 6px 8px; 
            border: 2px solid #667eea; 
            border-radius: 6px; 
            font-size: 12px; 
            background: white;
            cursor: pointer;
            width: 100px;
            flex-shrink: 0;
        }
        .assign-select:focus { outline: none; border-color: #764ba2; }
        .assign-btn { 
            padding: 6px 12px; 
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); 
            color: white; 
            border: none; 
            border-radius: 6px; 
            cursor: pointer; 
            font-weight: 600;
            font-size: 12px;
            transition: all 0.3s;
            flex-shrink: 0;
        }
        .assign-btn:hover { transform: scale(1.05); }
        .assign-container { display: flex; gap: 6px; align-items: center; justify-content: flex-start; }
        
        .action-btns { display: flex; gap: 8px; flex-wrap: wrap; }
        
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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .zoom-controls button:hover { transform: scale(1.1); }
        .zoom-controls span { font-size: 14px; font-weight: 600; color: #333; min-width: 45px; text-align: center; }
    </style>
</head>
<body>
    <div class="header">
        <h1>🔧 汽车4S店售后管理系统 - 管理员</h1>
        <a href="${pageContext.request.contextPath}/auth?action=profile">👤 个人信息</a>
        <a href="${pageContext.request.contextPath}/auth?action=logout">退出登录</a>
    </div>
    <div class="container">
        <div class="nav">
            <a href="${pageContext.request.contextPath}/index.jsp">📊 首页</a>
            <a href="${pageContext.request.contextPath}/user?action=list">👥 用户管理</a>
            <a href="${pageContext.request.contextPath}/car?action=list">🚗 车辆管理</a>
            <a href="${pageContext.request.contextPath}/order?action=list" class="active">📋 订单管理</a>
            <a href="${pageContext.request.contextPath}/part?action=list">🔧 配件管理</a>
            <a href="${pageContext.request.contextPath}/complaint?action=list">📝 投诉处理</a>
            <a href="${pageContext.request.contextPath}/review?action=list">⭐ 评价管理</a>
        </div>
        
        <h2 class="page-title">📋 订单管理</h2>
        
        <div class="card">
            <h2>所有订单</h2>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>订单号</th>
                            <th>车主</th>
                            <th>车辆信息</th>
                            <th>维修人员</th>
                            <th>服务类型</th>
                            <th>预约时间</th>
                            <th>状态</th>
                            <th>金额</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="order" items="${orders}">
                        <tr>
                            <td><strong>${order.orderNo}</strong></td>
                            <td>${order.ownerName}</td>
                            <td>${order.carInfo}</td>
                            <td class="mechanic-cell">
                                <c:choose>
                                    <c:when test="${not empty order.mechanicName}">
                                        <span class="mechanic-name">👤 ${order.mechanicName}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <c:if test="${order.status == 'pending'}">
                                            <div class="assign-container">
                                                <select class="assign-select" id="mechanic-${order.id}">
                                                    <option value="">选择维修人员</option>
                                                    <c:forEach var="mechanic" items="${mechanics}">
                                                        <option value="${mechanic.id}">${mechanic.realName}</option>
                                                    </c:forEach>
                                                </select>
                                                <button class="assign-btn" onclick="assignMechanic(${order.id})">分配</button>
                                            </div>
                                        </c:if>
                                        <c:if test="${order.status != 'pending'}">
                                            <span class="mechanic-pending">待分配</span>
                                        </c:if>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${order.serviceType}</td>
                            <td>${order.appointmentTime}</td>
                            <td>
                                <span class="status-badge status-${order.status}">
                                    <c:choose>
                                        <c:when test="${order.status == 'pending'}">⏳ 待处理</c:when>
                                        <c:when test="${order.status == 'processing'}">🔧 处理中</c:when>
                                        <c:when test="${order.status == 'completed'}">✅ 已完成</c:when>
                                        <c:when test="${order.status == 'cancelled'}">❌ 已取消</c:when>
                                    </c:choose>
                                </span>
                            </td>
                            <td class="amount">¥${order.orderAmount}</td>
                            <td>
                                <div class="action-btns">
                                    <a href="${pageContext.request.contextPath}/order?action=detail&id=${order.id}" class="btn btn-sm">查看</a>
                                </div>
                            </td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
    <!-- 页面缩放控制 -->
    <div class="zoom-controls">
        <button onclick="zoomOut()">➖</button>
        <span id="zoom-level">100%</span>
        <button onclick="zoomIn()">➕</button>
        <button onclick="resetZoom()">⟲</button>
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
            if (currentZoom < maxZoom) { currentZoom += zoomStep; updateZoom(); }
        }
        function zoomOut() {
            if (currentZoom > minZoom) { currentZoom -= zoomStep; updateZoom(); }
        }
        function resetZoom() {
            currentZoom = 100; updateZoom();
        }
        
        function assignMechanic(orderId) {
            const select = document.getElementById('mechanic-' + orderId);
            const mechanicId = select.value;
            if (!mechanicId) {
                alert('请选择维修人员');
                return;
            }
            if (confirm('确定要分配该订单吗？')) {
                window.location.href = '${pageContext.request.contextPath}/order?action=assign&id=' + orderId + '&mechanicId=' + mechanicId;
            }
        }
        
        document.addEventListener('keydown', function(e) {
            if (e.ctrlKey || e.metaKey) {
                if (e.key === '=' || e.key === '+') { e.preventDefault(); zoomIn(); }
                else if (e.key === '-') { e.preventDefault(); zoomOut(); }
                else if (e.key === '0') { e.preventDefault(); resetZoom(); }
            }
        });
    </script>
</body>
</html>