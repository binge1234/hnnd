package com.hnnd.dao;

import java.util.List;

import com.hnnd.base.BaseMapper;
import com.hnnd.entity.shiro.UserRole;

public interface UserRoleMapper extends BaseMapper<UserRole>{
     
    int deleteByUid(Integer uid);
    int deleteByRid(Integer rid);
   
    Integer selectByUid(Integer uid);
    List<Integer> selectByRid(Integer rid);

    
    
}