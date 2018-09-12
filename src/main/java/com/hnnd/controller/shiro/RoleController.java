package com.hnnd.controller.shiro;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hnnd.entity.shiro.Permission;
import com.hnnd.entity.shiro.Role;
import com.hnnd.entity.shiro.UserRole;
import com.hnnd.service.shiro.PermissionService;
import com.hnnd.service.shiro.RolePermissionService;
import com.hnnd.service.shiro.RoleService;
import com.hnnd.service.shiro.UserRoleService;
import com.hnnd.util.PageBean;

@Controller
@RequestMapping(value = "/role")
public class RoleController {
	@Autowired
	RoleService roleService;
	
	@Autowired
	RolePermissionService rolePermissionService;
	
	@Autowired
	UserRoleService userRoleService;
	
	@Autowired
	PermissionService permissionService;
	
	@RequestMapping("/selectRole")
	public String roleSelect() {
		
		return "sys/roleManage";
	}
	
	@RequestMapping("/roleSearch")
	@ResponseBody
	public Map<String,Object> roleSearch(int page,int rows) {
		PageBean<Role> pageBean = new PageBean<>(page, rows);
		pageBean = roleService.queryByPage(pageBean);
		List<Role> perms = pageBean.getResult();
		
		Map<String,Object> map = new HashMap<>();
		map.put("rows", perms);
		map.put("total", pageBean.getTotal());
		
		return map;
		
	}
	@RequestMapping("/roleDelete")
	@ResponseBody
	public String roleDelete(Integer id,HttpServletRequest request) {
		rolePermissionService.deleteByRole(id);
		roleService.delete(id);
     //删除角色后，将该角色对应的用户改为“未定义”
		List<Integer> userIds = userRoleService.getUsersByRid(id);
		for(int uid:userIds) {
			UserRole userRole = new UserRole();
			userRole.setRid(5);
			userRole.setUid(uid);
		}
		List<Role> roles = roleService.listAll();
		request.getServletContext().setAttribute("roles",roles);//获得删除之后的所有角色，添加到servlet容器中
		
		return "success";
	}
	
	@RequestMapping("/roleInsert")
	@ResponseBody
	public String roleInsert(Role role,HttpServletRequest request) {
		Date date= new Date();
		role.setStartdate(date);
		System.out.println(role.getName());
		System.out.println(role.getRemark());
		roleService.insert(role);
		List<Role> roles = roleService.listAll();
		request.getServletContext().setAttribute("roles",roles);//获得添加之后的所有角色，添加到servlet容器中
		return "success";
	}
	
	@RequestMapping("/permSearch")
	@ResponseBody
	public String permSearch(Role role,HttpServletRequest request) {//点击修改角色的按钮加载对应的权限
		System.out.println(role.getId());
		List<Permission> currPermissions = permissionService.listByRole(role);
		for(Permission permission: currPermissions) {
			System.out.println(permission.getName());
		}
		request.getSession().setAttribute("currPermissions", currPermissions);
		
		return "success";
		
		
	}
	
	@RequestMapping("/roleUpdate")
	@ResponseBody
	public String permUpdate(Role role,int[] permissionIds,HttpServletRequest request) {
		Date date = new Date();
		role.setUpdatedate(date);
		System.out.println(role.getName());
		System.out.println(permissionIds);
		roleService.update(role);
		rolePermissionService.setPermissions(role, permissionIds);
		List<Role> roles = roleService.listAll();
		request.getServletContext().setAttribute("roles",roles);//获得添加之后的所有角色，添加到servlet容器中
		return "success";
		
	}
	
	@RequestMapping("/loadPermission")
	public String load() {
		return "sys/listPermission";
		
	}
	
	@RequestMapping("/loadPermission1")
	public String load1() {
		return "sys/listPermission1";
	}
	
	
	
	
		
}
