package com.hnnd.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class ExceptionController {//�ÿ�����������ɫδ��ȡ���Ȩ����ת����Ӧ���档
	
    @RequestMapping("/unauthorized")
	public String Excepting() {
    	return "exception/500";
    }
}
