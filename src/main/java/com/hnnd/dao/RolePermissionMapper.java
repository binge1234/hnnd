package com.hnnd.dao;

import java.util.List;

import com.hnnd.base.BaseMapper;
import com.hnnd.entity.shiro.RolePermission;

public interface RolePermissionMapper extends BaseMapper<RolePermission>{

    
    int deleteByPid(Integer pid);
    
    int deleteByRid(Integer rid);
    
    
    List<RolePermission> selectByRid(Integer rid);


}