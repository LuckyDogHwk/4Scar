-- 为已存在的 complaint 表添加 handle_time 列
ALTER TABLE `complaint` ADD COLUMN `handle_time` DATETIME AFTER `handle_result`;
