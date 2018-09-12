package com.hnnd.service.shiro;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hnnd.base.BaseService;
import com.hnnd.dao.PermissionMapper;
import com.hnnd.dao.RolePermissionMapper;
import com.hnnd.entity.shiro.Role;
import com.hnnd.entity.shiro.RolePermission;

@Service
public class RolePermissionService extends BaseService<RolePermission>{
//    public void setPermissions(Role role, int[] permissionIds);
//    public void deleteByRole(int roleId);
//    public void deleteByPermission(int permissionId);
    @Autowired
    RolePermissionMapper rolePermissionMapper;
    
    

	public void setPermissions(Role role, int[] permissionIds) {
		// TODO Auto-generated method stub
		rolePermissionMapper.deleteByRid(role.getId());//先删除当前角色的权限。
		
		if(permissionIds !=null) {
			
			for(int permissionId: permissionIds) {
				RolePermission rolePermission = new RolePermission();
				rolePermission.setPid(permissionId);
				rolePermission.setRid(role.getId());
				insert(rolePermission);
			}
		}
		
		
	}


	public void deleteByRole(int roleId) {
		// TODO Auto-generated method stub
		rolePermissionMapper.deleteByRid(roleId);
	}


	public void deleteByPermission(int permissionId) {
		// TODO Auto-generated method stub
		rolePermissionMapper.deleteByPid(permissionId);
	}
	
	
	
    
}
