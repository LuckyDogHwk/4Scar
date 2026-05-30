<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.25, maximum-scale=5.0, user-scalable=yes">
    <title>个人信息 - 汽车4S店售后管理系统</title>
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
        
        .card { background: white; border-radius: 20px; padding: 30px; box-shadow: 0 10px 40px rgba(0,0,0,0.15); max-width: 600px; margin: 0 auto; }
        .card h2 { margin-bottom: 25px; color: #333; font-size: 20px; display: flex; align-items: center; gap: 10px; }
        
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; font-size: 14px; font-weight: 600; color: #555; margin-bottom: 8px; }
        .form-group input { width: 100%; padding: 12px 16px; border: 2px solid #eee; border-radius: 10px; font-size: 15px; transition: border-color 0.3s; font-family: inherit; }
        .form-group input:focus { outline: none; border-color: #667eea; }
        .form-group input:read-only { background: #f8f9fa; color: #888; cursor: not-allowed; }
        .form-group .hint { font-size: 12px; color: #aaa; margin-top: 5px; }
        
        .btn { padding: 12px 30px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border: none; border-radius: 10px; cursor: pointer; font-weight: 600; font-size: 15px; transition: all 0.3s; display: inline-block; text-decoration: none; }
        .btn:hover { transform: translateY(-2px); box-shadow: 0 5px 20px rgba(102,126,234,0.4); }
        .btn-back { background: #ccc; }
        .btn-back:hover { box-shadow: 0 5px 20px rgba(0,0,0,0.2); }
        .form-actions { display: flex; gap: 15px; margin-top: 30px; }
        
        .success-msg { background: #d4edda; color: #155724; padding: 15px 20px; border-radius: 10px; margin-bottom: 20px; font-weight: 600; }
        .error-msg { background: #f8d7da; color: #721c24; padding: 15px 20px; border-radius: 10px; margin-bottom: 20px; font-weight: 600; }
        
        .avatar-section { text-align: center; margin-bottom: 25px; }
        .avatar { width: 80px; height: 80px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; font-weight: 700; font-size: 32px; margin: 0 auto 10px; }
        .role-badge { display: inline-block; padding: 4px 12px; border-radius: 15px; font-size: 12px; font-weight: 600; }
        .role-owner { background: #cce5ff; color: #004085; }
        .role-admin { background: #f8d7da; color: #721c24; }
        .role-mechanic { background: #d4edda; color: #155724; }
        
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
            <a href="${pageContext.request.contextPath}/review?action=my">⭐ 我的评价</a>
        </div>
        
        <h2 class="page-title">👤 个人信息</h2>
        
        <div class="card">
            <div class="avatar-section">
                <div class="avatar">${user.realName.substring(0,1)}</div>
                <span class="role-badge role-${user.role}">
                    <c:choose>
                        <c:when test="${user.role == 'admin'}">管理员</c:when>
                        <c:when test="${user.role == 'mechanic'}">维修人员</c:when>
                        <c:otherwise>车主</c:otherwise>
                    </c:choose>
                </span>
            </div>
            
            <c:if test="${not empty param.success}">
                <div class="success-msg">✅ 个人信息修改成功！</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="error-msg">❌ ${error}</div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/auth" method="post">
                <input type="hidden" name="action" value="updateProfile">
                
                <div class="form-group">
                    <label>👤 用户名</label>
                    <input type="text" name="username" value="${user.username}" required placeholder="请输入用户名">
                    <div class="hint">修改用户名需确保未被其他用户使用</div>
                </div>
                
                <div class="form-group">
                    <label>🔑 新密码</label>
                    <input type="password" name="newPassword" placeholder="留空则不修改密码">
                    <div class="hint">如需修改密码请输入新密码，留空则保持原密码</div>
                </div>
                
                <div class="form-group">
                    <label>📛 真实姓名</label>
                    <input type="text" name="realName" value="${user.realName}" required placeholder="请输入真实姓名">
                </div>
                
                <div class="form-group">
                    <label>📱 手机号码</label>
                    <input type="tel" name="phone" value="${user.phone}" placeholder="请输入手机号码">
                </div>
                
                <div class="form-group">
                    <label>📧 电子邮箱</label>
                    <input type="email" name="email" value="${user.email}" placeholder="请输入电子邮箱">
                </div>
                
                <div class="form-group">
                    <label>📅 注册时间</label>
                    <input type="text" value="${user.createTime}" readonly>
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn">💾 保存修改</button>
                    <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-back">返回首页</a>
                </div>
            </form>
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
        function zoomIn() { if (currentZoom < maxZoom) { currentZoom += zoomStep; updateZoom(); } }
        function zoomOut() { if (currentZoom > minZoom) { currentZoom -= zoomStep; updateZoom(); } }
        function resetZoom() { currentZoom = 100; updateZoom(); }
        
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