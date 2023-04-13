package com.ssm.service;


import com.ssm.domain.Grade;

import java.util.List;

public interface IGradeService {

    /**
     * 先判定是否存在，再插入该Grade，并返回其ID
     * 如果不存在，新建。并返回新建的ID
     * 如果存在，更新原有的数据（size),删除相关的Course数据和关系表数据。以备重新添加。并返回更新后的ID
     *
     * @param grade
     * @return
     * @throws Exception
     */
    int insertReturnId(Grade grade) throws Exception;

    /**
     * 查找所有
     */
    List<Grade> findAll();
}
