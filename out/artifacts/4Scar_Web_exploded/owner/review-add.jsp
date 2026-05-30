<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=3.0">
    <title>评价服务 - 汽车4S店售后管理系统</title>
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
        .form-group textarea { width: 100%; padding: 14px 18px; border: 2px solid #eee; border-radius: 12px; font-size: 15px; transition: all 0.3s; background: #fafafa; height: 150px; resize: vertical; }
        .form-group textarea:focus { outline: none; border-color: #667eea; background: white; box-shadow: 0 0 0 4px rgba(102,126,234,0.1); }
        .rating-container { text-align: center; padding: 30px 0; }
        .rating-title { font-size: 16px; color: #666; margin-bottom: 20px; }
        .star-rating { display: flex; flex-direction: row-reverse; justify-content: center; gap: 10px; }
        .star-rating input { display: none; }
        .star-rating label { cursor: pointer; font-size: 50px; color: #ddd; transition: all 0.2s; }
        .star-rating label:hover, .star-rating label:hover ~ label, .star-rating input:checked ~ label { color: #f39c12; transform: scale(1.1); }
        .rating-text { margin-top: 15px; font-size: 18px; font-weight: 600; color: #667eea; }
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
        <a href="${pageContext.request.contextPath}/order?action=my">← 返回订单列表</a>
    </div>
    <div class="container">
        <h2 class="page-title">⭐ 评价服务</h2>
        <div class="card">
            <h2>📝 发表评价</h2>
            <form action="${pageContext.request.contextPath}/review" method="post">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="orderId" value="${param.orderId}">
                
                <div class="form-group">
                    <div class="rating-container">
                        <div class="rating-title">请为本次服务打分</div>
                        <div class="star-rating">
                            <input type="radio" id="star5" name="rating" value="5" onclick="updateRating(5)"><label for="star5">★</label>
                            <input type="radio" id="star4" name="rating" value="4" onclick="updateRating(4)"><label for="star4">★</label>
                            <input type="radio" id="star3" name="rating" value="3" onclick="updateRating(3)"><label for="star3">★</label>
                            <input type="radio" id="star2" name="rating" value="2" onclick="updateRating(2)"><label for="star2">★</label>
                            <input type="radio" id="star1" name="rating" value="1" onclick="updateRating(1)"><label for="star1">★</label>
                        </div>
                        <div id="ratingText" class="rating-text">请选择评分</div>
                    </div>
                </div>
                
                <div class="form-group">
                    <label>📝 评价内容</label>
                    <textarea name="content" required placeholder="请分享您的服务体验，您的评价将帮助我们改进服务质量..."></textarea>
                </div>
                
                <div class="btn-group">
                    <button type="submit" class="btn">✅ 提交评价</button>
                    <a href="${pageContext.request.contextPath}/order?action=my" class="btn btn-secondary">取消</a>
                </div>
            </form>
        </div>
    </div>
    <script>
        var ratingTexts = ['', '非常不满意', '不满意', '一般', '满意', '非常满意'];
        function updateRating(rating) {
            document.getElementById('ratingText').textContent = ratingTexts[rating];
        }
    </script>
</body>
</html>
