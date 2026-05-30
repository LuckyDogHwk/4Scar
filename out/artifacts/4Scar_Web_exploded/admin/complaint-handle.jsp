<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>处理投诉 - 汽车4S店售后管理系统</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, sans-serif; background: #f5f5f5; }
        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 15px 30px; }
        .header h1 { font-size: 20px; }
        .header a { color: white; text-decoration: none; float: right; }
        .container { max-width: 600px; margin: 20px auto; padding: 0 20px; }
        .card { background: white; border-radius: 10px; padding: 30px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .card h2 { margin-bottom: 20px; color: #333; }
        .info-row { display: flex; margin-bottom: 15px; }
        .info-row .label { width: 100px; font-weight: bold; color: #666; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; color: #333; font-weight: 500; }
        .form-group textarea { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; height: 150px; }
        .btn { padding: 10px 20px; background: #667eea; color: white; border: none; border-radius: 5px; cursor: pointer; }
    </style>
</head>
<body>
    <div class="header">
        <h1>处理投诉 <a href="${pageContext.request.contextPath}/complaint?action=list">返回</a></h1>
    </div>
    <div class="container">
        <div class="card">
            <h2>投诉信息</h2>
            <div class="info-row"><span class="label">车主:</span><span>${complaint.ownerName}</span></div>
            <div class="info-row"><span class="label">标题:</span><span>${complaint.title}</span></div>
            <div class="info-row"><span class="label">内容:</span><span>${complaint.content}</span></div>
            <div class="info-row"><span class="label">时间:</span><span>${complaint.createTime}</span></div>
            <form action="${pageContext.request.contextPath}/complaint" method="post">
                <input type="hidden" name="action" value="handle">
                <input type="hidden" name="id" value="${complaint.id}">
                <!-- 调试: complaint.id = ${complaint.id} -->
                <div class="form-group">
                    <label>处理结果</label>
                    <textarea name="handleResult" required></textarea>
                </div>
                <button type="submit" class="btn">提交处理结果</button>
            </form>
        </div>
    </div>
</body>
</html>
