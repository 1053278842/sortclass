package com.ssm.dao;

import com.ssm.domain.Grade;
import com.ssm.domain.SingleClass;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("singleClassDao")
public interface ISingleClassDao {

    /**
     * 查询出grades封装到grades,查询到course封装到course，再一并封装到singleClassAllInfo
     *
     * @param week
     * @param section
     * @return
     */
    @Select("SELECT classes_grades.id as gid,class_name,size, course_id as cid, course_name,course_time,course_location,course_teacher_name,course_section " +
            "FROM sortclass.classes_grades,sortclass.course,sortclass.grades_course_relationship " +
            "where sortclass.classes_grades.id=grades_id and sortclass.course.id=course_id " +
            "and left(course_time,2)<=#{week} and replace(right(course_time,2),'-','0')>=#{week} " +
            "and course_section=#{section} order by class_name")
    @Results(value = {
            @Result(id = true, property = "id", column = "id"),
            @Result(property = "grade", column = "gid", javaType = Grade.class, one = @One(select = "com.ssm.dao.IGradeDao.findById")),
            @Result(property = "course", column = "cid", javaType = Grade.class, one = @One(select = "com.ssm.dao.ICourseDao.findById"))
    })
    List<SingleClass> findSingleClassByWeekAndSection(@Param("week") int week, @Param("section") String section);

    @Select("SELECT classes_grades.id as gid,class_name,size, course_id as cid, course_name,course_time,course_location,course_teacher_name,course_section " +
            "FROM sortclass.classes_grades,sortclass.course,sortclass.grades_course_relationship " +
            "where sortclass.classes_grades.id=grades_id and sortclass.course.id=course_id " +
            "and left(course_time,2)<=#{week} and replace(right(course_time,2),'-','0')>=#{week} " +
            "order by class_name")
    @Results(value = {
            @Result(id = true, property = "id", column = "id"),
            @Result(property = "grade", column = "gid", javaType = Grade.class, one = @One(select = "com.ssm.dao.IGradeDao.findById")),
            @Result(property = "course", column = "cid", javaType = Grade.class, one = @One(select = "com.ssm.dao.ICourseDao.findById"))
    })
    List<SingleClass> findSingleClassByWeek(int week);


    /**
     * 查询指定week和className的数据
     *
     * @param week
     * @param className
     * @return
     */
    @Select("SELECT classes_grades.id as gid,class_name,size, course_id as cid, course_name,course_time,course_location,course_teacher_name,course_section " +
            "            FROM sortclass.classes_grades,sortclass.course,sortclass.grades_course_relationship " +
            "            where sortclass.classes_grades.id=grades_id and sortclass.course.id=course_id " +
            "            and left(course_time,2)<=#{week} and replace(right(course_time,2),'-','0')>=#{week} " +
            "            and class_name=#{className} order by class_name" +
            "            ")
    @Results(value = {
            @Result(id = true, property = "id", column = "id"),
            @Result(property = "grade", column = "gid", javaType = Grade.class, one = @One(select = "com.ssm.dao.IGradeDao.findById")),
            @Result(property = "course", column = "cid", javaType = Grade.class, one = @One(select = "com.ssm.dao.ICourseDao.findById"))
    })
    List<SingleClass> findSingleClassByWeekAndClassName(@Param("week") int week, @Param("className") String className);

    /**
     * 查询指定week和className的数据,同上，但是周是全部周
     *
     * @param week
     * @param className
     * @return
     */
    @Select("SELECT classes_grades.id as gid,class_name,size, course_id as cid, course_name,course_time,course_location,course_teacher_name,course_section " +
            "            FROM sortclass.classes_grades,sortclass.course,sortclass.grades_course_relationship " +
            "            where sortclass.classes_grades.id=grades_id and sortclass.course.id=course_id " +
            "            and class_name=#{className} order by class_name" +
            "            ")
    @Results(value = {
            @Result(id = true, property = "id", column = "id"),
            @Result(property = "grade", column = "gid", javaType = Grade.class, one = @One(select = "com.ssm.dao.IGradeDao.findById")),
            @Result(property = "course", column = "cid", javaType = Grade.class, one = @One(select = "com.ssm.dao.ICourseDao.findById"))
    })
    List<SingleClass> findSingleClassByClassName(@Param("className") String className);
}
