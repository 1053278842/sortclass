package com.ssm.service.impl;

import com.ssm.dao.IGradeDao;
import com.ssm.domain.Grade;
import com.ssm.service.IGradeService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service("gradeService")
@Transactional
public class GradeServiceImpl implements IGradeService {

    @Resource(name = "gradeDao")
    private IGradeDao gradeDao;

    /**
     * 先判定是否存在，再插入该Grade，并返回其ID
     * 如果不存在，新建。并返回新建的ID
     * 如果存在，更新原有的数据（size),删除相关的Course数据和关系表数据。以备重新添加。并返回更新后的ID
     *
     * @param grade
     * @return
     * @throws Exception
     */
    @Override
    public int insertReturnId(Grade grade) throws Exception {
        int gid = -1;
        //查询是否存在name相同的grade数据
        Grade existGrade = gradeDao.findByName(grade.getClass_name());
        if (existGrade != null) {
            //存在：更新现有的Grade数据
            gradeDao.updateSizeGrade(existGrade.getId(), grade.getSize());
            //删除Course表的相关课程
            gradeDao.deleteCourseByGrade(existGrade);
            //删除关系表
            gradeDao.deleteRelationshipByGrade(existGrade);

            //插入Grade，返回GID
            gid = existGrade.getId();
            System.err.println("grades插入重复！已经删除相关联系的数据，并修改了size");
        } else {
            //不存在：插入Course，返回CID
            gradeDao.insert(grade);
            gid = grade.getId();
        }
        return gid;
    }

    /**
     * 查找所有
     */
    @Override
    public List<Grade> findAll() {
        return gradeDao.findAll();
    }
}
