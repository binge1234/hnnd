package com.hnnd.dao;

import com.hnnd.entity.ExamProvince;

public interface ExamProvinceMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ExamProvince record);

    int insertSelective(ExamProvince record);

    ExamProvince selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ExamProvince record);

    int updateByPrimaryKey(ExamProvince record);
}