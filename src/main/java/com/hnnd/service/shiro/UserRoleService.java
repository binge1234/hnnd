package com.hnnd.service.shiro;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hnnd.base.BaseService;
import com.hnnd.dao.UserMapper;
import com.hnnd.dao.UserRoleMapper;
import com.hnnd.entity.User;
import com.hnnd.entity.shiro.UserRole;

@Service
public class UserRoleService extends BaseService<UserRole>{
//    public void setRoles(User user, int[] roleIds);
//    public void deleteByUser(int userId);
//    public void deleteByRole(int roleId);
	@Autowired
	UserRoleMapper userRoleDAO;
    @Autowired
    UserMapper userDAO;
	public void setRole(User user, int roleId) {
		// TODO Auto-generated method stub
      //删除当前用户的所有角色
		userRoleDAO.deleteByUid(user.getId());
		

				UserRole userRole = new UserRole();
				userRole.setRid(roleId);
				userRole.setUid(user.getId());
				insert(userRole);
			
	}
	
	public List<Integer> getUsersByRid(int roleId){
		List<Integer> userIds = userRoleDAO.selectByRid(roleId);
		return userIds;
		
	}


	public void deleteByUser(int userId) {
		// TODO Auto-generated method stub
		userRoleDAO.deleteByUid(userId);

	}


	public void deleteByRole(int roleId) {
		// TODO Auto-generated method stub
		userRoleDAO.deleteByRid(roleId);

	}
    

}
