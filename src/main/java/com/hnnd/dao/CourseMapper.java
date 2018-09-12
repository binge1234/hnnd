package com.hnnd.dao;

import java.util.List;

import com.hnnd.base.BaseMapper;
import com.hnnd.entity.Course;

public interface CourseMapper extends BaseMapper<Course>{
    int deleteByPrimaryKey(Integer id);

    int insert(Course record);

    int insertSelective(Course record);
    
    int selectMajorByPrimaryKey(Integer id);

    Course selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Course record);

    int updateByPrimaryKey(Course record);
    
    int updateByType(Course course);
    
}