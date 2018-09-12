package com.hnnd.controller;

import java.io.File;
import java.io.IOException;

import java.util.HashMap;
import java.util.List;
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
import com.hnnd.constant.Constant;
import com.hnnd.entity.ApplyExamInfo;
import com.hnnd.entity.CodeForCity;
import com.hnnd.entity.Course;
import com.hnnd.entity.Grade;
import com.hnnd.entity.Major;
import com.hnnd.entity.Notice;
import com.hnnd.enums.FlagEnum;
import com.hnnd.enums.StatusEnum;
import com.hnnd.service.ApplyExamInfoService;
import com.hnnd.service.BookService;
import com.hnnd.service.CodeForCityService;
import com.hnnd.service.CodeForDistrictService;
import com.hnnd.service.CourseService;
import com.hnnd.service.ExamLocationService;
import com.hnnd.service.MajorService;
import com.hnnd.service.NoticeService;
import com.hnnd.service.UserService;
import com.hnnd.util.PageBean;
import com.hnnd.util.RedisUtil;
import com.hnnd.util.ResponseUtil;
import com.hnnd.util.UploadedFile;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

@Controller
@RequestMapping(value = "/apply")
public class ApplyExamInfoController {
	@Autowired
	private ApplyExamInfoService applyExamInfoService;
	@Autowired
	private CourseService courseService;
	@Autowired
	private BookService bookService;
	@Autowired
	private MajorService majorService;
	@Autowired
	private CodeForCityService codeForCityService;
	@Autowired
	private CodeForDistrictService codeForDistrictService;
	@Autowired
	private ExamLocationService examLocationService;
	@Autowired
	private UserService userService;
	@Autowired
	private NoticeService noticeService;
	@Autowired
	private RedisUtil redisUtil;
	
	@RequestMapping("/selectApply")
	public String applySelect() {
		
		return "plan/applyManage";
	}
	@RequestMapping("/signupExam")
	public String signupExam() {
		
		return "exam/signupExam";
	}
	@RequestMapping("/addApplySkip")
	public String addApplySkip() {
		
		return "apply/applyAdd";
	}
	@RequestMapping("/applySearch")
	@ResponseBody
	public Map<String,Object> applySearch(int page, int rows) throws Exception {
		// 数据表格默认的参数是page和rows，通过请求来获得参数。
		PageBean<ApplyExamInfo> pageBean = new PageBean<>(page, rows);
		pageBean = applyExamInfoService.queryByPage(pageBean);
		Map<String,Object> map = new HashMap<>();
		map.put("rows", pageBean.getResult());
		map.put("total", pageBean.getTotal());
		return map;

	}
	@RequestMapping("/applyUpload")
	@ResponseBody
	public String applyUpload(@RequestParam(value = "filedoc", required = false)MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws IllegalStateException, IOException{
		Notice notice = (Notice)request.getServletContext().getAttribute("notice");
		if(notice.getAstate() == Constant.Apply_NO) {
			return null;
		}
		String name = RandomStringUtils.randomAlphanumeric(10);
        String newFileName = name + ".xlsx";
        File newFile = new File(request.getServletContext().getRealPath("/xlsx"), newFileName);
        newFile.getParentFile().mkdirs();
        file.transferTo(newFile);
        applyExamInfoService.imports(newFile);
		return "success";
	}
	
	@RequestMapping("/checkApply")
	@ResponseBody
	public String checkApply(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ApplyExamInfo applyExamInfo =applyExamInfoService.selectByPrimaryKey(Integer.parseInt(request.getParameter("id")));
		Notice notice = (Notice)request.getServletContext().getAttribute("notice");
		if(notice.getAstate() == Constant.Apply_OK) {
			return null;
		}
		if(applyExamInfo.getId()==null) {
			//no id error
			return null;
		}
		applyExamInfoService.check(applyExamInfo);
		//ResponseUtil.write(response, "success");
		return "success";
	}
	
	@RequestMapping("/addExamNumber")
	@ResponseBody
	public void addExamNumber(HttpServletRequest request, HttpServletResponse response) throws Exception {
		applyExamInfoService.setExamNumber();
		//ResponseUtil.write(response, "success");
	}
	
	@RequestMapping("/applyInsert")
	@ResponseBody
	public String applyInsert(String user_name,int course_id,String citycode,String districtcode,HttpServletRequest request){
		
		Notice notice = (Notice)request.getServletContext().getAttribute("notice");
		if(notice.getAstate() == Constant.Apply_OK) {
			return null;
		}
		ApplyExamInfo applyExamInfo=new ApplyExamInfo();
		int user_id=userService.queryByUname(user_name).getId();
		int majorid=courseService.selectMajorByPrimaryKey(course_id);
		int locationid=examLocationService.selectForApply(majorid,Integer.parseInt(citycode),Integer.parseInt(districtcode));
		applyExamInfo.setUser_id(user_id);
		applyExamInfo.setCourse_id(course_id);
		applyExamInfo.setLocation_id(locationid);
		applyExamInfo.setExam_classroom_id(0);
		applyExamInfo.setStatus(0);
		applyExamInfo.setResult(0);
		applyExamInfo.setExam_number("000000000");
		applyExamInfo.setSeat_number(0);
		ApplyExamInfo flag=applyExamInfoService.selectByUidCid(user_id,course_id);
		if(flag!=null){
			return "fail!";
		}
		applyExamInfoService.insertApply(applyExamInfo);
        return "success";
	}
	
	@RequestMapping("/cityList")
	public List<CodeForCity> cityList() {
		List<CodeForCity> codeForCity=codeForCityService.listAll();
		return codeForCity;
	}
	@RequestMapping("/courseSearch")
	@ResponseBody
	public Map<String,Object> courseSearch(Integer page, Integer rows,HttpServletRequest request){
		// 数据表格默认的参数是page和rows，通过请求来获得参数
		
		Map<String,Object> map = new HashMap<>();
		Notice notice = (Notice)request.getServletContext().getAttribute("notice");
		List<Course> courses=(List<Course>)redisUtil.get(Constant.Course_key);
		for(int i=0;i<courses.size();i++){
			Date now=new Date();
			Date endTime=courses.get(i).getEnd_time();
			if(now.after(endTime)){
				courses.remove(i);
				i--;
				continue;
			}
			String book_name=bookService.queryById(courses.get(i).getBook_id()).getName();
			String major_name=majorService.queryById(courses.get(i).getMajor_id()).getName();
			courses.get(i).setBook_name(book_name);
			courses.get(i).setMajor_name(major_name);
		}
		map.put("rows", courses);
		map.put("total", courses.size());
		return map;
	}
	@RequestMapping("/applyNotice_open")
	@ResponseBody
	public String applyNotice_open(HttpServletRequest request) {
		Notice notice = (Notice)request.getServletContext().getAttribute("notice");
		notice.setAstate(Constant.Apply_OK);
		noticeService.updateState(notice);
		request.getServletContext().setAttribute("notice", notice);
		List<Course> courses = courseService.listAll();
		//将所有课程信息放入redis中
		String key = Constant.Course_key;
         redisUtil.set(key,courses);
         System.out.println(redisUtil.get(key));
		return "success";
	}
	
	@RequestMapping("/applyNotice_off")
	@ResponseBody
	public String applyNotice_off(HttpServletRequest request) {
		Notice notice = (Notice)request.getServletContext().getAttribute("notice");
		notice.setAstate(Constant.Apply_NO);
		noticeService.updateState(notice);
		request.getServletContext().setAttribute("notice", notice);
		return "success";
	}
	   
}









