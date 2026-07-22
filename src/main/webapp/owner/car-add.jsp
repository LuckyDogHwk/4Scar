<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=3.0">
    <title>添加车辆 - 汽车4S店售后管理系统</title>
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
        .error-msg { background: #f8d7da; color: #721c24; padding: 15px; border-radius: 10px; margin-bottom: 20px; }
        .image-section { margin-top: 25px; padding-top: 25px; border-top: 1px solid #eee; }
        .image-preview-container { display: flex; gap: 20px; align-items: flex-start; }
        .image-preview { width: 280px; height: 180px; border-radius: 15px; object-fit: cover; background: #f5f5f5; border: 2px dashed #ddd; display: flex; align-items: center; justify-content: center; color: #999; }
        .image-preview img { width: 100%; height: 100%; object-fit: cover; border-radius: 13px; }
        .image-input-section { flex: 1; }
        .image-tips { background: #e8f4fd; padding: 15px; border-radius: 10px; margin-top: 15px; }
        .image-tips h4 { color: #1976d2; margin-bottom: 8px; font-size: 14px; }
        .image-tips ul { margin-left: 20px; font-size: 13px; color: #666; }
        .image-tips li { margin-bottom: 5px; }
        .sample-images { margin-top: 15px; }
        .sample-images h4 { font-size: 14px; color: #666; margin-bottom: 10px; }
        .sample-images-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 12px; }
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
        <h2 class="page-title">🚗 添加车辆</h2>
        <div class="card">
            <h2>➕ 添加车辆信息</h2>
            <% if (request.getAttribute("error") != null) { %>
                <div class="error-msg">${error}</div>
            <% } %>
            <form action="${pageContext.request.contextPath}/car" method="post">
                <input type="hidden" name="action" value="add">
                
                <div class="form-row">
                    <div class="form-group">
                        <label>🚗 车牌号码 *</label>
                        <input type="text" name="plateNumber" required placeholder="如：京A12345">
                    </div>
                    <div class="form-group">
                        <label>📅 购买时间</label>
                        <input type="date" name="purchaseDate">
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>🚙 品牌 *</label>
                        <input type="text" name="brand" required placeholder="如：奔驰、宝马、奥迪" list="brandList">
                        <datalist id="brandList">
                            <option value="奔驰"><option value="宝马"><option value="奥迪"><option value="大众">
                            <option value="丰田"><option value="本田"><option value="日产"><option value="马自达">
                            <option value="福特"><option value="雪佛兰"><option value="特斯拉"><option value="比亚迪">
                            <option value="蔚来"><option value="小鹏"><option value="理想"><option value="保时捷">
                            <option value="路虎"><option value="沃尔沃"><option value="凯迪拉克"><option value="雷克萨斯">
                        </datalist>
                    </div>
                    <div class="form-group">
                        <label>📋 车型 *</label>
                        <input type="text" name="model" required placeholder="如：E300L、X5、A6L">
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>🔢 车辆识别码(VIN)</label>
                        <input type="text" name="vin" placeholder="17位车辆识别码">
                    </div>
                    <div class="form-group">
                        <label>🔧 保养周期(公里)</label>
                        <input type="number" name="maintenanceCycle" value="5000" placeholder="默认5000公里">
                    </div>
                </div>
                
                <div class="image-section">
                    <h3 style="margin-bottom: 15px; color: #333;">📷 车辆图片</h3>
                    <div class="image-preview-container">
                        <div class="image-preview" id="imagePreview">
                            <span id="previewText">🚗 车辆预览</span>
                            <img id="previewImg" src="" style="display: none;">
                        </div>
                        <div class="image-input-section">
                            <div class="form-group" style="margin-bottom: 0;">
                                <label>🖼️ 图片地址</label>
                                <input type="url" name="imageUrl" id="imageUrl" placeholder="输入图片URL地址" onchange="previewImage(this.value)">
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
                        <h4>📷 车辆示例（点击选择）</h4>
                        <div class="sample-images-grid">
                            <!-- 第一排：超跑系列 -->
                            <img class="sample-image" src="" onclick="selectImage(this.src.replace('w=200', 'w=400'))" title="兰博基尼">
                            <img class="sample-image" src="" onclick="selectImage(this.src.replace('w=200', 'w=400'))" title="法拉利">
                            <img class="sample-image" src="" onclick="selectImage(this.src.replace('w=200', 'w=400'))" title="迈凯伦">
                            <img class="sample-image" src="" onclick="selectImage(this.src.replace('w=200', 'w=400'))" title="保时捷911">
                            <!-- 第二排：德系豪华轿车 -->
                            <img class="sample-image" src="" onclick="selectImage(this.src.replace('w=200', 'w=400'))" title="奔驰S级">
                            <img class="sample-image" src="" onclick="selectImage(this.src.replace('w=200', 'w=400'))" title="宝马7系">
                            <img class="sample-image" src="" onclick="selectImage(this.src.replace('w=200', 'w=400'))" title="奥迪A6">
                            <img class="sample-image" src="" onclick="selectImage(this.src.replace('w=200', 'w=400'))" title="劳斯莱斯">
                            <!-- 第三排：豪华SUV -->
                            <img class="sample-image" src="" onclick="selectImage(this.src.replace('w=200', 'w=400'))" title="奔驰G级">
                            <img class="sample-image" src="" onclick="selectImage(this.src.replace('w=200', 'w=400'))" title="路虎揽胜">
                            <img class="sample-image" src="" onclick="selectImage(this.src.replace('w=200', 'w=400'))" title="宾利添越">
                            <img class="sample-image" src="" onclick="selectImage(this.src.replace('w=200', 'w=400'))" title="保时捷卡宴">
                            <!-- 第四排：美系/日系/其他豪车 -->
                            <img class="sample-image" src="" onclick="selectImage(this.src.replace('w=200', 'w=400'))" title="凯迪拉克">
                            <img class="sample-image" src="" onclick="selectImage(this.src.replace('w=200', 'w=400'))" title="雷克萨斯">
                            <img class="sample-image" src="" onclick="selectImage(this.src.replace('w=200', 'w=400'))" title="沃尔沃">
                            <img class="sample-image" src="" onclick="selectImage(this.src.replace('w=200', 'w=400'))" title="玛莎拉蒂">
                        </div>
                    </div>
                </div>
                
                <div class="btn-group">
                    <button type="submit" class="btn">✅ 保存车辆</button>
                    <a href="${pageContext.request.contextPath}/car?action=my" class="btn btn-secondary">取消</a>
                </div>
            </form>
        </div>
    </div>
    <script>
        function previewImage(url) {
            var previewImg = document.getElementById('previewImg');
            var previewText = document.getElementById('previewText');
            if (url && url.trim() !== '') {
                previewImg.src = url;
                previewImg.style.display = 'block';
                previewText.style.display = 'none';
                previewImg.onerror = function() {
                    previewImg.style.display = 'none';
                    previewText.style.display = 'block';
                    previewText.textContent = '⚠️ 图片加载失败';
                };
            } else {
                previewImg.style.display = 'none';
                previewText.style.display = 'block';
                previewText.textContent = '🚗 车辆预览';
            }
        }
        function selectImage(url) {
            document.getElementById('imageUrl').value = url;
            previewImage(url);
        }
    </script>
</body>
</html>
