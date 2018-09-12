package com.hnnd.service.shiro;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hnnd.base.BaseService;
import com.hnnd.dao.RoleMapper;
import com.hnnd.dao.RolePermissionMapper;
import com.hnnd.dao.UserMapper;
import com.hnnd.dao.UserRoleMapper;
import com.hnnd.entity.User;
import com.hnnd.entity.shiro.Role;
import com.hnnd.entity.shiro.UserRole;
@Service
public class RoleService extends BaseService<Role>{
//    public Set<String> listRoleNames(int id);
//   
//    public List<Role> listRoles(int id);
// 
//    public List<Role> list();
//    public void add(Role role);
//    public void delete(int id);
//    public Role get(int id);
//    public void update(Role role);
    @Autowired 
    RoleMapper roleMapper;
    
    @Autowired 
    UserRoleMapper userRoleMapper;
    
    @Autowired
    UserMapper userMapper;
    
	
	public Role selectRoleByUid(int id) {
		Integer rid = userRoleMapper.selectByUid(id);
		return roleMapper.selectByPrimaryKey(rid);
		
	}
	
	public Role selectByName(String roleName) {
	   return roleMapper.selectByName(roleName);
		
	}

//	public Set<String> listRoleNames(int id) {//根据用户查询所对应的角色名称。
//		// TODO Auto-generated method stub
//		Set<String> results = new HashSet<>();
//		List<Role> roles = listRoles(id);
//		for(Role role:roles) {
//			results.add(role.getName());
//		}
//		return results;
//	}
//	
//	public List<Role> listRolesByName(String userName) {  //根据用户id查询对应角色
//		// TODO Auto-generated method stub
//		List<Role> roles = new ArrayList<>();
//		  User user = userMapper.selectByUname(userName);
//	      int userId = user.getId();
//	      System.out.println(userId);
//		List<UserRole> userRoles = userRoleMapper.selectByUid(userId);
//		for(UserRole userRole: userRoles) {
//			Role role = roleMapper.selectByPrimaryKey(userRole.getRid());
//			roles.add(role);
//		}
//		return roles;
//	}
//
//	public List<Role> listRoles(int id) {  //根据用户id查询对应角色
//		// TODO Auto-generated method stub
//		List<Role> roles = new ArrayList<>();
//		List<UserRole> userRoles = userRoleMapper.selectByUid(id);
//		for(UserRole userRole: userRoles) {
//			Role role = roleMapper.selectByPrimaryKey(userRole.getRid());
//			roles.add(role);
//		}
//		return roles;
//	    
//		
//	}

	
}
