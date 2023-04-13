package com.ssm.service.impl;

import com.ssm.dao.ISingleClassDao;
import com.ssm.domain.SingleClass;
import com.ssm.service.ISingleClassAllInfoService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service("singleClassService")
@Transactional
public class SingleClassServiceImpl implements ISingleClassAllInfoService {

    @Resource(name = "singleClassDao")
    private ISingleClassDao singleClassDao;

    /**
     * 根据week和section获取指定条件下的课程以及班级
     *
     * @param week
     * @param section
     * @return
     */
    @Override
    public List<SingleClass> findClassesByWeekAndSection(int week, String section) {
        List<SingleClass> singleClasses = null;

        singleClasses = singleClassDao.findSingleClassByWeekAndSection(week, section);
//        for (SingleClass s :singleClasses) {
//            if (s.getCourse()!=null) {
//                System.out.println(s.toString());
//            }
//        }

        return singleClasses;
    }

    /**
     * 同上，但没有指定section
     *
     * @param week
     * @return
     */
    @Override
    public List<SingleClass> findClassesByWeek(int week) {
        List<SingleClass> singleClasses = null;

        singleClasses = singleClassDao.findSingleClassByWeek(week);
        return singleClasses;
    }

    @Override
    public List<SingleClass> findClassesByWeekAndClassName(int week, String className) {
        List<SingleClass> singleClasses = null;

        if (week == 0) {
            //查询所有周的数据
            singleClasses = singleClassDao.findSingleClassByClassName(className);
        } else {
            //查询指定周的数据
            singleClasses = singleClassDao.findSingleClassByWeekAndClassName(week, className);
        }
        return singleClasses;
    }
}
