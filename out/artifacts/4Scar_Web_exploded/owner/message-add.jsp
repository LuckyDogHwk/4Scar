<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=3.0">
    <title>发布留言 - 汽车4S店售后管理系统</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; }
        .header { background: rgba(255,255,255,0.1); backdrop-filter: blur(10px); color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid rgba(255,255,255,0.2); }
        .header h1 { font-size: 22px; font-weight: 600; }
        .header a { color: white; text-decoration: none; opacity: 0.9; transition: opacity 0.3s; }
        .header a:hover { opacity: 1; }
        .container { max-width: 800px; margin: 0 auto; padding: 20px; }
        .page-title { color: white; font-size: 28px; margin-bottom: 25px; text-shadow: 0 2px 4px rgba(0,0,0,0.2); }
        .card { background: white; border-radius: 20px; padding: 35px; box-shadow: 0 10px 40px rgba(0,0,0,0.15); }
        .card h2 { margin-bottom: 25px; color: #333; font-size: 22px; display: flex; align-items: center; gap: 10px; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; color: #333; font-weight: 600; font-size: 14px; }
        .form-group input, .form-group textarea { width: 100%; padding: 14px 18px; border: 2px solid #eee; border-radius: 12px; font-size: 15px; transition: all 0.3s; background: #fafafa; }
        .form-group input:focus, .form-group textarea:focus { outline: none; border-color: #667eea; background: white; box-shadow: 0 0 0 4px rgba(102,126,234,0.1); }
        .form-group textarea { height: 150px; resize: vertical; }
        .quick-topics { display: flex; flex-wrap: wrap; gap: 10px; margin-bottom: 15px; }
        .quick-topic { padding: 8px 16px; background: #f0f0f0; border-radius: 20px; font-size: 13px; cursor: pointer; transition: all 0.3s; }
        .quick-topic:hover { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; }
        .btn-group { display: flex; gap: 15px; margin-top: 30px; }
        .btn { flex: 1; padding: 16px 30px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border: none; border-radius: 12px; cursor: pointer; font-size: 16px; font-weight: 600; transition: all 0.3s; text-decoration: none; text-align: center; }
        .btn:hover { transform: translateY(-2px); box-shadow: 0 5px 20px rgba(102,126,234,0.4); }
        .btn-secondary { background: #e0e0e0; color: #666; }
        .btn-secondary:hover { background: #d0d0d0; box-shadow: none; }
    </style>
</head>
<body>
    <div class="header">
        <h1>🚗 汽车4S店售后管理系统</h1>
        <a href="${pageContext.request.contextPath}/message?action=my">← 返回留言列表</a>
    </div>
    <div class="container">
        <h2 class="page-title">💬 发布留言</h2>
        <div class="card">
            <h2>📝 发布咨询留言</h2>
            <form action="${pageContext.request.contextPath}/message" method="post">
                <input type="hidden" name="action" value="add">
                
                <div class="form-group">
                    <label>📌 快速选择主题</label>
                    <div class="quick-topics">
                        <span class="quick-topic" onclick="setTitle('关于保养周期的问题')">保养周期咨询</span>
                        <span class="quick-topic" onclick="setTitle('车辆故障咨询')">车辆故障</span>
                        <span class="quick-topic" onclick="setTitle('配件价格咨询')">配件价格</span>
                        <span class="quick-topic" onclick="setTitle('预约时间咨询')">预约时间</span>
                        <span class="quick-topic" onclick="setTitle('保险理赔咨询')">保险理赔</span>
                        <span class="quick-topic" onclick="setTitle('年检相关咨询')">年检问题</span>
                    </div>
                </div>
                
                <div class="form-group">
                    <label>📋 标题 *</label>
                    <input type="text" name="title" id="titleInput" required placeholder="请输入留言标题">
                </div>
                
                <div class="form-group">
                    <label>📝 内容 *</label>
                    <textarea name="content" required placeholder="请详细描述您的问题，我们的专业维修人员将尽快为您解答..."></textarea>
                </div>
                
                <div class="btn-group">
                    <button type="submit" class="btn">✅ 提交留言</button>
                    <a href="${pageContext.request.contextPath}/message?action=my" class="btn btn-secondary">取消</a>
                </div>
            </form>
        </div>
    </div>
    <script>
        function setTitle(title) {
            document.getElementById('titleInput').value = title;
        }
    </script>
</body>
</html>
