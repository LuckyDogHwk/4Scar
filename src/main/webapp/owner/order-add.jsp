<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=3.0">
    <title>预约服务 - 汽车4S店售后管理系统</title>
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
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; color: #333; font-weight: 600; font-size: 14px; }
        .form-group select, .form-group input, .form-group textarea { width: 100%; padding: 14px 18px; border: 2px solid #eee; border-radius: 12px; font-size: 15px; transition: all 0.3s; background: #fafafa; }
        .form-group select:focus, .form-group input:focus, .form-group textarea:focus { outline: none; border-color: #667eea; background: white; box-shadow: 0 0 0 4px rgba(102,126,234,0.1); }
        .form-group textarea { height: 120px; resize: vertical; }
        .service-types { display: grid; grid-template-columns: repeat(4, 1fr); gap: 10px; margin-bottom: 20px; }
        .service-type { padding: 15px; border: 2px solid #eee; border-radius: 12px; text-align: center; cursor: pointer; transition: all 0.3s; }
        .service-type:hover { border-color: #667eea; background: rgba(102,126,234,0.05); }
        .service-type.selected { border-color: #667eea; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; }
        .service-type-icon { font-size: 28px; margin-bottom: 5px; }
        .service-type-name { font-size: 13px; font-weight: 600; }
        .btn-group { display: flex; gap: 15px; margin-top: 30px; }
        .btn { flex: 1; padding: 16px 30px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border: none; border-radius: 12px; cursor: pointer; font-size: 16px; font-weight: 600; transition: all 0.3s; text-decoration: none; text-align: center; }
        .btn:hover { transform: translateY(-2px); box-shadow: 0 5px 20px rgba(102,126,234,0.4); }
        .btn-secondary { background: #e0e0e0; color: #666; }
        .btn-secondary:hover { background: #d0d0d0; box-shadow: none; }
        .car-preview { display: flex; align-items: center; gap: 15px; padding: 15px; background: #f8f9fa; border-radius: 12px; margin-top: 10px; }
        .car-preview-img { width: 80px; height: 60px; object-fit: cover; border-radius: 8px; }
        .car-preview-info { flex: 1; }
        .car-preview-brand { font-weight: 700; color: #333; }
        .car-preview-plate { font-size: 13px; color: #888; }
        @media (max-width: 600px) { .form-row { grid-template-columns: 1fr; } .service-types { grid-template-columns: repeat(2, 1fr); } }
    </style>
</head>
<body>
    <div class="header">
        <h1>🚗 汽车4S店售后管理系统</h1>
        <a href="${pageContext.request.contextPath}/order?action=my">← 返回订单列表</a>
    </div>
    <div class="container">
        <h2 class="page-title">📅 预约服务</h2>
        <div class="card">
            <h2>🔧 填写预约信息</h2>
            <form action="${pageContext.request.contextPath}/order" method="post" id="orderForm">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="serviceType" id="serviceTypeInput">
                
                <div class="form-group">
                    <label>🚗 选择车辆 *</label>
                    <select name="carId" required onchange="updateCarPreview(this)">
                        <option value="">请选择车辆</option>
                        <c:forEach var="car" items="${cars}">
                            <option value="${car.id}" data-brand="${car.brand} ${car.model}" data-plate="${car.plateNumber}" data-image="${car.imageUrl}">${car.plateNumber} - ${car.brand} ${car.model}</option>
                        </c:forEach>
                    </select>
                    <div id="carPreview" class="car-preview" style="display: none;">
                        <img id="carPreviewImg" class="car-preview-img" src="" alt="">
                        <div class="car-preview-info">
                            <div id="carPreviewBrand" class="car-preview-brand"></div>
                            <div id="carPreviewPlate" class="car-preview-plate"></div>
                        </div>
                    </div>
                </div>
                
                <label style="display: block; margin-bottom: 10px; color: #333; font-weight: 600; font-size: 14px;">🔧 服务类型 *</label>
                <div class="service-types">
                    <div class="service-type" onclick="selectServiceType(this, '维修')">
                        <div class="service-type-icon">🔧</div>
                        <div class="service-type-name">维修</div>
                    </div>
                    <div class="service-type" onclick="selectServiceType(this, '保养')">
                        <div class="service-type-icon">🛠️</div>
                        <div class="service-type-name">保养</div>
                    </div>
                    <div class="service-type" onclick="selectServiceType(this, '年检')">
                        <div class="service-type-icon">📋</div>
                        <div class="service-type-name">年检</div>
                    </div>
                    <div class="service-type" onclick="selectServiceType(this, '保险')">
                        <div class="service-type-icon">🛡️</div>
                        <div class="service-type-name">保险</div>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>📅 预约时间</label>
                        <input type="datetime-local" name="appointmentTime">
                    </div>
                </div>
                
                <div class="form-group">
                    <label>📝 服务内容描述</label>
                    <textarea name="serviceContent" placeholder="请详细描述需要服务的内容，如故障现象、保养需求等..."></textarea>
                </div>
                
                <div class="btn-group">
                    <button type="submit" class="btn">✅ 提交预约</button>
                    <a href="${pageContext.request.contextPath}/order?action=my" class="btn btn-secondary">取消</a>
                </div>
            </form>
        </div>
    </div>
    <script>
        function selectServiceType(el, type) {
            document.querySelectorAll('.service-type').forEach(e => e.classList.remove('selected'));
            el.classList.add('selected');
            document.getElementById('serviceTypeInput').value = type;
        }
        function updateCarPreview(select) {
            var option = select.options[select.selectedIndex];
            var preview = document.getElementById('carPreview');
            if (select.value) {
                document.getElementById('carPreviewImg').src = option.dataset.image || '';
                document.getElementById('carPreviewBrand').textContent = option.dataset.brand;
                document.getElementById('carPreviewPlate').textContent = option.dataset.plate;
                preview.style.display = 'flex';
            } else {
                preview.style.display = 'none';
            }
        }
    </script>
</body>
</html>
