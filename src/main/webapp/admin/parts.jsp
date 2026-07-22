<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=3.0">
    <title>配件管理 - 汽车4S店售后管理系统</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        .header { 
            background: rgba(255,255,255,0.1); 
            backdrop-filter: blur(10px);
            color: white; 
            padding: 15px 30px; 
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid rgba(255,255,255,0.2);
        }
        .header h1 { font-size: 22px; font-weight: 600; }
        .header a { color: white; text-decoration: none; opacity: 0.9; transition: opacity 0.3s; }
        .header a:hover { opacity: 1; }
        .container { max-width: 1400px; margin: 0 auto; padding: 20px; }
        .nav { 
            display: flex; 
            gap: 10px; 
            margin-bottom: 25px;
            flex-wrap: wrap;
        }
        .nav a { 
            padding: 12px 24px; 
            background: rgba(255,255,255,0.2); 
            color: white; 
            text-decoration: none; 
            border-radius: 25px;
            backdrop-filter: blur(5px);
            transition: all 0.3s;
            font-weight: 500;
        }
        .nav a:hover, .nav a.active { 
            background: white; 
            color: #667eea;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }
        .page-title {
            color: white;
            font-size: 28px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }
        .search-form { 
            display: flex; 
            gap: 10px; 
            margin-bottom: 25px;
        }
        .search-form input { 
            padding: 14px 20px; 
            border: none; 
            border-radius: 25px;
            width: 300px;
            font-size: 14px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .search-form input:focus {
            outline: none;
            box-shadow: 0 4px 20px rgba(0,0,0,0.2);
        }
        .search-form button { 
            padding: 14px 28px; 
            background: white; 
            color: #667eea;
            border: none; 
            border-radius: 25px; 
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
        }
        .search-form button:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(255,255,255,0.3);
        }
        .btn { 
            padding: 12px 24px; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white; 
            border: none; 
            border-radius: 10px; 
            cursor: pointer; 
            text-decoration: none; 
            display: inline-block;
            font-weight: 600;
            transition: all 0.3s;
        }
        .btn:hover { 
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102,126,234,0.4);
        }
        .btn-success { 
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
        }
        .btn-success:hover {
            box-shadow: 0 5px 20px rgba(17,153,142,0.4);
        }
        .btn-danger { 
            background: linear-gradient(135deg, #eb3349 0%, #f45c43 100%);
        }
        .btn-danger:hover {
            box-shadow: 0 5px 20px rgba(235,51,73,0.4);
        }
        .btn-sm {
            padding: 8px 16px;
            font-size: 13px;
        }
        .parts-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
        }
        .part-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 40px rgba(0,0,0,0.15);
            transition: all 0.3s;
        }
        .part-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 50px rgba(0,0,0,0.25);
        }
        .part-image {
            width: 100%;
            height: 180px;
            object-fit: cover;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        }
        .part-content { padding: 20px; }
        .part-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 15px;
        }
        .part-name {
            font-size: 18px;
            font-weight: 700;
            color: #333;
        }
        .part-no {
            font-size: 12px;
            color: #888;
            margin-top: 5px;
        }
        .part-price {
            font-size: 22px;
            font-weight: 700;
            color: #667eea;
        }
        .part-price small {
            font-size: 14px;
            color: #888;
        }
        .part-info {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
            margin-bottom: 15px;
        }
        .info-item {
            display: flex;
            flex-direction: column;
        }
        .info-label {
            font-size: 12px;
            color: #999;
        }
        .info-value {
            font-size: 14px;
            color: #333;
            font-weight: 500;
        }
        .stock-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: 600;
        }
        .stock-high {
            background: #d4edda;
            color: #155724;
        }
        .stock-medium {
            background: #fff3cd;
            color: #856404;
        }
        .stock-low {
            background: #f8d7da;
            color: #721c24;
        }
        .part-actions {
            display: flex;
            gap: 10px;
            padding-top: 15px;
            border-top: 1px solid #eee;
        }
        .part-actions .btn {
            flex: 1;
            text-align: center;
        }
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: white;
        }
        .empty-state h3 {
            font-size: 24px;
            margin-bottom: 10px;
        }
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
            <a href="${pageContext.request.contextPath}/part?action=list" class="active">🔧 配件管理</a>
            <a href="${pageContext.request.contextPath}/complaint?action=list">📝 投诉处理</a>
            <a href="${pageContext.request.contextPath}/review?action=list">⭐ 评价管理</a>
        </div>
        
        <div class="page-header">
            <h2 class="page-title">配件管理</h2>
            <a href="${pageContext.request.contextPath}/admin/part-add.jsp" class="btn btn-success">➕ 添加配件</a>
        </div>
        
        <form class="search-form" action="${pageContext.request.contextPath}/part" method="get">
            <input type="hidden" name="action" value="search">
            <input type="text" name="keyword" placeholder="搜索配件编号、名称或品牌..." value="${keyword}">
            <button type="submit">🔍 搜索</button>
        </form>
        
        <c:choose>
            <c:when test="${not empty parts}">
                <div class="parts-grid">
                    <c:forEach var="part" items="${parts}">
                        <div class="part-card">
                            <img src="${not empty part.imageUrl ? part.imageUrl : ''}" 
                                 alt="${part.partName}" 
                                 class="part-image"
                                 onerror="this.src=''">
                            <div class="part-content">
                                <div class="part-header">
                                    <div>
                                        <div class="part-name">${part.partName}</div>
                                        <div class="part-no">${part.partNo}</div>
                                    </div>
                                    <div class="part-price">
                                        ¥${part.price}
                                        <small>/件</small>
                                    </div>
                                </div>
                                <div class="part-info">
                                    <div class="info-item">
                                        <span class="info-label">品牌</span>
                                        <span class="info-value">${part.brand}</span>
                                    </div>
                                    <div class="info-item">
                                        <span class="info-label">适用车型</span>
                                        <span class="info-value">${part.model}</span>
                                    </div>
                                    <div class="info-item">
                                        <span class="info-label">库存</span>
                                        <span class="stock-badge ${part.stock >= 50 ? 'stock-high' : (part.stock >= 20 ? 'stock-medium' : 'stock-low')}">${part.stock} 件</span>
                                    </div>
                                </div>
                                <div class="part-actions">
                                    <a href="${pageContext.request.contextPath}/part?action=edit&id=${part.id}" class="btn btn-sm">编辑</a>
                                    <a href="${pageContext.request.contextPath}/part?action=delete&id=${part.id}" 
                                       class="btn btn-danger btn-sm" 
                                       onclick="return confirm('确定要删除这个配件吗？')">删除</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <h3>暂无配件数据</h3>
                    <p>点击上方按钮添加第一个配件</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
