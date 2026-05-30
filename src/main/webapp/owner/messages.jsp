<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=3.0">
    <title>咨询留言 - 汽车4S店售后管理系统</title>
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
        .page-title { color: white; font-size: 28px; margin-bottom: 25px; text-shadow: 0 2px 4px rgba(0,0,0,0.2); display: flex; justify-content: space-between; align-items: center; }
        .btn { padding: 12px 24px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border: none; border-radius: 10px; cursor: pointer; text-decoration: none; display: inline-block; font-weight: 600; transition: all 0.3s; }
        .btn:hover { transform: translateY(-2px); box-shadow: 0 5px 20px rgba(102,126,234,0.4); }
        .btn-success { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); }
        .btn-success:hover { box-shadow: 0 5px 20px rgba(17,153,142,0.4); }
        .message-list { display: flex; flex-direction: column; gap: 20px; }
        .message-card { background: white; border-radius: 20px; overflow: hidden; box-shadow: 0 10px 40px rgba(0,0,0,0.15); transition: all 0.3s; }
        .message-card:hover { transform: translateY(-5px); box-shadow: 0 15px 50px rgba(0,0,0,0.2); }
        .message-header { padding: 20px; border-bottom: 1px solid #eee; display: flex; justify-content: space-between; align-items: center; }
        .message-title { font-size: 18px; font-weight: 700; color: #333; }
        .message-time { font-size: 13px; color: #888; }
        .status-badge { padding: 6px 14px; border-radius: 20px; font-size: 12px; font-weight: 600; }
        .status-pending { background: #fff3cd; color: #856404; }
        .status-replied { background: #d4edda; color: #155724; }
        .message-body { padding: 20px; }
        .message-content { color: #555; line-height: 1.6; margin-bottom: 15px; padding: 15px; background: #f8f9fa; border-radius: 10px; }
        .reply-section { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 20px; border-radius: 15px; color: white; }
        .reply-label { font-size: 12px; opacity: 0.8; margin-bottom: 8px; }
        .reply-content { line-height: 1.6; }
        .reply-time { font-size: 12px; opacity: 0.7; margin-top: 10px; }
        .empty-state { text-align: center; padding: 60px 20px; color: white; }
        .empty-state h3 { font-size: 24px; margin-bottom: 10px; }
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
            <a href="${pageContext.request.contextPath}/message?action=my" class="active">💬 咨询留言</a>
            <a href="${pageContext.request.contextPath}/complaint?action=my">📝 意见反馈</a>
            <a href="${pageContext.request.contextPath}/review?action=my">⭐ 我的评价</a>
        </div>
        
        <div class="page-title">
            <span>💬 咨询留言</span>
            <a href="${pageContext.request.contextPath}/owner/message-add.jsp" class="btn btn-success">➕ 发布留言</a>
        </div>
        
        <c:choose>
            <c:when test="${not empty messages}">
                <div class="message-list">
                    <c:forEach var="msg" items="${messages}">
                        <div class="message-card">
                            <div class="message-header">
                                <div>
                                    <div class="message-title">${msg.title}</div>
                                    <div class="message-time">📅 ${msg.createTime}</div>
                                </div>
                                <span class="status-badge status-${msg.status}">
                                    <c:choose>
                                        <c:when test="${msg.status == 'pending'}">⏳ 待回复</c:when>
                                        <c:when test="${msg.status == 'replied'}">✅ 已回复</c:when>
                                    </c:choose>
                                </span>
                            </div>
                            <div class="message-body">
                                <div class="message-content">📝 ${msg.content}</div>
                                <c:if test="${not empty msg.replyContent}">
                                    <div class="reply-section">
                                        <div class="reply-label">🔧 维修人员回复：</div>
                                        <div class="reply-content">${msg.replyContent}</div>
                                        <c:if test="${not empty msg.replyTime}">
                                            <div class="reply-time">回复时间：${msg.replyTime}</div>
                                        </c:if>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <h3>暂无留言记录</h3>
                    <p>您还没有发布过咨询留言</p>
                    <a href="${pageContext.request.contextPath}/owner/message-add.jsp" class="btn btn-success" style="margin-top: 20px;">➕ 发布留言</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
