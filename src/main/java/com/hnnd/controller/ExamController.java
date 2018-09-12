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

import com.fasterxml.jackson.databind.ObjectMapper;
import com.hnnd.entity.CodeForDistrict;
import com.hnnd.entity.ExamLocation;
import com.hnnd.service.CodeForCityService;
import com.hnnd.service.CodeForDistrictService;
import com.hnnd.service.ExamClassroomService;
import com.hnnd.service.ExamLocationService;
import com.hnnd.util.PageBean;
import com.hnnd.util.ResponseUtil;

@Controller
@RequestMapping(value = "/")
public class ExamController {

	@Autowired
	ExamLocationService examLocationService;
	
	@Autowired
	ExamClassroomService examClassroomService;
	
	@Autowired
	CodeForDistrictService codeForDistrictService;
	
	@Autowired
	CodeForCityService cityService;	
	
	@RequestMapping("/exam/signupExam")
	public String signupExam() {

		return "exam/signupExam";
	}

	@RequestMapping("/examprovince/findExamProvice")
	public String findExamProvice() {

		return "examprovince/findExamProvice";
	}

	@RequestMapping("/examLocation/insertExamLocation")
	@ResponseBody
	public void examlocationAdd(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// System.out.println("at insert examLocation");
		ExamLocation examLocation = new ExamLocation();
		// examLocation.setId(Integer.parseInt(request.getParameter("id")));
		examLocation.setLocation(request.getParameter("location"));
		examLocation.setCitycode(Integer.parseInt(request.getParameter("citycode")));
		examLocation.setDistrictcode(Integer.parseInt(request.getParameter("districtcode")));
		examLocation.setLocation_status(0); // Status
		examLocation.setCapacity(Integer.parseInt(request.getParameter("capacity")));
		examLocationService.insert_examLocation(examLocation);// 保存新的考点
		examLocationService.gen_examLocationCode();// 生成并保存考点代号
	}

	@RequestMapping("/examLocation/startExamLocation")
	@ResponseBody
	public void examlocationStart(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// System.out.println("at start examLocation");
		ExamLocation examLocation = new ExamLocation();
		examLocation.setId(Integer.parseInt(request.getParameter("id")));
		examLocationService.start_examLocation(examLocation);
	}

	@RequestMapping("/examLocation/stopExamLocation")
	@ResponseBody
	public void examlocationStop(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ExamLocation examLocation = new ExamLocation();
		examLocation.setId(Integer.parseInt(request.getParameter("id")));
		examLocationService.stop_examLocation(examLocation);
	}

	/*
	 * 处理“展示管理考点功能页面”的请求
	 */
	@RequestMapping("/examLocation/selectExamLocation")
	public String examlocationShow() {
		return "plan/locationManage";
	}

	/*
	 * 处理“查找/列出所有考点”的请求
	 */
	@RequestMapping("/examLocation/listExamLocation")
	@ResponseBody
	public void examlocationList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String Page = request.getParameter("page");
		String pageSize = request.getParameter("rows");

		int page = Integer.parseInt(Page);
		int size = Integer.parseInt(pageSize);
		PageBean<ExamLocation> pageBean = new PageBean<>(page, size);
		pageBean = examLocationService.queryByPage(pageBean);

		List<ExamLocation> myList = pageBean.getResult();
		/*
		 * for(ExamLocation c: myList) { c.setCode(); }
		 */

		Map<String, Object> map = new HashMap<>();
		map.put("rows", myList);
		map.put("total", pageBean.getTotal());

		ObjectMapper mapper = new ObjectMapper();
		String jsonfromMap = mapper.writeValueAsString(map);
		// 将status的值改为"启用"或"停用"
		String json2 = jsonfromMap.replace("\"location_status\":0", "\"location_status\":\"停用\"");
		String json3 = json2.replace("\"location_status\":1", "\"location_status\":\"启用\"");
		// System.out.println(json3);
		/*
		 * JsonNode jsonNode = Json.parse(jsonStr); ObjectNode objectNode = (ObjectNode)
		 * jsonNode; objectNode.put(key,value);
		 */

		ResponseUtil.write(response, json3);
		// return map;

	}

	/*
	 * 处理“修改考点的开考专业”请求
	 */
	@RequestMapping("/examLocation/addLocationMajor")
	@ResponseBody
	public void addLocationMajor(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ExamLocation examLocation = new ExamLocation();
		examLocation.setId(Integer.parseInt(request.getParameter("id")));
		examLocation.setMajorid(Integer.parseInt(request.getParameter("majorid")));
		// System.out.println("id:"+examLocation.getId()+"
		// majorid:"+examLocation.getMajorid());
		examLocationService.add_LocationMajor(examLocation);
	}

	/*
	 * 处理“删除考点的开考专业”请求
	 */
	@RequestMapping("/examLocation/delLocationMajor")
	@ResponseBody
	public void delLocationMajor(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ExamLocation examLocation = new ExamLocation();
		examLocation.setId(Integer.parseInt(request.getParameter("id")));
		examLocationService.del_LocationMajor(examLocation);
	}

	/*
	 * 成功上传考场后，处理“修改考点总容纳量”的请求
	 */
	@RequestMapping("/examLocation/updateTotolCapacity")
	@ResponseBody
	public int importLocationClassroom(HttpServletRequest request, HttpServletResponse response) throws Exception {

		examLocationService.updateTotalCapacity(Integer.parseInt(request.getParameter("id")));
		return 1;
	}
	
	@RequestMapping("/examClassroom/classroomUpload")
	@ResponseBody
	public long majorUpload(HttpServletRequest request,@RequestParam("file") MultipartFile file,String id) throws IllegalStateException, IOException{

		if (file.isEmpty()) {
            return  -1;
        }
		
		String name = RandomStringUtils.randomAlphanumeric(10);
        String newFileName = name + ".xlsx";
       
        File newFile = new File(request.getServletContext().getRealPath("/xlsx"),newFileName);//File(request.getServletContext().getRealPath("/xlsx"), newFileName);
        newFile.getParentFile().mkdirs();
        
        file.transferTo(newFile);

        //System.out.println("**********id is "+id);
        //int id=Integer.parseInt(request.getParameter("id"));
        long ret= examClassroomService.imports(newFile,Integer.parseInt(id));
        
        return ret;
		//return 0;
	}
	@RequestMapping("/city/loadCity")
	@ResponseBody
	public void loadCity(HttpServletRequest request, HttpServletResponse response) throws Exception {
		

		
		
		ObjectMapper mapper = new ObjectMapper(); 
		String json=mapper.writeValueAsString(cityService.listAll());
		ResponseUtil.write(response, json);
	}
	
	@RequestMapping("/district/loadDistrict")
	@ResponseBody
	public void loadDistrict(HttpServletRequest request, HttpServletResponse response) throws Exception {
		CodeForDistrict codeForDistrict=new CodeForDistrict();
		codeForDistrict.setCitycode(Integer.parseInt(request.getParameter("citycode")));
		
		/*String jsonStr=JSON.toJSONString(codeForDistrictService.selectByCity(codeForDistrict));
		JSONArray array = JSONArray.parseArray(jsonStr);*/
		
		ObjectMapper mapper = new ObjectMapper(); 
		String json=mapper.writeValueAsString(codeForDistrictService.selectByCity(codeForDistrict));
		ResponseUtil.write(response, json);
	}

}
