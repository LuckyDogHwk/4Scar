<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.25, maximum-scale=5.0, user-scalable=yes">
    <title>我的评价 - 汽车4S店售后管理系统</title>
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
        .card h2 { margin-bottom: 20px; color: #333; font-size: 20px; display: flex; align-items: center; gap: 10px; }
        .review-list { display: flex; flex-direction: column; gap: 20px; }
        .review-card { background: #f8f9fa; border-radius: 15px; overflow: hidden; transition: all 0.3s; border: 1px solid #eee; }
        .review-card:hover { transform: translateY(-3px); box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
        .review-header { padding: 15px 20px; display: flex; justify-content: space-between; align-items: center; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; }
        .review-order { font-weight: 600; font-size: 14px; }
        .review-time { font-size: 13px; opacity: 0.8; }
        .review-body { padding: 20px; }
        .rating { color: #ffc107; font-size: 20px; letter-spacing: 3px; margin-bottom: 10px; }
        .rating-low { color: #ff6b6b; }
        .rating-mid { color: #ffc107; }
        .rating-high { color: #51cf66; }
        .review-content { color: #555; line-height: 1.6; padding: 12px; background: white; border-radius: 8px; font-size: 14px; }
        
        .empty-state { text-align: center; padding: 60px 20px; color: #888; }
        .empty-state h3 { font-size: 20px; margin-bottom: 10px; color: #333; }
        .empty-state p { font-size: 14px; }
        
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
        .zoom-controls button:hover {
            transform: scale(1.1);
            box-shadow: 0 3px 10px rgba(102,126,234,0.4);
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
            <a href="${pageContext.request.contextPath}/order?action=my">📅 预约服务</a>
            <a href="${pageContext.request.contextPath}/message?action=my">💬 咨询留言</a>
            <a href="${pageContext.request.contextPath}/complaint?action=my">📝 意见反馈</a>
            <a href="${pageContext.request.contextPath}/review?action=my" class="active">⭐ 我的评价</a>
        </div>
        
        <h2 class="page-title">⭐ 我的评价</h2>
        
        <div class="card">
            <h2>📋 我的评价记录 <span style="background:#667eea;color:white;padding:2px 10px;border-radius:15px;font-size:14px;">${reviews.size()}条</span></h2>
            <c:choose>
                <c:when test="${not empty reviews}">
                    <div class="review-list">
                        <c:forEach var="review" items="${reviews}">
                            <div class="review-card">
                                <div class="review-header">
                                    <span class="review-order">📋 ${review.orderNo}</span>
                                    <span class="review-time">${review.createTime}</span>
                                </div>
                                <div class="review-body">
                                    <div class="rating 
                                        <c:choose>
                                            <c:when test="${review.rating >= 4}">rating-high</c:when>
                                            <c:when test="${review.rating >= 2}">rating-mid</c:when>
                                            <c:otherwise>rating-low</c:otherwise>
                                        </c:choose>">
                                        <c:forEach begin="1" end="${review.rating}">★</c:forEach><c:forEach begin="1" end="${5 - review.rating}"><span style="color: #ddd;">★</span></c:forEach>
                                        <span style="color: #333; font-size: 14px; margin-left: 10px; font-weight: 600;">${review.rating}分</span>
                                    </div>
                                    <div class="review-content">${review.content}</div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <h3>⭐ 暂无评价记录</h3>
                        <p>您还没有提交过任何评价</p>
                        <p style="margin-top:10px;font-size:12px;color:#888;">完成服务后，可以在"我的预约"中对已完成的服务进行评价</p>
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