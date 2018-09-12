package com.hnnd.dao;

import java.util.List;

import com.hnnd.base.BaseMapper;
import com.hnnd.entity.Grade;


public interface GradeMapper extends BaseMapper<Grade>{
	int updateByViolate(Grade record);
	int updateErrorMessage(Grade record);
	List<Grade> selectByStudent(Integer user_id);
	List<Grade> selectErrorByPage(String remark);
}