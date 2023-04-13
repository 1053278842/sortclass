package com.ssm.service;

import com.ssm.domain.Course;
import com.ssm.domain.Grade;

public interface ICourseService {

    /**
     * 插入course,grades以及两个表的关系，共计三个表
     */
    void insertCourseAndGrades(Course course, int gid) throws Exception;

}
