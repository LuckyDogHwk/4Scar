-- 创建数据库
CREATE DATABASE IF NOT EXISTS car_4s DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE car_4s;

-- 用户表
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
    `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
    `username` VARCHAR(50) NOT NULL UNIQUE,
    `password` VARCHAR(100) NOT NULL,
    `real_name` VARCHAR(50),
    `phone` VARCHAR(20),
    `email` VARCHAR(100),
    `role` VARCHAR(20) DEFAULT 'owner',
    `status` INT DEFAULT 1,
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 车辆表
DROP TABLE IF EXISTS `car`;
CREATE TABLE `car` (
    `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
    `owner_id` BIGINT NOT NULL,
    `plate_number` VARCHAR(20) NOT NULL UNIQUE,
    `brand` VARCHAR(50) NOT NULL,
    `model` VARCHAR(50) NOT NULL,
    `purchase_date` DATE,
    `vin` VARCHAR(50),
    `maintenance_cycle` INT DEFAULT 5000,
    `last_maintenance_date` DATE,
    `image_url` VARCHAR(255),
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`owner_id`) REFERENCES `user`(`id`)
);

-- 服务订单表
DROP TABLE IF EXISTS `service_order`;
CREATE TABLE `service_order` (
    `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
    `order_no` VARCHAR(30) NOT NULL UNIQUE,
    `owner_id` BIGINT NOT NULL,
    `car_id` BIGINT NOT NULL,
    `mechanic_id` BIGINT,
    `appointment_time` DATETIME,
    `service_type` VARCHAR(50),
    `service_content` TEXT,
    `order_amount` DECIMAL(10,2) DEFAULT 0,
    `status` VARCHAR(20) DEFAULT 'pending',
    `complete_time` DATETIME,
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`owner_id`) REFERENCES `user`(`id`),
    FOREIGN KEY (`car_id`) REFERENCES `car`(`id`),
    FOREIGN KEY (`mechanic_id`) REFERENCES `user`(`id`)
);

-- 配件表
DROP TABLE IF EXISTS `part`;
CREATE TABLE `part` (
    `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
    `part_no` VARCHAR(50) NOT NULL UNIQUE,
    `part_name` VARCHAR(100) NOT NULL,
    `brand` VARCHAR(50),
    `model` VARCHAR(50),
    `price` DECIMAL(10,2) NOT NULL,
    `stock` INT DEFAULT 0,
    `description` TEXT,
    `image_url` VARCHAR(255),
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 评价表
DROP TABLE IF EXISTS `review`;
CREATE TABLE `review` (
    `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
    `order_id` BIGINT NOT NULL,
    `owner_id` BIGINT NOT NULL,
    `rating` INT NOT NULL,
    `content` TEXT,
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`order_id`) REFERENCES `service_order`(`id`),
    FOREIGN KEY (`owner_id`) REFERENCES `user`(`id`)
);

-- 留言表
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
    `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
    `owner_id` BIGINT NOT NULL,
    `title` VARCHAR(100) NOT NULL,
    `content` TEXT,
    `mechanic_id` BIGINT,
    `reply_content` TEXT,
    `reply_time` DATETIME,
    `status` VARCHAR(20) DEFAULT 'pending',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`owner_id`) REFERENCES `user`(`id`),
    FOREIGN KEY (`mechanic_id`) REFERENCES `user`(`id`)
);

-- 投诉表
DROP TABLE IF EXISTS `complaint`;
CREATE TABLE `complaint` (
    `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
    `owner_id` BIGINT NOT NULL,
    `order_id` BIGINT,
    `title` VARCHAR(100) NOT NULL,
    `content` TEXT,
    `handle_result` TEXT,
    `handle_time` DATETIME,
    `status` VARCHAR(20) DEFAULT 'pending',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`owner_id`) REFERENCES `user`(`id`),
    FOREIGN KEY (`order_id`) REFERENCES `service_order`(`id`)
);

-- 插入管理员
INSERT INTO `user`(`username`, `password`, `real_name`, `phone`, `email`, `role`, `status`) VALUES
('admin', 'admin123', '系统管理员', '13800138000', 'admin@car4s.com', 'admin', 1);

-- 插入维修人员
INSERT INTO `user`(`username`, `password`, `real_name`, `phone`, `email`, `role`, `status`) VALUES
('mechanic1', '123456', '张师傅', '13900139001', 'zhang@car4s.com', 'mechanic', 1),
('mechanic2', '123456', '李师傅', '13900139002', 'li@car4s.com', 'mechanic', 1),
('mechanic3', '123456', '王师傅', '13900139003', 'wang@car4s.com', 'mechanic', 1);

-- 插入车主 (15位车主)
INSERT INTO `user`(`username`, `password`, `real_name`, `phone`, `email`, `role`, `status`) VALUES
('owner1', '123456', '张三', '13800138001', 'zhangsan@email.com', 'owner', 1),
('owner2', '123456', '李四', '13800138002', 'lisi@email.com', 'owner', 1),
('owner3', '123456', '王五', '13800138003', 'wangwu@email.com', 'owner', 1),
('owner4', '123456', '赵六', '13800138004', 'zhaoliu@email.com', 'owner', 1),
('owner5', '123456', '钱七', '13800138005', 'qianqi@email.com', 'owner', 1),
('owner6', '123456', '孙八', '13800138006', 'sunba@email.com', 'owner', 1),
('owner7', '123456', '周九', '13800138007', 'zhoujiu@email.com', 'owner', 1),
('owner8', '123456', '吴十', '13800138008', 'wushi@email.com', 'owner', 1),
('owner9', '123456', '郑明', '13800138009', 'zhengming@email.com', 'owner', 1),
('owner10', '123456', '刘洋', '13800138010', 'liuyang@email.com', 'owner', 1),
('owner11', '123456', '陈华', '13800138011', 'chenhua@email.com', 'owner', 1),
('owner12', '123456', '林峰', '13800138012', 'linfeng@email.com', 'owner', 1),
('owner13', '123456', '黄磊', '13800138013', 'huanglei@email.com', 'owner', 1),
('owner14', '123456', '徐强', '13800138014', 'xuqiang@email.com', 'owner', 1),
('owner15', '123456', '马超', '13800138015', 'machao@email.com', 'owner', 1);

-- 插入车辆数据 (每个车主至少一辆车)
INSERT INTO `car`(`owner_id`, `plate_number`, `brand`, `model`, `purchase_date`, `vin`, `maintenance_cycle`, `last_maintenance_date`, `image_url`) VALUES
-- 车主1: 张三 - 奔驰E300L
(5, '京A12345', '奔驰', 'E300L', '2022-03-15', 'WDDZF4KB5JA123456', 10000, '2024-01-10', 'https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?w=400&q=80'),
-- 车主2: 李四 - 宝马530Li
(6, '京B88888', '宝马', '530Li', '2023-06-20', 'WBAJB0C51JB123457', 10000, '2024-02-15', 'https://images.unsplash.com/photo-1555215695-3004980ad54e?w=400&q=80'),
-- 车主3: 王五 - 奥迪A6L
(7, '京C66666', '奥迪', 'A6L', '2021-08-10', 'WAUZZZ4G5JN123458', 10000, '2023-12-20', 'https://images.unsplash.com/photo-1606664515524-ed2f786a0bd6?w=400&q=80'),
-- 车主4: 赵六 - 保时捷Cayenne
(8, '京D55555', '保时捷', 'Cayenne', '2023-01-05', 'WP1AA2A29JLA123459', 10000, '2024-03-01', 'https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=400&q=80'),
-- 车主5: 钱七 - 特斯拉Model 3
(9, '京E44444', '特斯拉', 'Model 3', '2023-09-18', '5YJ3E1EA8JF123460', 15000, '2024-01-25', 'https://images.unsplash.com/photo-1560958089-b8a1929cea89?w=400&q=80'),
-- 车主6: 孙八 - 雷克萨斯ES300h
(10, '京F33333', '雷克萨斯', 'ES300h', '2022-11-30', 'JTHBK1GG2E2123461', 10000, '2023-11-15', 'https://images.unsplash.com/photo-1619682817481-e994891cd1f5?w=400&q=80'),
-- 车主7: 周九 - 沃尔沃S90
(11, '京G22222', '沃尔沃', 'S90', '2023-04-22', 'YV4A22PK8N123462', 10000, '2024-02-28', 'https://images.unsplash.com/photo-1617814076367-b759c7d7e738?w=400&q=80'),
-- 车主8: 吴十 - 凯迪拉克CT6
(12, '京H11111', '凯迪拉克', 'CT6', '2022-07-08', '1G6AR5SX5J0123463', 10000, '2023-10-10', 'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=400&q=80'),
-- 车主9: 郑明 - 路虎揽胜运动
(13, '京J99999', '路虎', '揽胜运动', '2023-02-14', 'SALGA2VK3JA123464', 10000, '2024-01-05', 'https://images.unsplash.com/photo-1606016159991-dfe4f2746ad5?w=400&q=80'),
-- 车主10: 刘洋 - 玛莎拉蒂Ghibli
(14, '京K77777', '玛莎拉蒂', 'Ghibli', '2023-05-30', 'ZAM56RRA0J3123465', 10000, '2024-03-10', 'https://images.unsplash.com/photo-1544636331-e26879cd4d9b?w=400&q=80'),
-- 车主11: 陈华 - 丰田凯美瑞
(15, '京L65432', '丰田', '凯美瑞', '2022-05-18', 'JTDKN3DU5A0123466', 10000, '2024-02-20', 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=400&q=80'),
-- 车主12: 林峰 - 本田雅阁
(16, '京M54321', '本田', '雅阁', '2023-03-25', '1HGCV1F34JA0123467', 10000, '2024-01-15', 'https://images.unsplash.com/photo-1619682817481-e994891cd1f5?w=400&q=80'),
-- 车主13: 黄磊 - 日产天籁
(17, '京N43210', '日产', '天籁', '2022-09-12', 'JN1BV4AR9JM0123468', 10000, '2023-12-05', 'https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?w=400&q=80'),
-- 车主14: 徐强 - 大众帕萨特
(18, '京P32109', '大众', '帕萨特', '2023-07-08', 'WVWZZZ3CZJE0123469', 10000, '2024-03-18', 'https://images.unsplash.com/photo-1571290274554-6a2eaa771e5f?w=400&q=80'),
-- 车主15: 马超 - 福特蒙迪欧
(19, '京Q21098', '福特', '蒙迪欧', '2022-12-20', '1FADP5AU6JL0123470', 10000, '2024-02-08', 'https://images.unsplash.com/photo-1583121274602-3e2820c69888?w=400&q=80');

-- 为部分车主添加第二辆车
INSERT INTO `car`(`owner_id`, `plate_number`, `brand`, `model`, `purchase_date`, `vin`, `maintenance_cycle`, `last_maintenance_date`, `image_url`) VALUES
-- 张三的第二辆车 - 宝马X5
(5, '京A67890', '宝马', 'X5', '2023-08-15', 'WBAJB0C55JB123458', 10000, '2024-02-01', 'https://images.unsplash.com/photo-1556189250-72ba954cfc2b?w=400&q=80'),
-- 李四的第二辆车 - 奥迪Q7
(6, '京B98765', '奥迪', 'Q7', '2022-04-20', 'WAUZZZ4G9JN123459', 10000, '2023-11-20', 'https://images.unsplash.com/photo-1606664515524-ed2f786a0bd6?w=400&q=80'),
-- 王五的第二辆车 - 特斯拉Model Y
(7, '京C87654', '特斯拉', 'Model Y', '2023-11-10', '5YJYGDEF8MF123461', 15000, NULL, 'https://images.unsplash.com/photo-1619767886558-efdc259cde1a?w=400&q=80'),
-- 赵六的第二辆车 - 法拉利F8
(8, '京D76543', '法拉利', 'F8 Tributo', '2023-06-01', 'ZFF96LLA0J0123462', 10000, '2024-01-20', 'https://images.unsplash.com/photo-1592198084033-aade902d1aae?w=400&q=80'),
-- 钱七的第二辆车 - 蔚来ES8
(9, '京E65432', '蔚来', 'ES8', '2024-01-15', 'LSGA8DE1PJ0123463', 15000, NULL, 'https://images.unsplash.com/photo-1619767886558-efdc259cde1a?w=400&q=80');

-- 插入配件数据
INSERT INTO `part`(`part_no`, `part_name`, `brand`, `model`, `price`, `stock`, `description`, `image_url`) VALUES
('P001', '机油滤清器', '曼牌', 'W719/45', 68.00, 200, '高品质机油滤清器，适用于奔驰、宝马等车型', 'https://images.unsplash.com/photo-1486262715619-67b85e0b08d3?w=400&q=80'),
('P002', '空气滤清器', '马勒', 'LX3830', 128.00, 150, '高效空气过滤，保护发动机', 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&q=80'),
('P003', '刹车片', '博世', '0986AB2780', 358.00, 100, '陶瓷刹车片，低噪音高耐磨', 'https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?w=400&q=80'),
('P004', '火花塞', 'NGK', 'ILZKAR7B', 85.00, 300, '铱金火花塞，点火性能优异', 'https://images.unsplash.com/photo-1619642751034-765dfdf7c58e?w=400&q=80'),
('P005', '机油', '美孚', '全合成5W-40', 458.00, 80, '美孚1号全合成机油4L装', 'https://images.unsplash.com/photo-1635784063388-1ff609591528?w=400&q=80'),
('P006', '空调滤清器', '曼牌', 'CUK2939', 158.00, 120, '活性炭空调滤清器，有效过滤PM2.5', 'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=400&q=80'),
('P007', '雨刮片', '博世', 'Aerotwin', 188.00, 180, '无骨雨刮，静音效果好', 'https://images.unsplash.com/photo-1558618047-3c8c76ca7d13?w=400&q=80'),
('P008', '蓄电池', '瓦尔塔', '80D26L', 680.00, 50, '免维护蓄电池，质保2年', 'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=400&q=80'),
('P009', '轮胎', '米其林', 'PS4 225/45R18', 899.00, 40, '米其林竞驰系列，操控性能出色', 'https://images.unsplash.com/photo-1578844251758-2f71da64c96f?w=400&q=80'),
('P010', '变速箱油', '采埃孚', 'ATF', 398.00, 60, 'ZF原厂变速箱油，适用于8AT变速箱', 'https://images.unsplash.com/photo-1615906655593-ad0386982a0f?w=400&q=80'),
('P011', '冷却液', '大众', 'G12+', 128.00, 100, '长效防冻冷却液，-40°C防冻', 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&q=80'),
('P012', '刹车盘', '博世', '0986479057', 458.00, 60, '通风式刹车盘，散热性能好', 'https://images.unsplash.com/photo-1486262715619-67b85e0b08d3?w=400&q=80');

-- 插入服务订单
INSERT INTO `service_order`(`order_no`, `owner_id`, `car_id`, `mechanic_id`, `appointment_time`, `service_type`, `service_content`, `order_amount`, `status`, `complete_time`) VALUES
('ORD202401001', 5, 1, 2, '2024-01-10 09:00:00', '保养', '常规保养，更换机油、机滤、空滤', 680.00, 'completed', '2024-01-10 11:30:00'),
('ORD202401002', 6, 3, 3, '2024-01-12 10:00:00', '维修', '刹车片更换，四轮定位', 1580.00, 'completed', '2024-01-12 15:00:00'),
('ORD202401003', 7, 5, 2, '2024-01-15 14:00:00', '保养', '首保，全车检查', 0.00, 'completed', '2024-01-15 16:00:00'),
('ORD202401004', 8, 7, 3, '2024-01-18 09:30:00', '维修', '发动机故障灯亮，检查维修', 2200.00, 'completed', '2024-01-18 17:00:00'),
('ORD202401005', 9, 9, 2, '2024-01-20 11:00:00', '保养', '大保养，更换全车油液', 3500.00, 'completed', '2024-01-20 18:00:00'),
('ORD202401006', 10, 6, 3, '2024-01-22 10:00:00', '保养', '常规保养', 580.00, 'completed', '2024-01-22 12:00:00'),
('ORD202401007', 11, 8, 2, '2024-01-25 14:00:00', '维修', '更换刹车片', 1200.00, 'completed', '2024-01-25 16:30:00'),
('ORD202401008', 12, 10, 3, '2024-01-28 09:00:00', '保养', '常规保养，更换机油', 680.00, 'completed', '2024-01-28 11:00:00'),
('ORD202402001', 5, 2, NULL, '2024-02-15 10:00:00', '保养', '常规保养', 0.00, 'pending', NULL),
('ORD202402002', 6, 4, NULL, '2024-02-18 14:00:00', '维修', '空调不制冷，需要检查', 0.00, 'pending', NULL),
('ORD202402003', 7, 6, NULL, '2024-02-20 09:00:00', '年检', '车辆年检代办', 0.00, 'pending', NULL),
('ORD202402004', 13, 11, NULL, '2024-02-22 10:00:00', '保养', '常规保养', 0.00, 'pending', NULL),
('ORD202402005', 14, 12, NULL, '2024-02-25 14:00:00', '维修', '发动机异响检查', 0.00, 'pending', NULL),
('ORD202402006', 15, 13, NULL, '2024-02-28 09:00:00', '保养', '常规保养', 0.00, 'pending', NULL),
('ORD202402007', 16, 14, NULL, '2024-03-01 10:00:00', '保养', '首保', 0.00, 'pending', NULL),
('ORD202402008', 17, 15, NULL, '2024-03-05 14:00:00', '维修', '刹车系统检查', 0.00, 'pending', NULL),
('ORD202402009', 18, 16, NULL, '2024-03-08 09:00:00', '保养', '常规保养', 0.00, 'pending', NULL),
('ORD202402010', 19, 17, NULL, '2024-03-10 10:00:00', '保养', '常规保养', 0.00, 'pending', NULL);

-- 插入评价数据
INSERT INTO `review`(`order_id`, `owner_id`, `rating`, `content`) VALUES
(1, 5, 5, '张师傅技术很好，服务态度也很棒，保养做得非常仔细！'),
(2, 6, 4, '维修效率很高，价格也比较合理，下次还会来。'),
(3, 7, 5, '首保服务很专业，还免费洗了车，非常满意！'),
(4, 8, 4, '发动机问题解决了，就是等配件时间有点长。'),
(5, 9, 5, '大保养做得非常全面，价格透明，强烈推荐！'),
(6, 10, 5, '服务态度很好，环境也很干净，下次还来！'),
(7, 11, 4, '维修速度快，价格合理，很满意。'),
(8, 12, 5, '专业、高效、贴心，五星好评！');

-- 插入留言数据
INSERT INTO `message`(`owner_id`, `title`, `content`, `mechanic_id`, `reply_content`, `reply_time`, `status`) VALUES
(5, '关于保养周期的问题', '请问奔驰E300L的保养周期是多少公里？', 2, '您好，奔驰E300L建议每10000公里或1年进行一次常规保养，以先到为准。', '2024-01-20 10:30:00', 'replied'),
(6, '刹车异响咨询', '我的车刹车时有异响，是什么原因？', 3, '刹车异响可能由多种原因引起，如刹车片磨损、刹车盘变形等，建议到店检查。', '2024-01-22 14:15:00', 'replied'),
(7, '新能源车保养', '特斯拉Model 3需要做什么保养？', NULL, NULL, NULL, 'pending'),
(8, '轮胎更换咨询', '沃尔沃S90原厂轮胎是什么型号？', NULL, NULL, NULL, 'pending'),
(9, '电池续航问题', '我的电动车续航变短了，是什么原因？', NULL, NULL, NULL, 'pending'),
(10, '空调异味问题', '开空调有异味，需要怎么处理？', 2, '空调异味通常是由于蒸发器或风道内滋生细菌导致，建议进行空调系统清洗消毒。', '2024-02-01 09:30:00', 'replied'),
(11, '机油选择咨询', '沃尔沃S90应该用什么型号的机油？', NULL, NULL, NULL, 'pending'),
(12, '保养价格咨询', '凯迪拉克CT6大保养大概多少钱？', NULL, NULL, NULL, 'pending'),
(13, '轮胎更换周期', '轮胎一般多久需要更换？', 3, '轮胎一般建议5年或5-6万公里更换，具体看磨损情况和老化程度。', '2024-02-05 14:00:00', 'replied'),
(14, '变速箱油更换', '雅阁变速箱油多久换一次？', NULL, NULL, NULL, 'pending'),
(15, '年检代办服务', '你们店可以代办年检吗？', NULL, NULL, NULL, 'pending');

-- 插入投诉数据
INSERT INTO `complaint`(`owner_id`, `order_id`, `title`, `content`, `handle_result`, `status`) VALUES
(8, 4, '维修时间过长', '发动机维修等配件等了3天，影响我正常用车。', '非常抱歉给您带来不便，我们已优化配件供应链，下次维修将提供代步车服务。', 'processed'),
(9, NULL, '服务态度问题', '前台接待人员态度冷淡，希望改进。', '感谢您的反馈，我们已对相关人员进行培训，提升服务质量。', 'processed'),
(5, NULL, '预约时间不准', '预约了9点，结果等到10点才开始保养。', '非常抱歉，当天预约客户较多，我们已优化预约系统，避免此类情况发生。', 'processed'),
(11, NULL, '价格不透明', '维修前没有告知具体价格，结账时发现比预期高很多。', '非常抱歉，我们已要求所有维修项目必须提前报价，确保价格透明。', 'processed'),
(14, NULL, '预约取消问题', '我预约的时间被临时取消了，也没有提前通知。', '非常抱歉给您带来不便，我们已优化预约提醒系统，确保及时通知客户。', 'processed');
