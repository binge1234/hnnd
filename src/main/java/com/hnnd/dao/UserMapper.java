package com.hnnd.dao;

import java.util.List;
import java.util.Map;

import com.hnnd.base.BaseMapper;
import com.hnnd.entity.User;

public interface UserMapper extends BaseMapper<User>{
	
	public User selectByUname(String userName);
	
	public int getTotalByParams(Map<String,Object> map);
	
	public List<User> listByParams(Map map);
}