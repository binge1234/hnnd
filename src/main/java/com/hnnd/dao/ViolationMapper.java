package com.hnnd.dao;

import com.hnnd.entity.Violation;

public interface ViolationMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Violation record);

    int insertSelective(Violation record);

    Violation selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Violation record);

    int updateByPrimaryKey(Violation record);
}