<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=3.0">
    <title>处理订单 - 汽车4S店售后管理系统</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif; background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); min-height: 100vh; }
        .header { background: rgba(255,255,255,0.1); backdrop-filter: blur(10px); color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid rgba(255,255,255,0.2); }
        .header h1 { font-size: 22px; font-weight: 600; }
        .header a { color: white; text-decoration: none; opacity: 0.9; transition: opacity 0.3s; }
        .header a:hover { opacity: 1; }
        .container { max-width: 900px; margin: 0 auto; padding: 20px; }
        .page-title { color: white; font-size: 28px; margin-bottom: 25px; text-shadow: 0 2px 4px rgba(0,0,0,0.2); }
        .card { background: white; border-radius: 20px; padding: 30px; margin-bottom: 25px; box-shadow: 0 10px 40px rgba(0,0,0,0.15); }
        .card h2 { margin-bottom: 20px; color: #333; font-size: 20px; display: flex; align-items: center; gap: 10px; }
        .order-header-info { display: flex; justify-content: space-between; align-items: center; padding-bottom: 20px; border-bottom: 1px solid #eee; margin-bottom: 20px; }
        .order-no { font-size: 18px; font-weight: 700; color: #333; }
        .status-badge { padding: 8px 16px; border-radius: 20px; font-size: 14px; font-weight: 600; }
        .status-pending { background: #fff3cd; color: #856404; }
        .status-processing { background: #cce5ff; color: #004085; }
        .status-completed { background: #d4edda; color: #155724; }
        .info-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 25px; }
        .info-item { display: flex; flex-direction: column; }
        .info-label { font-size: 12px; color: #888; margin-bottom: 5px; text-transform: uppercase; }
        .info-value { font-size: 16px; color: #333; font-weight: 500; }
        .car-section { display: flex; align-items: center; gap: 20px; padding: 20px; background: #f8f9fa; border-radius: 15px; margin-bottom: 25px; }
        .car-icon { font-size: 50px; }
        .car-details h3 { font-size: 20px; color: #333; margin-bottom: 5px; }
        .car-details p { font-size: 14px; color: #888; }
        .service-content { padding: 20px; background: #fff8e1; border-radius: 15px; margin-bottom: 25px; border-left: 4px solid #ffc107; }
        .service-content h4 { color: #856404; margin-bottom: 10px; }
        .service-content p { color: #333; line-height: 1.6; }
        .form-section { margin-top: 25px; padding-top: 25px; border-top: 1px solid #eee; }
        .form-section h3 { margin-bottom: 20px; color: #333; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; color: #333; font-weight: 600; font-size: 14px; }
        .form-group input, .form-group textarea, .form-group select { width: 100%; padding: 14px 18px; border: 2px solid #eee; border-radius: 12px; font-size: 15px; transition: all 0.3s; background: #fafafa; }
        .form-group input:focus, .form-group textarea:focus, .form-group select:focus { outline: none; border-color: #11998e; background: white; box-shadow: 0 0 0 4px rgba(17,153,142,0.1); }
        .form-group textarea { height: 120px; resize: vertical; }
        .btn-group { display: flex; gap: 15px; margin-top: 25px; }
        .btn { flex: 1; padding: 16px 30px; background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); color: white; border: none; border-radius: 12px; cursor: pointer; font-size: 16px; font-weight: 600; transition: all 0.3s; text-decoration: none; text-align: center; }
        .btn:hover { transform: translateY(-2px); box-shadow: 0 5px 20px rgba(17,153,142,0.4); }
        .btn-primary { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
        .btn-primary:hover { box-shadow: 0 5px 20px rgba(102,126,234,0.4); }
        .btn-success { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); }
        .btn-secondary { background: #e0e0e0; color: #666; }
        .btn-secondary:hover { background: #d0d0d0; box-shadow: none; }
        .amount-display { font-size: 28px; font-weight: 700; color: #11998e; text-align: right; }
        .parts-section { margin-top: 20px; }
        .parts-list { margin-top: 10px; }
        .part-item { display: flex; justify-content: space-between; align-items: center; padding: 10px 15px; background: #f8f9fa; border-radius: 8px; margin-bottom: 8px; }
        .part-name { font-weight: 500; }
        .part-price { color: #11998e; font-weight: 600; }
        @media (max-width: 600px) { .info-grid { grid-template-columns: 1fr; } .btn-group { flex-direction: column; } }
    </style>
</head>
<body>
    <div class="header">
        <h1>🔧 处理订单</h1>
        <a href="${pageContext.request.contextPath}/order?action=my">← 返回我的工单</a>
    </div>
    <div class="container">
        <h2 class="page-title">🔧 订单处理</h2>
        
        <div class="card">
            <div class="order-header-info">
                <span class="order-no">📋 ${order.orderNo}</span>
                <span class="status-badge status-${order.status}">
                    <c:choose>
                        <c:when test="${order.status == 'pending'}">⏳ 待接单</c:when>
                        <c:when test="${order.status == 'processing'}">🔧 处理中</c:when>
                        <c:when test="${order.status == 'completed'}">✅ 已完成</c:when>
                    </c:choose>
                </span>
            </div>
            
            <div class="car-section">
                <div class="car-icon">🚗</div>
                <div class="car-details">
                    <h3>${order.carInfo}</h3>
                    <p>车主: ${order.ownerName} | 车牌: ${order.carPlateNumber}</p>
                </div>
            </div>
            
            <div class="info-grid">
                <div class="info-item">
                    <span class="info-label">服务类型</span>
                    <span class="info-value">${order.serviceType}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">预约时间</span>
                    <span class="info-value">${order.appointmentTime}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">接单技师</span>
                    <span class="info-value">${not empty order.mechanicName ? order.mechanicName : '未分配'}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">当前金额</span>
                    <span class="info-value amount-display">¥${order.orderAmount}</span>
                </div>
            </div>
            
            <div class="service-content">
                <h4>📝 服务需求描述</h4>
                <p>${order.serviceContent}</p>
            </div>
            
            <c:if test="${order.status == 'processing'}">
                <div class="form-section">
                    <h3>🔧 完成维修服务</h3>
                    <form action="${pageContext.request.contextPath}/order" method="post">
                        <input type="hidden" name="action" value="complete">
                        <input type="hidden" name="id" value="${order.id}">
                        
                        <div class="form-group">
                            <label>🔧 维修内容记录</label>
                            <textarea name="serviceContent" placeholder="请记录维修过程和更换的配件...">${order.serviceContent}</textarea>
                        </div>
                        
                        <div class="form-group">
                            <label>💰 服务金额 (元)</label>
                            <input type="number" name="amount" step="0.01" value="${order.orderAmount}" placeholder="请输入服务总金额">
                        </div>
                        
                        <div class="btn-group">
                            <button type="submit" class="btn btn-success" onclick="return confirm('确定要完成这个订单吗？')">✅ 完成订单</button>
                            <a href="${pageContext.request.contextPath}/order?action=my" class="btn btn-secondary">取消</a>
                        </div>
                    </form>
                </div>
            </c:if>
            
            <c:if test="${order.status == 'pending'}">
                <div class="form-section">
                    <h3>📋 接单确认</h3>
                    <p style="color: #888; margin-bottom: 20px;">点击下方按钮接取此订单，接单后订单将进入处理中状态。</p>
                    <div class="btn-group">
                        <a href="${pageContext.request.contextPath}/order?action=accept&id=${order.id}" 
                           class="btn btn-success"
                           onclick="return confirm('确定要接取这个订单吗？')">
                            ✅ 接取订单
                        </a>
                        <a href="${pageContext.request.contextPath}/order?action=pending" class="btn btn-secondary">返回列表</a>
                    </div>
                </div>
            </c:if>
            
            <c:if test="${order.status == 'completed'}">
                <div class="form-section">
                    <h3>✅ 订单已完成</h3>
                    <div class="info-grid">
                        <div class="info-item">
                            <span class="info-label">完成时间</span>
                            <span class="info-value">${order.completeTime}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">最终金额</span>
                            <span class="info-value amount-display">¥${order.orderAmount}</span>
                        </div>
                    </div>
                    <div class="btn-group">
                        <a href="${pageContext.request.contextPath}/order?action=my" class="btn btn-primary">返回我的工单</a>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</body>
</html>
