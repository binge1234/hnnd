package com.hnnd.dao;

import com.hnnd.base.BaseMapper;
import com.hnnd.entity.ExamClassroom;

public interface ExamClassroomMapper extends BaseMapper<ExamClassroom> {
    int deleteByPrimaryKey(Integer id);

    int insert(ExamClassroom record);

    int insertSelective(ExamClassroom record);

    ExamClassroom selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ExamClassroom record);

    int updateByPrimaryKey(ExamClassroom record);
    
    int selectClassroomCount(int locationId);
}