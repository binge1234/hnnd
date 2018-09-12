package com.hnnd.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class ExceptionController {//该控制器用来角色未获取相关权限跳转到相应界面。
	
    @RequestMapping("/unauthorized")
	public String Excepting() {
    	return "exception/500";
    }
}
