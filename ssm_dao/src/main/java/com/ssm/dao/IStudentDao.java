package com.ssm.dao;

import com.ssm.domain.Student;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.util.List;

@Repository("studentDao")
public interface IStudentDao {
    /**
     * 查询所有student，按照date降序排列
     *
     * @return
     */
    @Select("SELECT * FROM sortclass.student order by date desc")
    List<Student> findAllOrderByDateDesc();

    /**
     * 查询所有student，按照date降序排列
     *
     * @return
     */
    @Select("SELECT * FROM sortclass.student order by ${field}  ${sortDire}")
    List<Student> findAllByMoreCondition(@Param("field") String field, @Param("sortDire") String sortDire);

    /**
     * 删除指定的id
     *
     * @param id
     */
    @Delete("delete from sortclass.student where id=#{id}")
    void deleteById(int id);

    @Update("update sortclass.student set times=times+1 where id=#{id}")
    void updateAddTimesById(int id);

    @Select("SELECT * FROM sortclass.student where sno like concat('%',#{likeValue},'%') or name like concat('%',#{likeValue},'%') " +
            "or classes like concat('%',#{likeValue},'%') or times like concat('%',#{likeValue},'%') or freeClasses like concat('%',#{likeValue},'%') " +
            "order by ${field}  ${sortDire}")
    List<Student> findAllByLikeValue(@Param("field") String field, @Param("sortDire") String sortDire, @Param("likeValue") String likeValue);

    /**
     * 返回sno的id
     *
     * @param sno
     */
    @Select("SELECT * FROM sortclass.student where sno=#{id}")
    Student findStudentBySno(String sno);

    /**
     * 更新数据
     *
     * @param id
     * @param sno
     * @param name
     * @param classes
     * @param time
     * @param freeClass
     */
    @Update("update sortclass.student set sno=#{sno},name=#{name},classes=#{classes},date=#{date}," +
            "freeClasses=#{freeClasses} where id=#{id}")
    void updateStudentBySno(Student student);

    /**
     * 插入一条新数据
     *
     * @param student 根据传入的student
     */
    @Insert("insert into sortclass.student (sno,name,classes,date,freeClasses)values(#{sno},#{name}," +
            "#{classes},#{date},#{freeClasses})")
    void insertStudent(Student student);


    /**
     * 查询返回日期区间内的student
     *
     * @param beforDate
     * @param afterDate
     * @return
     */
    @Select("select * from sortclass.student where date BETWEEN  #{beforDate} and  #{afterDate};")
    List<Student> findStudentByDateRang(@Param("beforDate") String beforDate, @Param("afterDate") String afterDate);


    /**
     * 查询返回日期区间内的student
     *
     * @param beforDate
     * @param afterDate
     * @return
     */
    @Select("select * from sortclass.student where date BETWEEN  #{beforDate} and  #{afterDate} " +
            "and freeClasses like concat('%',#{section},'%') " +
            "order by times ")
    List<Student> findStudentByDateRangAndSectionOrderTimesAsc(@Param("beforDate") String beforDate, @Param("afterDate") String afterDate, @Param("section") String classSectionName);

    /**
     * times清空 by id
     *
     * @param id
     */
    @Update("update sortclass.student set times=0 where id=#{id}")
    void updateClearTimesById(int id);

    /**
     * times自减 by id
     *
     * @param id
     */
    @Update("update sortclass.student set times=times-1 where id=#{id}")
    void updateMinusTimesById(int id);
}
