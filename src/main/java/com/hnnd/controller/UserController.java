package com.hnnd.controller;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.code.kaptcha.Producer;
import com.hnnd.entity.User;
import com.hnnd.entity.shiro.Role;
import com.hnnd.entity.shiro.UserRole;
import com.hnnd.service.UserService;
import com.hnnd.service.shiro.RoleService;
import com.hnnd.service.shiro.UserRoleService;

@Controller
@RequestMapping("/")
public class UserController {
	@Autowired
	private Producer captchaProducer ;
   @Autowired
   UserService userService;
   @Autowired
   RoleService roleService;
   @Autowired
   UserRoleService userRoleService;
	@RequestMapping("/hello")
	public String hello() {
		return "login";
	}
	/**
	 * 登录
	 */
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(User user,HttpServletRequest request,Model model,String code){
		//使用Shiro的认证操作
		//1. 获取Subject对象
		String true_code = (String)request.getSession().getAttribute("verify_code");
		
		code = code.trim().toUpperCase();
		System.out.println(true_code);
		System.out.println(code);
		if(code.equals(true_code)) {//首先判断验证码是否正确，若不正确，直接返回.
		Subject subject= SecurityUtils.getSubject();
         String userName = user.getName();
		//2.封装用户信息
		AuthenticationToken token = new UsernamePasswordToken(userName, user.getPassword());
		
		//3.执行认证
		try {
			
			subject.login(token);
			System.out.println("执行");
			User dbUser = (User)subject.getPrincipal();
			Role role = roleService.selectRoleByUid(dbUser.getId());
			dbUser.setRoleName(role.getName());//获得用户的角色

			if(dbUser.getRoleName().equals("学生")) {
			//进入学生界面
			request.getSession().setAttribute("user", dbUser);
			return "studentmain";
			}
			if(dbUser.getRoleName().equals("未定义")) {
				return "exception/500";
			}
			request.getSession().setAttribute("user", dbUser);
			//登录成功,进入首页
			return "main";
		} catch (UnknownAccountException e) {
			model.addAttribute("msg", "用户不存在");
		} catch (IncorrectCredentialsException e) {
			model.addAttribute("msg", "密码输入有误");
		}
		}
		
		else {//验证码不正确
			model.addAttribute("msg","验证码不正确");
		}
		//登录失败，返回登陆界面.
		return "login";
	}
	
	@RequestMapping("/home")
    public String home() {
    		
    	return "client/home";
    }
    
    @RequestMapping("/aboutSystem")
    public String aboutSystem() {
    		
    	return "client/aboutSystem";
    }
	
	@RequestMapping("/user/selectUser")
	public String userSelect() {
		
		return "sys/userManage";
	}

        @RequestMapping("/studentlogin")
	public String studentlogin() {
		
		return "studentmain";
	}
	
    	@RequestMapping("/user/userSearch")
    	@ResponseBody
    	public Map<String, Object> userSearch(int rows, int page,
    			@RequestParam(value = "type", required = false, defaultValue = "无") String type,
    			@RequestParam(value = "keywords", required = false) String keywords) {
    		Map<String, Object> map = new HashMap<>();
    		map.put("type", type);
    		map.put("keywords", keywords);
    		int total = userService.getTotal(map);
    		System.out.println(total);

    		map.put("size", rows);
    		map.put("start", rows * (page - 1));
    		List<User> users = userService.getUsersByParams(map);
    		for (User user : users) {
    			String roleName = roleService.selectRoleByUid(user.getId()).getName();
    			if (roleName != null)
    				user.setRoleName(roleName);
    			System.out.println(roleName);
    		}
    		map.clear();
    		map.put("rows", users);
    		map.put("total", total);

    		return map;
    	}

	
	@RequestMapping("/user/userInsert")
	@ResponseBody
	public String userInsert(User user) {
		Date date = new Date();
		user.setStartdate(date);
		System.out.println(date);
		userService.insert(user);

			Role role = roleService.selectByName(user.getRoleName());
			System.out.println(role.getName());
			userRoleService.setRole(user, role.getId());
		
		return "success";
	}
	
	@RequestMapping("/user/userRegister")
	@ResponseBody
	public Map<String, Object> userRegister(User user) {
		Map<String, Object> map=new HashMap<>();
		Date date = new Date();
		user.setStartdate(date);
		System.out.println(date);
		if(userService.queryByUname(user.getName())!=null){
			map.put("msg", "账户已存在");
			return map;
		}
		userService.insert(user);
		UserRole userRole = new UserRole();
		userRole.setRid(4);//5代表学生的角色
		userRole.setUid(userService.queryByUname(user.getName()).getId());
		userRoleService.insert(userRole);//添加学生与角色的关系.
		map.put("msg", "注册成功");
		return map;
	}
	
    @RequestMapping("/user/userDelete")
    @ResponseBody
    public String userDelete(Integer id) {
    	userService.delete(id);
    	userRoleService.deleteByUser(id);
    	return "success";
    }
    
    @RequestMapping("/user/userUpdate")
    @ResponseBody
    public String userUpdate(User user) {
    	System.out.println(user.getStartdate());
    	System.out.println(user);
    	Date date = new Date();
    	user.setUpdatedate(date);
    	userService.update(user);
    	System.out.println(user);
    	if(user.getRoleName() !=null) {//更改用户的角色
    	int roleId = roleService.selectByName(user.getRoleName()).getId(); 
    	System.out.println(roleId);
    	userRoleService.setRole(user, roleId);
    	}
    	return "success";
    	
    }
    
    @RequestMapping("/user/userCheck")
    @ResponseBody
    public String userCheck(String name) {
    	List<User> users = userService.listAll();
    	for(User user1:users) {
    		if(user1.getName().equals(name)) {
    			return "fail";
    		}
    	}
    	return "success";
    }
	
		
	
	
	@RequestMapping("/kaptcha-image")
	public void handleCode(HttpServletRequest request,HttpServletResponse response) throws IOException{
		
		  // Set to expire far in the past.
      response.setDateHeader("Expires", 0);
      // Set standard HTTP/1.1 no-cache headers.
      response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
      // Set IE extended HTTP/1.1 no-cache headers (use addHeader).
      response.addHeader("Cache-Control", "post-check=0, pre-check=0");
      // Set standard HTTP/1.0 no-cache header.
      response.setHeader("Pragma", "no-cache");
        
      // return a jpeg
      response.setContentType("image/jpeg");

      // create the text for the image
      String capText = captchaProducer.createText();
      System.out.println(capText);
      // store the text in the session
      request.getSession().setAttribute("verify_code", capText.toUpperCase());
      
      System.out.println((String)request.getSession().getAttribute("verify_code"));
      // create the image with the text
      BufferedImage bi = captchaProducer.createImage(capText);

      ServletOutputStream out = response.getOutputStream();
      
      // write the data out
      ImageIO.write(bi, "jpg", out);
      try
      {
              out.flush();
      }
      finally
      {
              out.close();
      }
      System.out.println("已经生成图片");
		
		
	}
   @RequestMapping("/user/logout")
   public void clearSession(HttpServletRequest request) {
	  HttpSession session = request.getSession();
	  
	  session.invalidate();
	  System.out.println("清空缓存");
	  System.out.println(session.getAttribute("user"));
	   
   }
	
	
}
