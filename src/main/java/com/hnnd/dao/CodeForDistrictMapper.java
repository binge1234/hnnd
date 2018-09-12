package com.hnnd.dao;

import java.util.List;

import com.hnnd.base.BaseMapper;
import com.hnnd.entity.CodeForDistrict;

public interface CodeForDistrictMapper extends BaseMapper<CodeForDistrict> {
	public List<CodeForDistrict> selectByCity(CodeForDistrict district); 
}
