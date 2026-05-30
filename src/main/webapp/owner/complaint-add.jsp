<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=3.0">
    <title>发起投诉 - 汽车4S店售后管理系统</title>
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
        .form-group input, .form-group textarea, .form-group select { width: 100%; padding: 14px 18px; border: 2px solid #eee; border-radius: 12px; font-size: 15px; transition: all 0.3s; background: #fafafa; }
        .form-group input:focus, .form-group textarea:focus, .form-group select:focus { outline: none; border-color: #eb3349; background: white; box-shadow: 0 0 0 4px rgba(235,51,73,0.1); }
        .form-group textarea { height: 150px; resize: vertical; }
        .btn-group { display: flex; gap: 15px; margin-top: 30px; }
        .btn { flex: 1; padding: 16px 30px; background: linear-gradient(135deg, #eb3349 0%, #f45c43 100%); color: white; border: none; border-radius: 12px; cursor: pointer; font-size: 16px; font-weight: 600; transition: all 0.3s; text-decoration: none; text-align: center; }
        .btn:hover { transform: translateY(-2px); box-shadow: 0 5px 20px rgba(235,51,73,0.4); }
        .btn-secondary { background: #e0e0e0; color: #666; }
        .btn-secondary:hover { background: #d0d0d0; box-shadow: none; }
        .warning-box { background: #fff3cd; border-left: 4px solid #f39c12; padding: 15px 20px; border-radius: 10px; margin-bottom: 25px; }
        .warning-box p { color: #856404; font-size: 14px; line-height: 1.6; }
    </style>
</head>
<body>
    <div class="header">
        <h1>🚗 汽车4S店售后管理系统</h1>
        <a href="${pageContext.request.contextPath}/complaint?action=my">← 返回投诉列表</a>
    </div>
    <div class="container">
        <h2 class="page-title">📝 发起投诉</h2>
        <div class="card">
            <h2>⚠️ 提交投诉</h2>
            <div class="warning-box">
                <p>📌 请如实填写投诉内容，我们会认真处理您的每一条投诉，并在24小时内给予回复。感谢您的反馈，这将帮助我们改进服务质量。</p>
            </div>
            <form action="${pageContext.request.contextPath}/complaint" method="post">
                <input type="hidden" name="action" value="add">
                
                <div class="form-group">
                    <label>📋 关联订单(可选)</label>
                    <input type="text" name="orderId" placeholder="如有相关订单，请输入订单ID">
                </div>
                
                <div class="form-group">
                    <label>📌 投诉标题 *</label>
                    <input type="text" name="title" required placeholder="请简要概括投诉问题">
                </div>
                
                <div class="form-group">
                    <label>📝 投诉内容 *</label>
                    <textarea name="content" required placeholder="请详细描述您遇到的问题，包括时间、地点、涉及人员等信息..."></textarea>
                </div>
                
                <div class="btn-group">
                    <button type="submit" class="btn">✅ 提交投诉</button>
                    <a href="${pageContext.request.contextPath}/complaint?action=my" class="btn btn-secondary">取消</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
