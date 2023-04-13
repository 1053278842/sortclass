package com.ssm.service.impl;

import com.github.pagehelper.PageHelper;
import com.ssm.dao.IStudentDao;
import com.ssm.domain.Student;
import com.ssm.service.IStudentService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.sql.Timestamp;
import java.util.List;

@Service("studentService")
@Transactional
public class StudentServiceImpl implements IStudentService {

    @Resource(name = "studentDao")
    private IStudentDao studentDao;


    @Override
    public List<Student> findAllByDateDesc(int pageNum, int pageSize) throws Exception {
        PageHelper.startPage(pageNum, pageSize);//默认查询第一页，10条
        return studentDao.findAllOrderByDateDesc();
    }

    @Override
    public List<Student> findAllByMoreCondition(int pageNum, int pageSize, String field, String sortDire) throws Exception {
        PageHelper.startPage(pageNum, pageSize);//默认查询第一页，10条
        return studentDao.findAllByMoreCondition(field, sortDire);
    }

    @Override
    public void deleteById(int id) throws Exception {
        studentDao.deleteById(id);
    }

    @Override
    public void updateAddTimesById(int id) throws Exception {
        studentDao.updateAddTimesById(id);
    }

    @Override
    public List<Student> findAllByLikeValue(int pageNum, int pageSize, String field, String sortDire, String likeValue) {
        PageHelper.startPage(pageNum, pageSize);//默认查询第一页，10条
        return studentDao.findAllByLikeValue(field, sortDire, likeValue);
    }

    //    public void insertStudentNoRepeat(String sno, String name, String classes, Timestamp time, String[] freeClass) {
    @Override
    public void insertStudentNoRepeat(Student student) {
        //判断是否存在sno或name相同的数据
        Student isExistStudent = findStudentBySno(student.getSno());
        if (isExistStudent != null) {
            //有：更新，覆盖其classes、times,freeclass
            student.setId(isExistStudent.getId());
            studentDao.updateStudentBySno(student);
            System.out.println("跟新完毕！");
        } else {
            //无：insert 一个新的数据
            studentDao.insertStudent(student);
            System.out.println("插入完毕1");
        }
        //返回状态值
    }

    //判断是否有student
    @Override
    public Student findStudentBySno(String sno) {
        //判断是否存在sno或name相同的数据
        Student student = studentDao.findStudentBySno(sno);
        //返回状态值
        return student;
    }

    //获取日期区间内的数据
    @Override
    public List<Student> findStudentByDateRang(String beforDate, String afterDate) {
        List<Student> students;
        if (beforDate != null && afterDate != null) {
            students = studentDao.findStudentByDateRang(beforDate, afterDate);
        } else {
            students = null;
            System.err.println("findStudentByDateRang方法错误！");
        }
        return students;
    }

    /**
     * 获取日期区间内指定课次的数据,并按照time升序排列
     */
    @Override
    public List<Student> findStudentByDateRangAndSectionOrderTimes(String beforDate, String afterDate, String classSectionName) {
        List<Student> students;
        if (beforDate != null && afterDate != null && classSectionName != null) {
            students = studentDao.findStudentByDateRangAndSectionOrderTimesAsc(beforDate, afterDate, classSectionName);
        } else {
            students = null;
            System.err.println("findStudentByDateRangAndSectionOrderTimes()出错！");
        }
        return students;
    }

    /**
     * 减少times by id
     *
     * @param id
     */
    @Override
    public void updateMinusTimesById(int id) {
        studentDao.updateMinusTimesById(id);
    }

    /**
     * 清空times by id
     *
     * @param id
     */
    @Override
    public void updateClearTimesById(int id) {
        studentDao.updateClearTimesById(id);
    }

}
