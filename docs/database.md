# 数据库表结构

4 张表，关系很简单：

```
classes_grades (班级)  1 ──< grades_course_relationship (班级-课程) >──  n  course (课程)
student (志愿者)            独立表，空闲节次用逗号串存一列
```

| 表 | 关键字段 | 说明 |
| --- | --- | --- |
| `classes_grades` | `id`、`class_name`（唯一）、`size` | 一行一个班级，人数由上传时手填 |
| `course` | `id`、`course_name`、`course_time`、`course_location`、`course_teacher_name`、`course_section` | `course_time` 是周次范围（`1-13`）；`course_section` 是大节（`Mon1`…`Fri7`，**周三写作 `Web`**，沿用原代码拼写） |
| `grades_course_relationship` | `id`、`grades_id`、`course_id` | 多对多中间表；同班同课去重 |
| `student` | `id`、`sno`（唯一）、`name`、`classes`、`date`、`freeClasses`、`times` | `freeClasses` 形如 `,Mon1,Mon3,Fri7`；`times` 是已排班次数，用于均衡 |

## 字段细节

### course.course_time 的写法

必须写成 `起始周-两位结束周`：`1-13`、`1-16`。因为按周筛选的 SQL 是：

```sql
left(course_time, 2) <= #{week} AND replace(right(course_time, 2), '-', '0') >= #{week}
```

结束周只有一位（如 `1-8`）时靠 `replace` 补 0 还能凑合，但 `1-100` 这种就完全不对了。
超过 99 周的学校请改这段 SQL。

### student.freeClasses 的格式

强依赖前导逗号：`,Mon1,Mon3,Fri7`。查询用 `like concat('%', #{section}, '%')` 匹配，
所以不要写成 `Mon1,Mon3,Fri7`（少了前导逗号会导致第一个匹配不到边缘情况）。

### course_section 取值

`Mon1 Mon3 Mon5 Mon7 / Tue1..Tue7 / Web1..Web7 / Thu1..Thu7 / Fri1..Fri7`，共 20 个。
数字是“第几大节”的起始小节号：`1` = 第 1、2 节，`3` = 第 3、4 节，`5` = 5、6 节，`7` = 7、8 节。

建表语句：[`../db/schema.sql`](../db/schema.sql)；演示数据：[`../db/seed.sql`](../db/seed.sql)
（3 班级 / 32 课程 / 9 志愿者 / 32 条关系）。

## 常用 SQL

```sql
-- 某周、某节次的课程（排班时实际执行的查询的简化版）
select g.class_name, g.size, c.course_name, c.course_location, c.course_teacher_name
from classes_grades g
join grades_course_relationship r on r.grades_id = g.id
join course c on c.id = r.course_id
where left(c.course_time, 2) <= 8
  and replace(right(c.course_time, 2), '-', '0') >= 8
  and c.course_section = 'Mon1';

-- 某个节次有空的学生（按出勤次数升序）
select * from student
where date between '2026-11-01' and '2026-12-31 23:59:59'
  and freeClasses like '%,Mon1,%'
order by times;
```