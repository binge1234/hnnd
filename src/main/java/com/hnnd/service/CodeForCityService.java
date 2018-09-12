package com.hnnd.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hnnd.base.BaseService;
import com.hnnd.dao.CodeForCityMapper;
import com.hnnd.entity.CodeForCity;

@Service
public class CodeForCityService extends BaseService<CodeForCity> {
	@Autowired
	CodeForCityMapper codeForCityDao;
	
}
