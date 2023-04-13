package com.ssm.service;

import com.ssm.domain.SingleClass;

import java.util.List;

public interface ISingleClassAllInfoService {

    /**
     * 根据week和section返回班级以及课程，注意没有学生
     *
     * @param week
     * @param section
     * @return SingleClass作为存储类
     */
    List<SingleClass> findClassesByWeekAndSection(int week, String section);

    /**
     * 根据week返回班级以及课程，注意没有学生
     *
     * @param week
     * @param section
     * @return SingleClass作为存储类
     */
    List<SingleClass> findClassesByWeek(int week);

    /**
     * 根据week和className返回课程
     *
     * @param week
     * @param className
     * @return
     */
    List<SingleClass> findClassesByWeekAndClassName(int week, String className);
}
