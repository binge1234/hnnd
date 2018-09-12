package com.hnnd.service.shiro;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hnnd.base.BaseService;
import com.hnnd.dao.PermissionMapper;
import com.hnnd.dao.RoleMapper;
import com.hnnd.dao.RolePermissionMapper;
import com.hnnd.dao.UserMapper;
import com.hnnd.entity.User;
import com.hnnd.entity.shiro.Permission;
import com.hnnd.entity.shiro.Role;
import com.hnnd.entity.shiro.RolePermission;
import com.hnnd.service.UserService;


@Service
public class PermissionService extends BaseService<Permission>{
//    public Set<String> listPermissions(int id);
//    
//    public List<Permission> list();
//    public void add(Permission permission);
//    public void delete(int id);
//    public Permission get(int id);
//    public void update(Permission permission);
// 
//    public List<Permission> list(Role role);
//    
//    public Set<String> listPermissionURLs(String userName);
//    
//    public Boolean isBlock(String userName);
	
    @Autowired
    private PermissionMapper permissionMapper;
    
    @Autowired
    private RolePermissionMapper rolePermissionMapper;
    
	@Autowired
	private RoleService roleService;
	
    @Autowired
    private UserMapper userMapper;
	
	public Set<String> listPermissions(Integer id) {//根据用户列出对应权限名称
		// TODO Auto-generated method stub
        Set<String> result = new HashSet<>();
        Role role = roleService.selectRoleByUid(id);//列出用户所对应的所有角色
        //Set<Permission> rolePermissions = new HashSet<>();
  
        	List<Permission> permissions = listByRole(role);
        	for(Permission permission:permissions) {
        		result.add(permission.getName());
        	}
        	
		return result;
	}

	
	


//	public void delete(int id) {
//		// TODO Auto-generated method stub
//		permissionMapper.deleteByPrimaryKey(id);
//		rolePermissionMapper.deleteByPid(id);
//		
//	}

	
//	public Permission get(int id) {
//		// TODO Auto-generated method stub
//		return permissionMapper.selectByPrimaryKey(id);
//	}


//	public void update(Permission permission) {
//		// TODO Auto-generated method stub
//		//permissionMapper.updateByPrimaryKeySelective(permission);
//	}

	
	public List<Permission> listByRole(Role role) {
		// TODO Auto-generated method stub
		List<Permission> permissions = new ArrayList<>();
		List<RolePermission> rolePermissions = rolePermissionMapper.selectByRid(role.getId());
		for(RolePermission rolePermission: rolePermissions) {
			Permission permission = permissionMapper.selectByPrimaryKey(rolePermission.getPid());
			permissions.add(permission);
		}
		
		return permissions;
	}


	public Set<String> listPermissionURLs(String userName) {
		// TODO Auto-generated method stub
        Set<String> result = new HashSet<>();
        User user = userMapper.selectByUname(userName);
        int userId = user.getId();
        Role role = roleService.selectRoleByUid(user.getId());//列出用户所对应的所有角色
        //Set<Permission> rolePermissions = new HashSet<>();
        
        
        	List<Permission> permissions = listByRole(role);
        	for(Permission permission:permissions) {
        		result.add(permission.getUrl());	
        }
        

		return result;
	}


	public Boolean isBlock(String requestURI) {
		// TODO Auto-generated method stub
        List<Permission> ps = listAll();
        for (Permission p : ps) {
            if (p.getUrl().equals(requestURI))
                return true;
        }
        return false;
	}
	
	public int getTotal(Map map) {
		return permissionMapper.getTotalByParams(map);
	}
	
	public List<Permission> getUsersByParams(Map map){
		return permissionMapper.listByParams(map);
		
	}
}
