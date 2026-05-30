<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=3.0">
    <title>编辑车辆 - 汽车4S店售后管理系统</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; }
        .header { background: rgba(255,255,255,0.1); backdrop-filter: blur(10px); color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid rgba(255,255,255,0.2); }
        .header h1 { font-size: 22px; font-weight: 600; }
        .header a { color: white; text-decoration: none; opacity: 0.9; transition: opacity 0.3s; }
        .header a:hover { opacity: 1; }
        .container { max-width: 900px; margin: 0 auto; padding: 20px; }
        .page-title { color: white; font-size: 28px; margin-bottom: 25px; text-shadow: 0 2px 4px rgba(0,0,0,0.2); }
        .card { background: white; border-radius: 20px; padding: 35px; box-shadow: 0 10px 40px rgba(0,0,0,0.15); }
        .card h2 { margin-bottom: 25px; color: #333; font-size: 22px; display: flex; align-items: center; gap: 10px; }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; color: #333; font-weight: 600; font-size: 14px; }
        .form-group input, .form-group select { width: 100%; padding: 14px 18px; border: 2px solid #eee; border-radius: 12px; font-size: 15px; transition: all 0.3s; background: #fafafa; }
        .form-group input:focus, .form-group select:focus { outline: none; border-color: #667eea; background: white; box-shadow: 0 0 0 4px rgba(102,126,234,0.1); }
        .btn-group { display: flex; gap: 15px; margin-top: 30px; }
        .btn { flex: 1; padding: 16px 30px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border: none; border-radius: 12px; cursor: pointer; font-size: 16px; font-weight: 600; transition: all 0.3s; text-decoration: none; text-align: center; }
        .btn:hover { transform: translateY(-2px); box-shadow: 0 5px 20px rgba(102,126,234,0.4); }
        .btn-secondary { background: #e0e0e0; color: #666; }
        .btn-secondary:hover { background: #d0d0d0; box-shadow: none; }
        .image-section { margin-top: 25px; padding-top: 25px; border-top: 1px solid #eee; }
        .image-preview-container { display: flex; gap: 20px; align-items: flex-start; }
        .image-preview { width: 280px; height: 180px; border-radius: 15px; object-fit: cover; background: #f5f5f5; border: 2px dashed #ddd; display: flex; align-items: center; justify-content: center; color: #999; overflow: hidden; }
        .image-preview img { width: 100%; height: 100%; object-fit: cover; }
        .image-input-section { flex: 1; }
        .image-tips { background: #e8f4fd; padding: 15px; border-radius: 10px; margin-top: 15px; }
        .image-tips h4 { color: #1976d2; margin-bottom: 8px; font-size: 14px; }
        .image-tips ul { margin-left: 20px; font-size: 13px; color: #666; }
        .image-tips li { margin-bottom: 5px; }
        .sample-images { margin-top: 15px; }
        .sample-images h4 { font-size: 14px; color: #666; margin-bottom: 10px; }
        .sample-images-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 10px; }
        .sample-image { width: 100%; height: 60px; object-fit: cover; border-radius: 8px; cursor: pointer; border: 2px solid transparent; transition: all 0.3s; }
        .sample-image:hover { border-color: #667eea; transform: scale(1.05); }
        @media (max-width: 600px) { .form-row { grid-template-columns: 1fr; } .image-preview-container { flex-direction: column; } .image-preview { width: 100%; } }
    </style>
</head>
<body>
    <div class="header">
        <h1>🚗 汽车4S店售后管理系统</h1>
        <a href="${pageContext.request.contextPath}/car?action=my">← 返回车辆列表</a>
    </div>
    <div class="container">
        <h2 class="page-title">🚗 编辑车辆</h2>
        <div class="card">
            <h2>✏️ 编辑车辆信息</h2>
            <form action="${pageContext.request.contextPath}/car" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" value="${car.id}">
                
                <div class="form-row">
                    <div class="form-group">
                        <label>🚗 车牌号码 *</label>
                        <input type="text" name="plateNumber" value="${car.plateNumber}" required>
                    </div>
                    <div class="form-group">
                        <label>📅 购买时间</label>
                        <input type="date" name="purchaseDate" value="${car.purchaseDate}">
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>🚙 品牌 *</label>
                        <input type="text" name="brand" value="${car.brand}" required>
                    </div>
                    <div class="form-group">
                        <label>📋 车型 *</label>
                        <input type="text" name="model" value="${car.model}" required>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>🔢 车辆识别码(VIN)</label>
                        <input type="text" name="vin" value="${car.vin}">
                    </div>
                    <div class="form-group">
                        <label>🔧 保养周期(公里)</label>
                        <input type="number" name="maintenanceCycle" value="${car.maintenanceCycle}">
                    </div>
                </div>
                
                <div class="image-section">
                    <h3 style="margin-bottom: 15px; color: #333;">📷 车辆图片</h3>
                    <div class="image-preview-container">
                        <div class="image-preview" id="imagePreview">
                            <c:choose>
                                <c:when test="${not empty car.imageUrl}">
                                    <img id="previewImg" src="${car.imageUrl}" onerror="this.parentElement.innerHTML='<span>⚠️ 图片加载失败</span>'">
                                </c:when>
                                <c:otherwise>
                                    <span id="previewText">🚗 车辆预览</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="image-input-section">
                            <div class="form-group" style="margin-bottom: 0;">
                                <label>🖼️ 图片地址</label>
                                <input type="url" name="imageUrl" id="imageUrl" value="${car.imageUrl}" placeholder="输入图片URL地址" onchange="previewImage(this.value)">
                            </div>
                            <div class="image-tips">
                                <h4>💡 图片提示</h4>
                                <ul>
                                    <li>请输入车辆图片的网络地址(URL)</li>
                                    <li>推荐使用车辆侧面或正面照片</li>
                                    <li>支持 jpg、png、webp 格式</li>
                                    <li>可以点击下方示例图片快速选择</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    
                    <div class="sample-images">
                        <h4>📷 示例图片（点击选择）</h4>
                        <div class="sample-images-grid">
                            <img class="sample-image" src="https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?w=200&q=80" onclick="selectImage(this.src.replace('w=200', 'w=400'))" title="奔驰">
                            <img class="sample-image" src="https://images.unsplash.com/photo-1555215695-3004980ad54e?w=200&q=80" onclick="selectImage(this.src.replace('w=200', 'w=400'))" title="宝马">
                            <img class="sample-image" src="https://images.unsplash.com/photo-1606664515524-ed2f786a0bd6?w=200&q=80" onclick="selectImage(this.src.replace('w=200', 'w=400'))" title="奥迪">
                            <img class="sample-image" src="https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=200&q=80" onclick="selectImage(this.src.replace('w=200', 'w=400'))" title="保时捷">
                            <img class="sample-image" src="https://images.unsplash.com/photo-1560958089-b8a1929cea89?w=200&q=80" onclick="selectImage(this.src.replace('w=200', 'w=400'))" title="特斯拉">
                            <img class="sample-image" src="https://images.unsplash.com/photo-1619682817481-e994891cd1f5?w=200&q=80" onclick="selectImage(this.src.replace('w=200', 'w=400'))" title="雷克萨斯">
                            <img class="sample-image" src="https://images.unsplash.com/photo-1617814076367-b759c7d7e738?w=200&q=80" onclick="selectImage(this.src.replace('w=200', 'w=400'))" title="沃尔沃">
                            <img class="sample-image" src="https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=200&q=80" onclick="selectImage(this.src.replace('w=200', 'w=400'))" title="凯迪拉克">
                        </div>
                    </div>
                </div>
                
                <div class="btn-group">
                    <button type="submit" class="btn">✅ 保存修改</button>
                    <a href="${pageContext.request.contextPath}/car?action=my" class="btn btn-secondary">取消</a>
                </div>
            </form>
        </div>
    </div>
    <script>
        function previewImage(url) {
            var preview = document.getElementById('imagePreview');
            if (url && url.trim() !== '') {
                preview.innerHTML = '<img id="previewImg" src="' + url + '" onerror="this.parentElement.innerHTML=\'<span>⚠️ 图片加载失败</span>\'">';
            } else {
                preview.innerHTML = '<span id="previewText">🚗 车辆预览</span>';
            }
        }
        function selectImage(url) {
            document.getElementById('imageUrl').value = url;
            previewImage(url);
        }
    </script>
</body>
</html>
