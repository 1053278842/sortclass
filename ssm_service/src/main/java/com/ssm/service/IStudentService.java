package com.ssm.service;

import com.ssm.domain.Student;

import java.sql.Timestamp;
import java.util.List;

public interface IStudentService {

    /**
     * 查询所有student，按照date降序排列
     *
     * @return
     * @throws Exception
     */
    public List<Student> findAllByDateDesc(int pageNum, int pageSize) throws Exception;

    /**
     * 模型方法，实现student查询界面的排序展示
     *
     * @param pageNum
     * @param pageSize
     * @param fields   字段名
     * @param sortDire 升降序
     * @return
     */
    List<Student> findAllByMoreCondition(int pageNum, int pageSize, String field, String sortDire) throws Exception;

    /**
     * 删除单个数据
     *
     * @param id
     */
    void deleteById(int id) throws Exception;

    /**
     * 自增time属性
     *
     * @param id
     */
    void updateAddTimesById(int id) throws Exception;

    /**
     * 模糊搜索
     *
     * @param pageNum
     * @param pageSize
     * @param likeValue
     * @return
     */
    List<Student> findAllByLikeValue(int pageNum, int pageSize, String field, String sortDire, String likeValue);

    /**
     * 不重复的插入信息，会对sno进行或判断是否有存在，有则覆盖，无则创建
     *
     * @param sno
     * @param name
     * @param classes
     * @param timestamp
     * @param freeClass
     */
//    void insertStudentNoRepeat(String sno, String name, String classes, Timestamp times, String[] freeClass);
    void insertStudentNoRepeat(Student student);

    /**
     * 通过条件查询是否有该条记录
     *
     * @param sno return 返回存在的id或者返回空
     */
    Student findStudentBySno(String sno);

    /**
     * 通过两个日期，获取日期区间内的所有student数据
     *
     * @param beforDate
     * @param afterDate
     */
    List<Student> findStudentByDateRang(String beforDate, String afterDate);

    /**
     * 通过两个日期和课次，获取日期区间内指定课次的所有student数据
     *
     * @param beforDate
     * @param afterDate
     */
    List<Student> findStudentByDateRangAndSectionOrderTimes(String beforDate, String afterDate, String classSectionName);

    /**
     * times-- by id
     *
     * @param id
     */
    void updateMinusTimesById(int id);

    /**
     * times=0 by id
     *
     * @param id
     */
    void updateClearTimesById(int id);
}
