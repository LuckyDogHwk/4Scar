<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.25, maximum-scale=5.0, user-scalable=yes">
    <title>咨询回复 - 汽车4S店售后管理系统</title>
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
        .btn { padding: 10px 20px; background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); color: white; border: none; border-radius: 10px; cursor: pointer; text-decoration: none; display: inline-block; font-weight: 600; transition: all 0.3s; }
        .btn:hover { transform: translateY(-2px); box-shadow: 0 5px 20px rgba(17,153,142,0.4); }
        .btn-sm { padding: 8px 16px; font-size: 13px; }
        .message-list { display: flex; flex-direction: column; gap: 20px; }
        .message-card { background: white; border-radius: 20px; overflow: hidden; box-shadow: 0 10px 40px rgba(0,0,0,0.15); transition: all 0.3s; }
        .message-card:hover { transform: translateY(-5px); box-shadow: 0 15px 50px rgba(0,0,0,0.2); }
        .message-header { padding: 20px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #eee; background: #f8f9fa; }
        .message-info { display: flex; align-items: center; gap: 15px; }
        .message-avatar { width: 50px; height: 50px; background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; font-weight: 700; font-size: 18px; }
        .message-meta h3 { font-size: 16px; color: #333; margin-bottom: 5px; }
        .message-meta p { font-size: 13px; color: #888; }
        .status-badge { padding: 6px 14px; border-radius: 20px; font-size: 12px; font-weight: 600; }
        .status-pending { background: #fff3cd; color: #856404; }
        .status-replied { background: #d4edda; color: #155724; }
        .message-body { padding: 20px; }
        .message-title { font-size: 18px; font-weight: 700; color: #333; margin-bottom: 10px; }
        .message-content { color: #666; line-height: 1.6; padding: 15px; background: #f8f9fa; border-radius: 10px; }
        .message-actions { display: flex; gap: 10px; padding: 15px 20px; border-top: 1px solid #eee; background: #f8f9fa; }
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
            <a href="${pageContext.request.contextPath}/order?action=my">🔧 我的工单</a>
            <a href="${pageContext.request.contextPath}/order?action=pending">📋 待接工单</a>
            <a href="${pageContext.request.contextPath}/message?action=pending" class="active">💬 咨询回复</a>
        </div>
        
        <h2 class="page-title">💬 咨询回复</h2>
        
        <c:choose>
            <c:when test="${not empty messages}">
                <div class="message-list">
                    <c:forEach var="msg" items="${messages}">
                        <div class="message-card">
                            <div class="message-header">
                                <div class="message-info">
                                    <div class="message-avatar">${msg.ownerName.substring(0,1)}</div>
                                    <div class="message-meta">
                                        <h3>${msg.ownerName}</h3>
                                        <p>📅 ${msg.createTime}</p>
                                    </div>
                                </div>
                                <span class="status-badge status-${msg.status}">
                                    <c:choose>
                                        <c:when test="${msg.status == 'pending'}">⏳ 待回复</c:when>
                                        <c:when test="${msg.status == 'replied'}">✅ 已回复</c:when>
                                    </c:choose>
                                </span>
                            </div>
                            <div class="message-body">
                                <div class="message-title">${msg.title}</div>
                                <div class="message-content">${msg.content}</div>
                            </div>
                            <div class="message-actions">
                                <a href="${pageContext.request.contextPath}/mechanic/message-reply.jsp?id=${msg.id}" class="btn btn-sm">回复</a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card" style="text-align: center; padding: 60px;">
                    <h3 style="color: #888;">暂无待回复留言</h3>
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
