package com.hnnd.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.hnnd.base.BaseMapper;
import com.hnnd.entity.Major;
import com.hnnd.entity.User;
import com.hnnd.entity.shiro.Permission;

public interface PermissionMapper extends BaseMapper<Permission>{
  
	public int getTotalByParams(Map<String,Object> map);
	
	public List<Permission> listByParams(Map map);
   

   


    

    
   
    
    
}