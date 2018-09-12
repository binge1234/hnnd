package com.hnnd.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.xwork.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.hnnd.entity.Major;
import com.hnnd.enums.FlagEnum;
import com.hnnd.enums.StatusEnum;
import com.hnnd.service.MajorService;
import com.hnnd.util.PageBean;
import com.hnnd.util.ResponseUtil;
import com.hnnd.util.UploadedFile;


//告诉spring mvc这是一个控制器类
@Controller
@RequestMapping(value = "/major")
public class MajorController {
	@Autowired
	private MajorService majorService;
	
	
	@RequestMapping("/selectMajor")
	public String majorSelect() {
		
		return "plan/majorManage";
	}

	@RequestMapping("/selectCourse")
	public String courseSelect() {
		
		return "major/courseManage";
	}

	@RequestMapping("/majorSearch")
	@ResponseBody
	public Map<String,Object> majorSearch(int page, int rows) throws Exception {
		// 数据表格默认的参数是page和rows，通过请求来获得参数。
		PageBean<Major> pageBean = new PageBean<>(page, rows);
		pageBean = majorService.queryByPage(pageBean);
		Map<String,Object> map = new HashMap<>();
		map.put("rows", pageBean.getResult());
		map.put("total", pageBean.getTotal());
		return map;

	}
	
	@RequestMapping("/majorUpload")
	@ResponseBody
	public String majorUpload(@RequestParam(value = "filedoc", required = false)MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws IllegalStateException, IOException{
		String name = RandomStringUtils.randomAlphanumeric(10);
        String newFileName = name + ".xlsx";
        File newFile = new File(request.getServletContext().getRealPath("/xlsx"), newFileName);
        newFile.getParentFile().mkdirs();
        file.transferTo(newFile);
        majorService.imports(newFile);
		return "Upload success!";
	}
	
	
	@RequestMapping("/majorStart")
	@ResponseBody
	public void majorStart(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Major major = new Major();
		major.setId(Integer.parseInt(request.getParameter("id")));
		if(major.getId()==null) {
			//no id error
			return ;
		}
		majorService.start(major);
		//ResponseUtil.write(response, "success");
		
	}
	
	@RequestMapping("/majorDelete")
	@ResponseBody
	public void majorDelete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Major major = new Major();
		major.setId(Integer.parseInt(request.getParameter("id")));
		if(major.getId()==null) {
			//no id error
			return ;
		}
		majorService.delete(major);
		//ResponseUtil.write(response, "success");
		
	}
	
	@RequestMapping("/majorInsert")
	@ResponseBody
	public String majorInsert(Major major){
		major.setStatus(StatusEnum.STOP);
		major.setFlag(FlagEnum.NO);
		System.out.println(major.getId()+" "+major.getName()+" "+major.getDetails());
		majorService.insert(major);
        return "Insert success!";
	}
	@RequestMapping("/listNoLocation")
	@ResponseBody
	public void majorLocationSearch(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ObjectMapper mapper = new ObjectMapper(); 
		String jsonStr = mapper.writeValueAsString(majorService.selectNoLocationMajor());
		ResponseUtil.write(response, jsonStr);
	}
	
}