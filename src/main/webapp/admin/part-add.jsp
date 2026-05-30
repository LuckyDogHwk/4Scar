<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>添加配件 - 汽车4S店售后管理系统</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, sans-serif; background: #f5f5f5; }
        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 15px 30px; }
        .header h1 { font-size: 20px; }
        .header a { color: white; text-decoration: none; float: right; }
        .container { max-width: 500px; margin: 20px auto; padding: 0 20px; }
        .card { background: white; border-radius: 10px; padding: 30px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .card h2 { margin-bottom: 20px; color: #333; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; color: #333; font-weight: 500; }
        .form-group input, .form-group textarea { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; }
        .btn { padding: 10px 20px; background: #667eea; color: white; border: none; border-radius: 5px; cursor: pointer; }
    </style>
</head>
<body>
    <div class="header">
        <h1>添加配件 <a href="${pageContext.request.contextPath}/part?action=list">返回</a></h1>
    </div>
    <div class="container">
        <div class="card">
            <h2>添加配件</h2>
            <form action="${pageContext.request.contextPath}/part" method="post">
                <input type="hidden" name="action" value="add">
                <div class="form-group">
                    <label>配件编号 *</label>
                    <input type="text" name="partNo" required>
                </div>
                <div class="form-group">
                    <label>配件名称 *</label>
                    <input type="text" name="partName" required>
                </div>
                <div class="form-group">
                    <label>品牌</label>
                    <input type="text" name="brand">
                </div>
                <div class="form-group">
                    <label>适用车型</label>
                    <input type="text" name="model">
                </div>
                <div class="form-group">
                    <label>单价 *</label>
                    <input type="number" name="price" step="0.01" required>
                </div>
                <div class="form-group">
                    <label>库存数量 *</label>
                    <input type="number" name="stock" required>
                </div>
                <div class="form-group">
                    <label>描述</label>
                    <textarea name="description"></textarea>
                </div>
                <button type="submit" class="btn">保存</button>
            </form>
        </div>
    </div>
</body>
</html>
