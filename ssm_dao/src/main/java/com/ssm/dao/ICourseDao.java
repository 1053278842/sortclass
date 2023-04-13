package com.ssm.dao;

import com.ssm.domain.Course;
import com.ssm.domain.CourseGradeRelationship;
import com.ssm.domain.Grade;
import com.ssm.domain.SingleClass;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("courseDao")
public interface ICourseDao {

    /**
     * 根据id返回一个Course类
     *
     * @param id
     * @return
     */
    @Select("select * from course where id=#{id}")
    Course findById(@Param("id") int id) throws Exception;


    /**
     * 除id条件外，查询对应条件的course
     *
     * @param course
     * @return
     */
    @Select("SELECT * FROM sortclass.course where course_name=#{course_name}" +
            " and course_time=#{course_time} and course_location=#{course_location}" +
            " and course_teacher_name=#{course_teacher_name} and course_section=#{course_section}")
    Course findByCourseExceptId(Course course) throws Exception;

    /**
     * 插入新数据
     *
     * @param course
     * @return
     */
    @Insert("Insert into sortclass.course (course_name,course_time,course_location,course_teacher_name,course_section)" +
            " values (#{course_name},#{course_time},#{course_location},#{course_teacher_name},#{course_section})")
    @Options(useGeneratedKeys = true, keyProperty = "id", keyColumn = "id")
    void insert(Course course) throws Exception;


    /**
     * 对course和grade表的中间关系表进行插入
     *
     * @param cid
     * @param gid
     */
    @Insert("Insert into sortclass.grades_course_relationship (grades_id,course_id) values (#{gid},#{cid})")
    void insertCourseAndGradeRelationship(@Param("cid") int cid, @Param("gid") int gid) throws Exception;


    @Select("select * from sortclass.grades_course_relationship where grades_id=#{gid} and course_id=#{cid}")
    CourseGradeRelationship isExistCourseAndGradeRelationship(@Param("cid") int cid, @Param("gid") int gid) throws Exception;
}
