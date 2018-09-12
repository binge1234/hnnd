package com.hnnd.dao;

import com.hnnd.entity.FreeExamInfo;

public interface FreeExamInfoMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(FreeExamInfo record);

    int insertSelective(FreeExamInfo record);

    FreeExamInfo selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(FreeExamInfo record);

    int updateByPrimaryKeyWithBLOBs(FreeExamInfo record);

    int updateByPrimaryKey(FreeExamInfo record);
}