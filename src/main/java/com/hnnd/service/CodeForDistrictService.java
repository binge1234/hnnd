package com.hnnd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hnnd.base.BaseService;
import com.hnnd.dao.CodeForDistrictMapper;
import com.hnnd.entity.CodeForDistrict;

@Service
public class CodeForDistrictService extends BaseService<CodeForDistrict> {
	@Autowired
	CodeForDistrictMapper codeForDistrictDao;
	
	public List<CodeForDistrict> selectByCity(CodeForDistrict codeForDistrict){
		return codeForDistrictDao.selectByCity(codeForDistrict);
	}
}