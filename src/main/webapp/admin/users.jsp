<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=3.0">
    <title>用户管理 - 汽车4S店售后管理系统</title>
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
        .page-title { color: white; font-size: 28px; margin-bottom: 25px; text-shadow: 0 2px 4px rgba(0,0,0,0.2); display: flex; justify-content: space-between; align-items: center; }
        .btn { padding: 12px 24px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border: none; border-radius: 10px; cursor: pointer; text-decoration: none; display: inline-block; font-weight: 600; transition: all 0.3s; }
        .btn:hover { transform: translateY(-2px); box-shadow: 0 5px 20px rgba(102,126,234,0.4); }
        .btn-success { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); }
        .btn-success:hover { box-shadow: 0 5px 20px rgba(17,153,142,0.4); }
        .btn-danger { background: linear-gradient(135deg, #eb3349 0%, #f45c43 100%); }
        .btn-danger:hover { box-shadow: 0 5px 20px rgba(235,51,73,0.4); }
        .btn-sm { padding: 8px 16px; font-size: 13px; }
        .card { background: white; border-radius: 20px; padding: 25px; margin-bottom: 25px; box-shadow: 0 10px 40px rgba(0,0,0,0.15); }
        .card h2 { margin-bottom: 20px; color: #333; font-size: 20px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; }
        th { background: #f8f9fa; color: #666; font-weight: 600; font-size: 13px; text-transform: uppercase; }
        td { color: #333; }
        .role-badge { padding: 6px 14px; border-radius: 20px; font-size: 12px; font-weight: 600; }
        .role-owner { background: #cce5ff; color: #004085; }
        .role-mechanic { background: #d4edda; color: #155724; }
        .role-admin { background: #e2e3e5; color: #383d41; }
        .status-badge { padding: 6px 14px; border-radius: 20px; font-size: 12px; font-weight: 600; }
        .status-active { background: #d4edda; color: #155724; }
        .status-disabled { background: #f8d7da; color: #721c24; }
        .filter-tabs { display: flex; gap: 10px; margin-bottom: 20px; }
        .filter-tab { padding: 10px 20px; background: #f0f0f0; border-radius: 20px; cursor: pointer; transition: all 0.3s; text-decoration: none; color: #666; }
        .filter-tab:hover, .filter-tab.active { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; }
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
            <a href="${pageContext.request.contextPath}/user?action=list" class="active">👥 用户管理</a>
            <a href="${pageContext.request.contextPath}/car?action=list">🚗 车辆管理</a>
            <a href="${pageContext.request.contextPath}/order?action=list">📋 订单管理</a>
            <a href="${pageContext.request.contextPath}/part?action=list">🔧 配件管理</a>
            <a href="${pageContext.request.contextPath}/complaint?action=list">📝 投诉处理</a>
            <a href="${pageContext.request.contextPath}/review?action=list">⭐ 评价管理</a>
        </div>
        
        <div class="page-title">
            <span>👥 用户管理</span>
            <a href="${pageContext.request.contextPath}/admin/user-add.jsp" class="btn btn-success">➕ 添加用户</a>
        </div>
        
        <div class="card">
            <div class="filter-tabs">
                <a href="${pageContext.request.contextPath}/user?action=list" class="filter-tab ${empty param.role ? 'active' : ''}">全部用户</a>
                <a href="${pageContext.request.contextPath}/user?action=list&role=owner" class="filter-tab ${param.role == 'owner' ? 'active' : ''}">🚗 车主</a>
                <a href="${pageContext.request.contextPath}/user?action=list&role=mechanic" class="filter-tab ${param.role == 'mechanic' ? 'active' : ''}">🔧 维修人员</a>
            </div>
            
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>用户名</th>
                        <th>姓名</th>
                        <th>电话</th>
                        <th>邮箱</th>
                        <th>角色</th>
                        <th>状态</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${users}">
                    <tr>
                        <td><strong>#${user.id}</strong></td>
                        <td>${user.username}</td>
                        <td>${user.realName}</td>
                        <td>${user.phone}</td>
                        <td>${user.email}</td>
                        <td>
                            <span class="role-badge role-${user.role}">
                                <c:choose>
                                    <c:when test="${user.role == 'owner'}">🚗 车主</c:when>
                                    <c:when test="${user.role == 'mechanic'}">🔧 维修人员</c:when>
                                    <c:when test="${user.role == 'admin'}">👑 管理员</c:when>
                                </c:choose>
                            </span>
                        </td>
                        <td>
                            <span class="status-badge ${user.status == 1 ? 'status-active' : 'status-disabled'}">
                                ${user.status == 1 ? '✅ 正常' : '❌ 禁用'}
                            </span>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/user?action=edit&id=${user.id}" class="btn btn-sm">编辑</a>
                            <c:if test="${user.role != 'admin'}">
                                <a href="${pageContext.request.contextPath}/user?action=delete&id=${user.id}" class="btn btn-danger btn-sm" onclick="return confirm('确定要删除这个用户吗？')">删除</a>
                            </c:if>
                        </td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
