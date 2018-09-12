package com.hnnd.config.listener;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

import com.hnnd.entity.Major;
import com.hnnd.entity.Notice;
import com.hnnd.entity.shiro.Permission;
import com.hnnd.entity.shiro.Role;
import com.hnnd.service.MajorService;
import com.hnnd.service.NoticeService;
import com.hnnd.service.shiro.PermissionService;
import com.hnnd.service.shiro.RoleService;


@Component
public class InitDataListener implements ServletContextListener,ApplicationContextAware{//web应用容器初始化

	private static ApplicationContext applicationContext;
	
	@Override
	public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
		// TODO Auto-generated method stub
		InitDataListener.applicationContext = applicationContext;
	}

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		// TODO Auto-generated method stub
		//获取Servlet上下文
		ServletContext application = sce.getServletContext();
		//在容器获取专业Service层对象
		MajorService majorService = applicationContext.getBean(MajorService.class);
		RoleService roleService = applicationContext.getBean(RoleService.class);
		PermissionService permissionService = applicationContext.getBean(PermissionService.class);
		NoticeService noticeService = (NoticeService)applicationContext.getBean(NoticeService.class);
		//通过MajorService获得所有专业信息
		List<Major> majors = majorService.listAll();
		List<Role> roles = roleService.listAll();
		List<Permission> permissions = permissionService.listAll();
		Notice notice = noticeService.getState();
		//将所有专业信息放入applicaton容器
		if(majors != null) {
		application.setAttribute("majors",majors);
		}
		application.setAttribute("roles",roles);
		application.setAttribute("permissions",permissions);
		application.setAttribute("notice", notice);
		
		
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		// TODO Auto-generated method stub		
	}

}
