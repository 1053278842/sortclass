-- ============================================================
--  sortclass 数据库结构（MySQL 5.7 / 8.0 均可）
--
--  说明：本项目所有 SQL 都写了 sortclass. 前缀，
--        因此库名必须叫 sortclass，否则 DAO 中的语句会找不到表。
-- ============================================================

CREATE DATABASE IF NOT EXISTS `sortclass`
    DEFAULT CHARACTER SET utf8mb4
    COLLATE utf8mb4_general_ci;

USE `sortclass`;

-- ------------------------------------------------------------
-- 班级表：一行 = 一个班级（上传课表时由 Excel 标题自动生成）
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `classes_grades` (
    `id`         INT          NOT NULL AUTO_INCREMENT COMMENT '主键',
    `class_name` VARCHAR(64)  NOT NULL COMMENT '班级名称，如 17计科（2+3）',
    `size`       INT          NOT NULL DEFAULT 0 COMMENT '班级人数（上传时手填）',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_class_name` (`class_name`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='班级';

-- ------------------------------------------------------------
-- 课程表：一行 = 某班级的一门课在某个大节的一次上课
--   course_time      : 周次范围，例如 1-13（前两/后两位宽度参与周次过滤）
--   course_section   : 大节，例如 Mon1 / Web5 / Fri7（Web 表示周三）
--   course_location  : 教室，例如 35-3jt
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `course` (
    `id`                  INT         NOT NULL AUTO_INCREMENT COMMENT '主键',
    `course_name`         VARCHAR(64) NOT NULL COMMENT '课程名',
    `course_time`         VARCHAR(16) NOT NULL COMMENT '周次范围，如 1-13',
    `course_location`     VARCHAR(32) NOT NULL DEFAULT '' COMMENT '教室',
    `course_teacher_name` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '任课教师',
    `course_section`      VARCHAR(8)  NOT NULL COMMENT '大节，如 Mon1',
    PRIMARY KEY (`id`),
    KEY `idx_section` (`course_section`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='课程';

-- ------------------------------------------------------------
-- 班级-课程 多对多关系表
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `grades_course_relationship` (
    `id`        INT NOT NULL AUTO_INCREMENT COMMENT '主键',
    `grades_id` INT NOT NULL COMMENT 'classes_grades.id',
    `course_id` INT NOT NULL COMMENT 'course.id',
    PRIMARY KEY (`id`),
    KEY `idx_grades` (`grades_id`),
    KEY `idx_course` (`course_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='班级-课程关系';

-- ------------------------------------------------------------
-- 志愿者（学生）表
--   freeClasses : 空闲大节，用逗号拼接，如 ,Mon1,Mon3,Fri7
--   times       : 已被排班次数（用于均衡分配）
--   date        : 报名时间（排班时按日期区间筛选志愿者）
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `student` (
    `id`          INT          NOT NULL AUTO_INCREMENT COMMENT '主键',
    `sno`         VARCHAR(16)  NOT NULL COMMENT '学号',
    `name`        VARCHAR(32)  NOT NULL COMMENT '姓名',
    `classes`     VARCHAR(64)  NOT NULL DEFAULT '' COMMENT '行政班级',
    `date`        DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '报名时间',
    `freeClasses` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '空闲大节，逗号分隔',
    `times`       INT          NOT NULL DEFAULT 0 COMMENT '已排班次数',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_sno` (`sno`),
    KEY `idx_date` (`date`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='志愿者';