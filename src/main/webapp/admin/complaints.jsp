<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=3.0">
    <title>投诉管理 - 汽车4S店售后管理系统</title>
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
        .btn-success { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); }
        .btn-success:hover { box-shadow: 0 5px 20px rgba(17,153,142,0.4); }
        .btn-danger { background: linear-gradient(135deg, #eb3349 0%, #f45c43 100%); }
        .btn-danger:hover { box-shadow: 0 5px 20px rgba(235,51,73,0.4); }
        .btn-sm { padding: 8px 16px; font-size: 13px; }
        .complaint-list { display: flex; flex-direction: column; gap: 20px; }
        .complaint-card { background: white; border-radius: 20px; overflow: hidden; box-shadow: 0 10px 40px rgba(0,0,0,0.15); transition: all 0.3s; }
        .complaint-card:hover { transform: translateY(-5px); box-shadow: 0 15px 50px rgba(0,0,0,0.2); }
        .complaint-header { padding: 20px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #eee; background: #f8f9fa; }
        .complaint-info { display: flex; align-items: center; gap: 15px; }
        .complaint-avatar { width: 50px; height: 50px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; font-weight: 700; font-size: 18px; }
        .complaint-meta h3 { font-size: 16px; color: #333; margin-bottom: 5px; }
        .complaint-meta p { font-size: 13px; color: #888; }
        .status-badge { padding: 6px 14px; border-radius: 20px; font-size: 12px; font-weight: 600; }
        .status-pending { background: #fff3cd; color: #856404; }
        .status-processed { background: #d4edda; color: #155724; }
        .complaint-body { padding: 20px; }
        .complaint-title { font-size: 18px; font-weight: 700; color: #333; margin-bottom: 10px; }
        .complaint-content { color: #666; line-height: 1.6; margin-bottom: 15px; padding: 15px; background: #fff3cd; border-radius: 10px; border-left: 4px solid #f39c12; }
        .result-section { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); padding: 15px 20px; border-radius: 10px; color: white; }
        .result-label { font-size: 12px; opacity: 0.8; margin-bottom: 5px; }
        .complaint-actions { display: flex; gap: 10px; padding: 15px 20px; border-top: 1px solid #eee; background: #f8f9fa; }
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
            <a href="${pageContext.request.contextPath}/order?action=list">📋 订单管理</a>
            <a href="${pageContext.request.contextPath}/part?action=list">🔧 配件管理</a>
            <a href="${pageContext.request.contextPath}/complaint?action=list" class="active">📝 投诉处理</a>
            <a href="${pageContext.request.contextPath}/review?action=list">⭐ 评价管理</a>
        </div>
        
        <h2 class="page-title">📝 投诉处理</h2>
        
        <c:choose>
            <c:when test="${not empty complaints}">
                <div class="complaint-list">
                    <c:forEach var="complaint" items="${complaints}">
                        <div class="complaint-card">
                            <div class="complaint-header">
                                <div class="complaint-info">
                                    <div class="complaint-avatar">${complaint.ownerName.substring(0,1)}</div>
                                    <div class="complaint-meta">
                                        <h3>${complaint.ownerName}</h3>
                                        <p>📅 ${complaint.createTime} ${not empty complaint.orderNo ? '| 订单: ' : ''}${complaint.orderNo}</p>
                                    </div>
                                </div>
                                <span class="status-badge status-${complaint.status}">
                                    <c:choose>
                                        <c:when test="${complaint.status == 'pending'}">⏳ 待处理</c:when>
                                        <c:when test="${complaint.status == 'processed'}">✅ 已处理</c:when>
                                    </c:choose>
                                </span>
                            </div>
                            <div class="complaint-body">
                                <div class="complaint-title">${complaint.title}</div>
                                <div class="complaint-content">${complaint.content}</div>
                                <c:if test="${not empty complaint.handleResult}">
                                    <div class="result-section">
                                        <div class="result-label">✅ 处理结果：</div>
                                        <div>${complaint.handleResult}</div>
                                    </div>
                                </c:if>
                                <c:if test="${empty complaint.handleResult && complaint.status == 'processed'}">
                                    <div style="background: #f8f9fa; padding: 15px; border-radius: 10px; color: #666;">
                                        <div style="font-size: 12px; color: #888; margin-bottom: 5px;">✅ 处理时间：${complaint.handleTime}</div>
                                        <div>已处理（处理结果未记录）</div>
                                    </div>
                                </c:if>
                            </div>
                            <div class="complaint-actions">
                                <c:if test="${complaint.status == 'pending'}">
                                    <a href="${pageContext.request.contextPath}/complaint?action=handle&id=${complaint.id}" class="btn btn-success btn-sm">处理投诉</a>
                                </c:if>
                                <a href="${pageContext.request.contextPath}/complaint?action=delete&id=${complaint.id}" class="btn btn-danger btn-sm" onclick="return confirm('确定要删除这条投诉吗？')">删除</a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card" style="text-align: center; padding: 60px;">
                    <h3 style="color: #888;">暂无投诉记录</h3>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
