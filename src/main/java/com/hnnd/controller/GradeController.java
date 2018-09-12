package com.hnnd.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.xwork.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.hnnd.constant.Constant;
import com.hnnd.entity.Grade;
import com.hnnd.entity.Notice;
import com.hnnd.entity.User;
//import com.hnnd.entity.Major;
//import com.hnnd.enums.FlagEnum;
//import com.hnnd.enums.StatusEnum;
import com.hnnd.service.GradeService;
import com.hnnd.service.NoticeService;
import com.hnnd.util.PageBean;
import com.hnnd.util.RedisUtil;

//告诉spring mvc这是一个控制器类
@Controller
@RequestMapping(value = "/grade")
public class GradeController {
	@Autowired
	private GradeService gradeService;
	
	@Autowired
	private NoticeService noticeService;
	
	@Autowired
	private RedisUtil redisUtil;
	
	@RequestMapping("/selectGrade")
	public String gradeSelect() {
		
		return "grade/gradeManage";
	}
	
	@RequestMapping("/findGrade")
	public String findGrade() {
		
		return "grade/findGrade";
	}

	@RequestMapping("/selectCourse")
	public String courseSelect() {
		
		return "grade/courseManage";
	}
	
	@RequestMapping("/selectUser")
	public String userSelect() {
		
		return "grade/userManage";
	}
	
	@RequestMapping("/gradeSearch")
	@ResponseBody
	public Map<String,Object> gradeSearch(@RequestParam(value="key",required =false)String key, int page, int rows) throws Exception {
		// 数据表格默认的参数是page和rows，通过请求来获得参数。
		Map<String,Object> map = new HashMap<>();
        if(key == null){
		PageBean<Grade> pageBean = new PageBean<>(page, rows);
		pageBean = gradeService.queryByPage(pageBean);
		map.put("rows", pageBean.getResult());
		map.put("total", pageBean.getTotal());
        }
        else{
        	List<Grade> grades = gradeService.SearchErrorByPage();
        	map.put("rows", grades);
        	map.put("total", 10);
        }
		return map;

	}
	
	@RequestMapping("/gradeSearchByStudent")
	@ResponseBody
	public Map<String,Object> gradeSearchByStudent(HttpServletRequest request,@RequestParam(value="key",required =false)String key,Integer page,Integer rows){
		List<Grade> grades = new ArrayList<>();
		Map<String,Object> map = new HashMap();
	    Notice notice = (Notice)request.getServletContext().getAttribute("notice");
	    User user = (User)request.getSession().getAttribute("user");
	    System.out.println(user.getId());
		if(notice.getGstate()==Constant.Grade_No) {
			return null;
		}

		if(key!=null){
			grades = gradeService.SearchErrorByPage();
		}
		else{
		    String pattern = Constant.Grade_key + user.getId() + "*";//创建匹配的key
		    Set<String> keys = redisUtil.getKeys(pattern);
		    //获取所有的从redis得到的grade并放入list
		    for(String key1:keys) {
		    	Grade grade = (Grade)redisUtil.get(key1);
		    	grades.add(grade);
		    }
		    
		}
		map.put("rows",grades);
		map.put("total",13);


		return map;
	}
	
	@RequestMapping("/selectErrorGrade")
	@ResponseBody
	public List<Grade> selectErrorGrade(){

		Map<String,Object> map = new HashMap();
		List<Grade> grades = gradeService.SearchErrorByPage();



		return grades;
	}
	
	@RequestMapping("/gradeUpload")
	@ResponseBody
	public String gradeUpload(@RequestParam(value = "filegradedoc", required = false)MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws IllegalStateException, IOException{
	    Notice notice = (Notice)request.getServletContext().getAttribute("notice");
		if(notice.getGstate()==Constant.Grade_OK) {
			return null;
		}	
		String name = RandomStringUtils.randomAlphanumeric(10);
        String newFileName = name + ".xlsx";
        File newFile = new File(request.getServletContext().getRealPath("/xlsx"), newFileName);
        newFile.getParentFile().mkdirs();
        file.transferTo(newFile);
        gradeService.imports(newFile);
		return "success";
	}

	@RequestMapping("/gradeUsualViolate")
	@ResponseBody
	public String gradeUsualViolate(Grade grade,HttpServletRequest request){
	    Notice notice = (Notice)request.getServletContext().getAttribute("notice");
		if(notice.getGstate()==Constant.Grade_OK) {
			return null;
		}	
		if(grade.getId()==null||grade.getName()==null) {
			//no id error
			System.out.println("有空值异常！");
			return "failed";
		}
		gradeService.UsualViolate(grade);
		return "success";
	}
	
	@RequestMapping("/gradeSeriousViolate")
	@ResponseBody
	public String gradeSeriousViolate(Grade grade,HttpServletRequest request){
	    Notice notice = (Notice)request.getServletContext().getAttribute("notice");
		if(notice.getGstate()==Constant.Grade_OK) {
			return null;
		}	

		if(grade.getId()==null||grade.getName()==null) {
			//no id error
			System.out.println("有空值异常！");
			return "failed";
		}
		gradeService.SeriousViolate(grade);
		return "success";
	}
	
	@RequestMapping("/gradeError")
	@ResponseBody
	public String gradeError(Integer course_id,HttpServletRequest request){
	    Notice notice = (Notice)request.getServletContext().getAttribute("notice");
		if(notice.getGstate()==Constant.Grade_OK) {
			return null;
		}	
		Grade grade = new Grade();
		grade.setCourse_id(course_id);
		gradeService.GradeError(grade);
		return "success";
	}
	
	@RequestMapping("/gradeUpdate")
	@ResponseBody
	public String gradeUpdate(Grade grade,HttpServletRequest request) {
	    Notice notice = (Notice)request.getServletContext().getAttribute("notice");
		if(notice.getGstate()==Constant.Grade_OK) {
			return null;
		}	
		gradeService.update(grade);
		return "success";
	}
	
	@RequestMapping("/gradeInsert")
	@ResponseBody
	public String gradeInsert(Grade grade,HttpServletRequest request ){
	    Notice notice = (Notice)request.getServletContext().getAttribute("notice");
		if(notice.getGstate()==Constant.Grade_OK) {
			return null;
		}	
		gradeService.insert(grade);
        return "success";
	}

	@RequestMapping("/gradeDelete")
	@ResponseBody
	public String gradeDelete(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    Notice notice = (Notice)request.getServletContext().getAttribute("notice");
		if(notice.getGstate()==Constant.Grade_OK) {
			return null;
		}
		Grade grade = new Grade();
		grade.setId(Integer.parseInt(request.getParameter("id")));
		if(grade.getId()==null) {
			//no id error
			return "null";
		}
		gradeService.delete(grade.getId());
		//ResponseUtil.write(response, "success");
		return "success";
	}
	
	@RequestMapping("/gradeNotice_open")
	@ResponseBody
	public String gradeNotice_On(HttpServletRequest request) {
		
		redisUtil.set(Constant.Grade_key,"1");
		System.out.println("从redis中获得值：" +redisUtil.get(Constant.Grade_key));
		redisUtil.delAll(Constant.Grade_key);
		Notice notice = (Notice)request.getServletContext().getAttribute("notice");
		notice.setGstate(Constant.Grade_OK);
		noticeService.updateState(notice);
		request.getServletContext().setAttribute("notice", notice);
		List<Grade> grades = gradeService.listAll();
		//将所有成绩放入redis中
		for(Grade grade: grades) {
			String key = Constant.Grade_key + grade.getUser_id() + grade.getId();//自定义key值
			redisUtil.set(key, grade);
			System.out.println(key);
		}

		
		return "success";
	}
	
	@RequestMapping("/gradeNotice_off")
	@ResponseBody
	public String gradeNotice_Off(HttpServletRequest request) {
		Notice notice = (Notice)request.getServletContext().getAttribute("notice");
		notice.setGstate(Constant.Grade_No);
		noticeService.updateState(notice);
		request.getServletContext().setAttribute("notice", notice);
		return "success";
	}
	
	
	   
	
}		
	

