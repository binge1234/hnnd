package com.hnnd.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hnnd.base.BaseService;
import com.hnnd.dao.UserMapper;
import com.hnnd.dao.UserRoleMapper;
import com.hnnd.entity.User;

@Service
public class UserService extends BaseService<User>{
//	public User findById(Integer id);
//	
//	public List<User> list();
//	
//	public void add(User user);
//	
//	public void delete(int id);
//	
//	public void update(User user);
	
	
//	@Autowired
//	private UserRoleMapper userRoleMapper;
//
//	
//
//   @Override
//	public void delete(Integer id) {
//		// TODO Auto-generated method stub
//		super.delete(id);
//		userRoleMapper.deleteByUid(id);
//		
//	}
	@Autowired
	UserMapper userMapper;
	
	public User queryByUname(String userName) {
		return userMapper.selectByUname(userName);
	}
	
	public int getTotal(Map map) {
		return userMapper.getTotalByParams(map);
	}
	
	public List<User> getUsersByParams(Map map){
		return userMapper.listByParams(map);
		
	}
	
}
