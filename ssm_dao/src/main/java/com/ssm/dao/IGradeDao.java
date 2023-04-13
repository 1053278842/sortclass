package com.ssm.dao;

import com.ssm.domain.Course;
import com.ssm.domain.Grade;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("gradeDao")
public interface IGradeDao {

    @Select("select * from sortclass.classes_grades where id=#{id}")
    Grade findById(int id) throws Exception;

    @Select("SELECT * FROM sortclass.classes_grades where class_name=#{class_name}")
    Grade findByName(String class_name) throws Exception;

    /**
     * 插入新数据
     *
     * @param course
     * @return
     */
    @Insert("Insert into sortclass.classes_grades (class_name,size)" +
            " values (#{class_name},#{size})")
    @Options(useGeneratedKeys = true, keyProperty = "id", keyColumn = "id")
    void insert(Grade grade) throws Exception;


    /**
     * 更新内容ById
     *
     * @param grade
     */
    @Update("update sortclass.classes_grades set size=#{size} where id=#{id}")
    void updateSizeGrade(@Param("id") int id, @Param("size") int size);

    /**
     * 通过grade的ID与中间表，对course进行关联数据删除
     *
     * @param grade
     */
    @Delete("delete from sortclass.course where id in " +
            "(select r.course_id from sortclass.classes_grades g,sortclass.grades_course_relationship r " +
            "where r.grades_id=g.id and g.id=#{id}) and id>0 ")
    void deleteCourseByGrade(Grade grade);

    /**
     * 通过grade的id删除关系表的数据，以备重新构建
     *
     * @param grade
     */

    @Delete("delete from sortclass.grades_course_relationship where grades_id in " +
            "(select g.id from sortclass.classes_grades g where g.id=#{id}) and id>0;")
    void deleteRelationshipByGrade(Grade grade);

    /**
     * 查找所有
     *
     * @return
     */
    @Select("select * from sortclass.classes_grades")
    List<Grade> findAll();
}
