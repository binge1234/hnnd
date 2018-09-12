package com.hnnd.realm;

import java.util.Set;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.Subject;

import com.hnnd.entity.User;
import com.hnnd.entity.shiro.Role;
import com.hnnd.service.UserService;
import com.hnnd.service.shiro.PermissionService;
import com.hnnd.service.shiro.RoleService;



public class MyRealm extends AuthorizingRealm {

	@Resource
	private UserService userService;
	
	@Resource
	private RoleService roleService;
	
	@Resource
	private PermissionService permissionService;
	

	
	//授权方法
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
		SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
		//User  dbUser =(User) principalCollection.getPrimaryPrincipal();
		/*//基于资源的授权
		info.addStringPermission("product:add");
		
		//基于角色的授权
		info.addRole("admin");*/
		
		Subject subject = SecurityUtils.getSubject();
		User dbUser = (User)subject.getPrincipal();
		//给当前登录用户进行动态授权
		//1.获取当前用户的pricipal
        System.out.println(dbUser.getId());
		

//		Set<String> roles = new HashSet<>(); 
//		roles.add(role.getName());
		Set<String> permissions = permissionService.listPermissions(dbUser.getId());
        System.out.println(permissions);
		info.setStringPermissions(permissions);//将权限放在权限信息对象info
        info.addRole(dbUser.getRoleName());//将角色放在权限信息对象info
		return info;
	}

	//认证方法
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken arg0) throws AuthenticationException {

		// 1.获取用户输入的账户信息
		UsernamePasswordToken token = (UsernamePasswordToken) arg0;
        
        String userName = token.getUsername();
		
		System.out.println(userName);
		//实现动态认证

		User dbUser = userService.queryByUname(userName);
	
		if(dbUser==null){
			//用户不存在
			return null;
		}

		// 返回密码
		return new SimpleAuthenticationInfo(dbUser, dbUser.getPassword(), "");
	}

}
