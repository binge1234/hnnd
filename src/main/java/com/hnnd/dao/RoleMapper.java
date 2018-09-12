package com.hnnd.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hnnd.base.BaseMapper;
import com.hnnd.entity.Major;
import com.hnnd.entity.shiro.Role;

public interface RoleMapper extends BaseMapper<Role>{

	public Role selectByName(String name);
	
}