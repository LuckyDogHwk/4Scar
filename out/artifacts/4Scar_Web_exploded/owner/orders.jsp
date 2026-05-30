<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.25, maximum-scale=5.0, user-scalable=yes">
    <title>我的预约 - 汽车4S店售后管理系统</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; }
        .header { background: rgba(255,255,255,0.1); backdrop-filter: blur(10px); color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid rgba(255,255,255,0.2); }
        .header h1 { font-size: 22px; font-weight: 600; }
        .header .user-info { display: flex; align-items: center; gap: 20px; }
        .header a { color: white; text-decoration: none; opacity: 0.9; transition: opacity 0.3s; }
        .header a:hover { opacity: 1; }
        .container { max-width: 1400px; margin: 0 auto; padding: 20px; }
        .nav { display: flex; gap: 10px; margin-bottom: 25px; flex-wrap: wrap; }
        .nav a { padding: 12px 24px; background: rgba(255,255,255,0.2); color: white; text-decoration: none; border-radius: 25px; backdrop-filter: blur(5px); transition: all 0.3s; font-weight: 500; }
        .nav a:hover, .nav a.active { background: white; color: #667eea; transform: translateY(-2px); box-shadow: 0 4px 15px rgba(0,0,0,0.2); }
        .page-title { color: white; font-size: 28px; margin-bottom: 25px; text-shadow: 0 2px 4px rgba(0,0,0,0.2); }
        .card { background: white; border-radius: 20px; padding: 25px; margin-bottom: 25px; box-shadow: 0 10px 40px rgba(0,0,0,0.15); }
        .card-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .card-header h2 { color: #333; font-size: 20px; }
        .btn { padding: 12px 24px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border: none; border-radius: 10px; cursor: pointer; text-decoration: none; display: inline-block; font-weight: 600; transition: all 0.3s; }
        .btn:hover { transform: translateY(-2px); box-shadow: 0 5px 20px rgba(102,126,234,0.4); }
        .btn-success { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); }
        .btn-success:hover { box-shadow: 0 5px 20px rgba(17,153,142,0.4); }
        .btn-danger { background: linear-gradient(135deg, #eb3349 0%, #f45c43 100%); }
        .btn-danger:hover { box-shadow: 0 5px 20px rgba(235,51,73,0.4); }
        .btn-sm { padding: 8px 16px; font-size: 13px; }
        .order-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(380px, 1fr)); gap: 25px; }
        .order-card { background: #f8f9fa; border-radius: 15px; overflow: hidden; transition: all 0.3s; border: 1px solid #eee; }
        .order-card:hover { transform: translateY(-3px); box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
        .order-card-header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 15px 20px; display: flex; justify-content: space-between; align-items: center; }
        .order-no { font-weight: 600; font-size: 14px; }
        .status-badge { padding: 6px 14px; border-radius: 20px; font-size: 12px; font-weight: 600; }
        .status-pending { background: #fff3cd; color: #856404; }
        .status-processing { background: #cce5ff; color: #004085; }
        .status-completed { background: #d4edda; color: #155724; }
        .status-cancelled { background: #e2e3e5; color: #383d41; }
        .order-card-body { padding: 20px; }
        .order-info { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; margin-bottom: 15px; }
        .info-item { display: flex; flex-direction: column; }
        .info-label { font-size: 12px; color: #888; margin-bottom: 3px; }
        .info-value { font-size: 14px; color: #333; font-weight: 500; }
        .order-amount { font-size: 20px; font-weight: 700; color: #667eea; text-align: right; padding-top: 10px; border-top: 1px solid #eee; }
        .order-actions { display: flex; gap: 10px; margin-top: 15px; flex-wrap: wrap; }
        .order-actions .btn { flex: 1; text-align: center; min-width: 80px; }
        
        /* 评价表单 */
        .review-form { display: none; padding: 15px; background: #fff3cd; border-top: 2px solid #ffc107; }
        .review-form.active { display: block; }
        .form-group { margin-bottom: 12px; }
        .form-group label { display: block; font-size: 13px; font-weight: 600; color: #333; margin-bottom: 6px; }
        .star-rating { display: flex; gap: 5px; }
        .star-rating .star { font-size: 28px; color: #ddd; cursor: pointer; transition: color 0.2s; user-select: none; }
        .star-rating .star.active { color: #ffc107; }
        .star-rating .star:hover { color: #ffc107; }
        .form-group textarea { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 8px; font-size: 13px; resize: vertical; min-height: 60px; font-family: inherit; }
        .form-group textarea:focus { outline: none; border-color: #667eea; }
        .form-actions { display: flex; gap: 10px; justify-content: flex-end; }
        .form-actions .btn { padding: 8px 16px; font-size: 13px; }
        .reviewed-badge { background: #d4edda; color: #155724; padding: 6px 12px; border-radius: 15px; font-size: 12px; font-weight: 600; }
        
        .empty-state { text-align: center; padding: 60px 20px; color: #888; }
        .empty-state h3 { font-size: 20px; margin-bottom: 10px; }
        
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
            <a href="${pageContext.request.contextPath}/car?action=my">🚗 车辆管理</a>
            <a href="${pageContext.request.contextPath}/order?action=my" class="active">📅 预约服务</a>
            <a href="${pageContext.request.contextPath}/message?action=my">💬 咨询留言</a>
            <a href="${pageContext.request.contextPath}/complaint?action=my">📝 意见反馈</a>
            <a href="${pageContext.request.contextPath}/review?action=my">⭐ 我的评价</a>
        </div>
        
        <h2 class="page-title">📋 我的预约</h2>
        
        <div class="card">
            <div class="card-header">
                <h2>预约列表</h2>
                <a href="${pageContext.request.contextPath}/order?action=add" class="btn btn-success">➕ 预约服务</a>
            </div>
            
            <c:choose>
                <c:when test="${not empty orders}">
                    <div class="order-grid">
                        <c:forEach var="order" items="${orders}">
                            <div class="order-card">
                                <div class="order-card-header">
                                    <span class="order-no">🔧 ${order.orderNo}</span>
                                    <span class="status-badge status-${order.status}">
                                        <c:choose>
                                            <c:when test="${order.status == 'pending'}">⏳ 待处理</c:when>
                                            <c:when test="${order.status == 'processing'}">🔧 处理中</c:when>
                                            <c:when test="${order.status == 'completed'}">✅ 已完成</c:when>
                                            <c:when test="${order.status == 'cancelled'}">❌ 已取消</c:when>
                                        </c:choose>
                                    </span>
                                </div>
                                <div class="order-card-body">
                                    <div class="order-info">
                                        <div class="info-item">
                                            <span class="info-label">车辆信息</span>
                                            <span class="info-value">${order.carInfo}</span>
                                        </div>
                                        <div class="info-item">
                                            <span class="info-label">服务类型</span>
                                            <span class="info-value">${order.serviceType}</span>
                                        </div>
                                        <div class="info-item">
                                            <span class="info-label">预约时间</span>
                                            <span class="info-value">${order.appointmentTime}</span>
                                        </div>
                                        <div class="info-item">
                                            <span class="info-label">服务内容</span>
                                            <span class="info-value">${order.serviceContent}</span>
                                        </div>
                                    </div>
                                    <div class="order-amount">¥${order.orderAmount}</div>
                                    <div class="order-actions">
                                        <c:if test="${order.status == 'completed' && !order.reviewed}">
                                            <button class="btn btn-success btn-sm" onclick="toggleReviewForm(${order.id})">⭐ 发表评价</button>
                                        </c:if>
                                        <c:if test="${order.status == 'completed' && order.reviewed}">
                                            <span class="reviewed-badge">✅ 已评价</span>
                                        </c:if>
                                        <c:if test="${order.status == 'pending'}">
                                            <a href="${pageContext.request.contextPath}/order?action=cancel&id=${order.id}" class="btn btn-danger btn-sm" onclick="return confirm('确定要取消这个预约吗？')">取消预约</a>
                                        </c:if>
                                    </div>
                                </div>
                                <!-- 评价表单 -->
                                <c:if test="${order.status == 'completed' && !order.reviewed}">
                                <div class="review-form" id="review-form-${order.id}">
                                    <form action="${pageContext.request.contextPath}/review" method="post" id="form-${order.id}">
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="orderId" value="${order.id}">
                                        <input type="hidden" name="rating" id="rating-${order.id}" value="0" required>
                                        <div class="form-group">
                                            <label>请选择评分（点击星星）</label>
                                            <div class="star-rating" id="stars-${order.id}">
                                                <span class="star" data-value="1" onclick="setRating(${order.id}, 1)">★</span>
                                                <span class="star" data-value="2" onclick="setRating(${order.id}, 2)">★</span>
                                                <span class="star" data-value="3" onclick="setRating(${order.id}, 3)">★</span>
                                                <span class="star" data-value="4" onclick="setRating(${order.id}, 4)">★</span>
                                                <span class="star" data-value="5" onclick="setRating(${order.id}, 5)">★</span>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <textarea name="content" placeholder="请分享您的服务体验..." required></textarea>
                                        </div>
                                        <div class="form-actions">
                                            <button type="button" class="btn" style="background:#ccc;" onclick="toggleReviewForm(${order.id})">取消</button>
                                            <button type="submit" class="btn btn-success">提交评价</button>
                                        </div>
                                    </form>
                                </div>
                                </c:if>
                                <c:if test="${order.status == 'completed' && order.reviewed}">
                                    <div style="padding: 15px; background: #d4edda; border-top: 2px solid #28a745; text-align: center;">
                                        <span class="reviewed-badge">✅ 已评价</span>
                                    </div>
                                </c:if>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <h3>暂无预约记录</h3>
                        <p>您还没有预约任何服务，点击上方按钮立即预约</p>
                    </div>
                </c:otherwise>
            </c:choose>
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
        
        function toggleReviewForm(orderId) {
            const form = document.getElementById('review-form-' + orderId);
            form.classList.toggle('active');
        }
        
        function setRating(orderId, rating) {
            // 设置隐藏字段值
            document.getElementById('rating-' + orderId).value = rating;
            
            // 更新星星显示
            const stars = document.querySelectorAll('#stars-' + orderId + ' .star');
            stars.forEach((star, index) => {
                if (index < rating) {
                    star.classList.add('active');
                } else {
                    star.classList.remove('active');
                }
            });
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