<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>回复留言 - 汽车4S店售后管理系统</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, sans-serif; background: #f5f5f5; }
        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 15px 30px; }
        .header h1 { font-size: 20px; }
        .header a { color: white; text-decoration: none; float: right; }
        .container { max-width: 800px; margin: 20px auto; padding: 0 20px; }
        .card { background: white; border-radius: 10px; padding: 30px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .card h2 { margin-bottom: 20px; color: #333; }
        .info-row { display: flex; margin-bottom: 15px; }
        .info-row .label { width: 100px; font-weight: bold; color: #666; }
        .info-row .value { flex: 1; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; color: #333; font-weight: 500; }
        .form-group textarea { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; height: 150px; }
        .btn-group { display: flex; gap: 10px; }
        .btn { padding: 10px 20px; background: #667eea; color: white; border: none; border-radius: 5px; cursor: pointer; }
        .btn-secondary { background: #95a5a6; }
    </style>
</head>
<body>
    <div class="header">
        <h1>回复留言 <a href="${pageContext.request.contextPath}/message?action=pending">返回</a></h1>
    </div>
    <div class="container">
        <div class="card">
            <h2>留言信息</h2>
            <div class="info-row"><span class="label">车主:</span><span class="value">${message.ownerName}</span></div>
            <div class="info-row"><span class="label">标题:</span><span class="value">${message.title}</span></div>
            <div class="info-row"><span class="label">内容:</span><span class="value">${message.content}</span></div>
            <div class="info-row"><span class="label">时间:</span><span class="value">${message.createTime}</span></div>
            <form action="${pageContext.request.contextPath}/message" method="post">
                <input type="hidden" name="action" value="reply">
                <input type="hidden" name="id" value="${message.id}">
                <div class="form-group">
                    <label>回复内容</label>
                    <textarea name="replyContent" required></textarea>
                </div>
                <div class="btn-group">
                    <button type="submit" class="btn">提交回复</button>
                    <a href="${pageContext.request.contextPath}/message?action=pending" class="btn btn-secondary">取消</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
