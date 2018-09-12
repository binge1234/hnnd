package com.hnnd.dao;

import org.apache.ibatis.annotations.Param;

import com.hnnd.base.BaseMapper;
import com.hnnd.entity.ApplyExamInfo;

public interface ApplyExamInfoMapper extends BaseMapper<ApplyExamInfo>{
    int deleteByPrimaryKey(Integer id);

    int insert(ApplyExamInfo record);

    int insertSelective(ApplyExamInfo record);

    ApplyExamInfo selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ApplyExamInfo record);

    int updateByPrimaryKey(ApplyExamInfo record);
    
    ApplyExamInfo selectByUidCid(@Param("user_id")int user_id,@Param("course_id")int course_id);
}