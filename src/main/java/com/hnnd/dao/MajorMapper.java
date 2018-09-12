package com.hnnd.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hnnd.base.BaseMapper;
import com.hnnd.entity.Major;

public interface MajorMapper extends BaseMapper<Major> {
	
    int updateByStatus(Major major);
    
    int updateByFlag(Major major);
    
    List<Major> selectNoLocationMajor();
}