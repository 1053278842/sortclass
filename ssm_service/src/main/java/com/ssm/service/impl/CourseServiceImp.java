package com.ssm.service.impl;

import com.ssm.dao.ICourseDao;
import com.ssm.dao.IGradeDao;
import com.ssm.domain.Course;
import com.ssm.domain.CourseGradeRelationship;
import com.ssm.domain.Grade;
import com.ssm.service.ICourseService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@Service("courseService")
@Transactional
public class CourseServiceImp implements ICourseService {

    @Resource(name = "courseDao")
    private ICourseDao courseDao;

    @Resource(name = "gradeDao")
    private IGradeDao gradeDao;

    /**
     * 插入course和grade两个表，同时关联其中间表的关系
     * 插入中间表的Dao放在course中
     *
     * @param course
     * @param grade
     */
    @Override
    public void insertCourseAndGrades(Course course, int gid) throws Exception {
        int cid = -1;
        //查询是否存在该Course，不通过ID
        Course existCourse = courseDao.findByCourseExceptId(course);
        if (existCourse != null) {
            cid = existCourse.getId();
            System.err.println("course插入重复！" + course.toString());
        } else {
            //插入Course，返回CID
            courseDao.insert(course);
            cid = course.getId();
        }

//        //查询是否存在name相同的grade数据
//        Grade existGrade=gradeDao.findByName(grade.getClass_name());
//        if (existGrade!=null){
//            //插入Grade，返回GID
//            gid=existGrade.getId();
//            System.err.println("grades插入重复！"+grade.toString());
//        }else{
//            //插入Course，返回CID
//            gradeDao.insert(grade);
//            gid= grade.getId();
//        }

        //根据GID和CID插入到中间关系表中
        //判断是否存在该信息
        CourseGradeRelationship cgrs = courseDao.isExistCourseAndGradeRelationship(cid, gid);
        if (cgrs != null) {
            System.err.println("CourseAndGradeRelationship插入重复！" + cid + "||" + existCourse + "||" + gid);
        } else {
            //插入到关系表中
            courseDao.insertCourseAndGradeRelationship(cid, gid);
        }

    }


}
