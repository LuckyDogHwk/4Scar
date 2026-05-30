<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=3.0">
    <title>我的投诉 - 汽车4S店售后管理系统</title>
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
        .btn-danger { background: linear-gradient(135deg, #eb3349 0%, #f45c43 100%); }
        .btn-danger:hover { box-shadow: 0 5px 20px rgba(235,51,73,0.4); }
        .complaint-list { display: flex; flex-direction: column; gap: 20px; }
        .complaint-card { background: white; border-radius: 20px; overflow: hidden; box-shadow: 0 10px 40px rgba(0,0,0,0.15); transition: all 0.3s; }
        .complaint-card:hover { transform: translateY(-5px); box-shadow: 0 15px 50px rgba(0,0,0,0.2); }
        .complaint-header { padding: 20px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #eee; }
        .complaint-title { font-size: 18px; font-weight: 700; color: #333; }
        .complaint-time { font-size: 13px; color: #888; }
        .status-badge { padding: 6px 14px; border-radius: 20px; font-size: 12px; font-weight: 600; }
        .status-pending { background: #fff3cd; color: #856404; }
        .status-processed { background: #d4edda; color: #155724; }
        .complaint-body { padding: 20px; }
        .complaint-content { color: #555; line-height: 1.6; margin-bottom: 15px; padding: 15px; background: #fff3cd; border-radius: 10px; border-left: 4px solid #f39c12; }
        .result-section { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); padding: 20px; border-radius: 15px; color: white; }
        .result-label { font-size: 12px; opacity: 0.8; margin-bottom: 8px; }
        .result-content { line-height: 1.6; }
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
            <a href="${pageContext.request.contextPath}/message?action=my">💬 咨询留言</a>
            <a href="${pageContext.request.contextPath}/complaint?action=my" class="active">📝 意见反馈</a>
            <a href="${pageContext.request.contextPath}/review?action=my">⭐ 我的评价</a>
        </div>
        
        <div class="page-title">
            <span>📝 我的投诉</span>
            <a href="${pageContext.request.contextPath}/owner/complaint-add.jsp" class="btn btn-danger">➕ 发起投诉</a>
        </div>
        
        <c:choose>
            <c:when test="${not empty complaints}">
                <div class="complaint-list">
                    <c:forEach var="complaint" items="${complaints}">
                        <div class="complaint-card">
                            <div class="complaint-header">
                                <div>
                                    <div class="complaint-title">${complaint.title}</div>
                                    <div class="complaint-time">📅 ${complaint.createTime}</div>
                                </div>
                                <span class="status-badge status-${complaint.status}">
                                    <c:choose>
                                        <c:when test="${complaint.status == 'pending'}">⏳ 待处理</c:when>
                                        <c:when test="${complaint.status == 'processed'}">✅ 已处理</c:when>
                                    </c:choose>
                                </span>
                            </div>
                            <div class="complaint-body">
                                <div class="complaint-content">📝 ${complaint.content}</div>
                                <c:if test="${not empty complaint.handleResult}">
                                    <div class="result-section">
                                        <div class="result-label">✅ 处理结果：</div>
                                        <div class="result-content">${complaint.handleResult}</div>
                                    </div>
                                </c:if>
                                <c:if test="${empty complaint.handleResult && complaint.status == 'processed'}">
                                    <div style="background: #d4edda; padding: 15px; border-radius: 10px; color: #155724;">
                                        <div style="font-size: 12px; margin-bottom: 5px;">✅ 处理时间：${complaint.handleTime}</div>
                                        <div>您的投诉已处理完成</div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <h3>暂无投诉记录</h3>
                    <p>如有问题需要反馈，请点击上方按钮发起投诉</p>
                    <a href="${pageContext.request.contextPath}/owner/complaint-add.jsp" class="btn btn-danger" style="margin-top: 20px;">➕ 发起投诉</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
