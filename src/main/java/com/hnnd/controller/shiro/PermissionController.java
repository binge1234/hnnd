package com.hnnd.controller.shiro;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hnnd.entity.User;
import com.hnnd.entity.shiro.Permission;
import com.hnnd.entity.shiro.Role;
import com.hnnd.service.shiro.PermissionService;
import com.hnnd.service.shiro.RolePermissionService;
import com.hnnd.util.PageBean;

@Controller
@RequestMapping(value = "/permission")
public class PermissionController {
	@Autowired
	PermissionService permissionService;
	@Autowired
	RolePermissionService rolePermissionService;
	@RequestMapping("/selectPermission")
	public String permissionSelect() {
		
		return "sys/permissionManage";
	}
	@RequestMapping("/permSearch")
	@ResponseBody
	public Map<String, Object> permSearch(int rows, int page,
			@RequestParam(value = "type", required = false, defaultValue = "无") String type,
			@RequestParam(value = "keywords", required = false) String keywords) {
		Map<String, Object> map = new HashMap<>();
		System.out.println(type);
		System.out.println(keywords);
		map.put("type", type);
		map.put("keywords", keywords);
		int total = permissionService.getTotal(map);
		System.out.println(total);
        
		map.put("size", rows);
		map.put("start", rows * (page - 1));
		List<Permission> users = permissionService.getUsersByParams(map);

		map.clear();
		map.put("rows", users);
		map.put("total", total);

		return map;
	}
	
	@RequestMapping("/permSearch1")
	@ResponseBody
	public List<Permission> permSearch1() {
        List<Permission> permissions = permissionService.listAll();
        return  permissions;
	}
	
	@RequestMapping("/permInsert")
	@ResponseBody
	public String permInsert(Permission perm,HttpServletRequest request) {
		
		Date date = new Date();
		perm.setStartdate(date);
		System.out.println(date);
		permissionService.insert(perm);
		List<Permission> permissions = permissionService.listAll();
		request.getServletContext().setAttribute("permissions",permissions);//获得添加之后的所有权限，添加到servlet容器中
		return "success";
	}
	
	@RequestMapping("/permDelete")
	@ResponseBody
	public String permDelete(Integer id,HttpServletRequest request) {
		permissionService.delete(id);
		rolePermissionService.deleteByPermission(id);
		List<Permission> permissions = permissionService.listAll();
		request.getServletContext().setAttribute("permissions",permissions);//获得删除之后的所有权限，添加到servlet容器中        
		return "success";
		
	}
	
	@RequestMapping("/permUpdate")
	@ResponseBody
	public String permUpdate(Permission permission,HttpServletRequest request) {
	
		System.out.println(permission.getRemark());
		Date date = new Date();
		permission.setUpdatedate(date);
            permissionService.update(permission);
    		List<Permission> permissions = permissionService.listAll();
    		request.getServletContext().setAttribute("permissions",permissions);//获得修改之后的所有权限，添加到servlet容器中
		return "success";
	}
	
	
}
