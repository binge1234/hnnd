package com.hnnd.dao;

import com.hnnd.entity.GradeRetrial;

public interface GradeRetrialMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(GradeRetrial record);

    int insertSelective(GradeRetrial record);

    GradeRetrial selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(GradeRetrial record);

    int updateByPrimaryKey(GradeRetrial record);
}