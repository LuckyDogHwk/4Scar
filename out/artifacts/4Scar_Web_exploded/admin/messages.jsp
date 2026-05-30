<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>留言管理 - 汽车4S店售后管理系统</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, sans-serif; background: #f5f5f5; }
        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 15px 30px; }
        .header h1 { font-size: 20px; }
        .header a { color: white; text-decoration: none; }
        .container { max-width: 1400px; margin: 0 auto; padding: 20px; }
        .nav { display: flex; gap: 10px; margin-bottom: 20px; }
        .nav a { padding: 10px 20px; background: white; color: #333; text-decoration: none; border-radius: 5px; }
        .card { background: white; border-radius: 10px; padding: 20px; margin-bottom: 20px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .card h2 { margin-bottom: 15px; color: #333; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #eee; }
        th { background: #f8f9fa; }
        .btn { padding: 8px 15px; background: #667eea; color: white; border: none; border-radius: 5px; cursor: pointer; text-decoration: none; display: inline-block; }
        .btn-danger { background: #e74c3c; }
    </style>
</head>
<body>
    <div class="header">
        <h1>留言管理 - 汽车4S店售后管理系统</h1>
        <a href="${pageContext.request.contextPath}/auth?action=profile">👤 个人信息</a>
        <a href="${pageContext.request.contextPath}/auth?action=logout">退出登录</a>
    </div>
    <div class="container">
        <div class="nav">
            <a href="${pageContext.request.contextPath}/admin/index.jsp">返回首页</a>
        </div>
        <div class="card">
            <h2>所有留言</h2>
            <table>
                <thead>
                    <tr>
                        <th>车主</th>
                        <th>标题</th>
                        <th>内容</th>
                        <th>回复内容</th>
                        <th>状态</th>
                        <th>时间</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="msg" items="${messages}">
                    <tr>
                        <td>${msg.ownerName}</td>
                        <td>${msg.title}</td>
                        <td>${msg.content}</td>
                        <td>${msg.replyContent}</td>
                        <td>${msg.status == 'pending' ? '待回复' : '已回复'}</td>
                        <td>${msg.createTime}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/message?action=delete&id=${msg.id}" class="btn btn-danger" onclick="return confirm('确定删除?')">删除</a>
                        </td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
