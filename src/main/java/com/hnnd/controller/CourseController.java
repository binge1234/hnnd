package com.hnnd.controller;

import java.io.File;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.xwork.RandomStringUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hnnd.entity.Book;
import com.hnnd.entity.Course;
import com.hnnd.entity.Major;
import com.hnnd.enums.CourseTypeEnum;
import com.hnnd.service.BookService;
import com.hnnd.service.CourseService;
import com.hnnd.service.MajorService;
import com.hnnd.util.PageBean;
import com.hnnd.util.UploadedFile;


@Controller
@RequestMapping(value = "/course")
public class CourseController {
	
	ObjectMapper mapper = new ObjectMapper();

	@Autowired
	private CourseService courseService;
	@Autowired
	private MajorService majorService;
	@Autowired
	private BookService bookService;
	
	private List<Major> majors;
	private List<Book> books;
	
	@RequestMapping("/selectCourse")
	public String courseSelect() {
		majors = majorService.listAll();
		books = bookService.listAll();
		for( Major major : majors ) {
			System.out.println(major.getName());
		}
		return "plan/courseManage";
	}
	
	@RequestMapping("/courseUpload")
	@ResponseBody
	public String courseUpload(@RequestParam(value = "filedoc", required = false)MultipartFile file, HttpServletRequest request, HttpServletResponse response) 
			throws IllegalStateException, IOException{
		String name = RandomStringUtils.randomAlphanumeric(10);
        String newFileName = name + ".xlsx";
        File newFile = new File(request.getServletContext().getRealPath("/xlsx"), newFileName);
        newFile.getParentFile().mkdirs();
        file.transferTo(newFile);
        courseService.imports(newFile);
		return "Upload success!";
	}
	
	
	@RequestMapping("/courseSearch")
	@ResponseBody
	public Map<String,Object> courseSearch(int page,int rows) throws Exception {
		// 数据表格默认的参数是page和rows，通过请求来获得参数。
		PageBean<Course> pageBean = new PageBean<>(page, rows);
		pageBean = courseService.queryByCoursePage(pageBean,majors,books);	
		Map<String,Object> map = new HashMap<>();
		map.put("rows", pageBean.getResult());
		map.put("total", pageBean.getTotal());
		return map;
	}
	
	@RequestMapping("/getBookList")
	@ResponseBody
	public List<Book> getBookList() throws Exception {
		return books;
	}
	
	@RequestMapping("/getMajorList")
	@ResponseBody
	public List<Major> getMajorList() throws Exception {
		return majors;
	}
	
	@RequestMapping(value="/saveCourseData")
	@ResponseBody
	public String saveCourseData(@RequestParam String coursesjson) throws Exception {
		System.out.println(coursesjson);
		List<Course> courses = mapper.readValue(coursesjson, new TypeReference<List<Course>>() {});
		courseService.saveEditCourse(courses);
		return "success!";
	}
	
	@RequestMapping(value="/insertCourse")
	@ResponseBody
	public String insertCourse(Course course,@RequestParam String tem_type) throws Exception {
		course.setType(CourseTypeEnum.get(tem_type));
		course.setStatus(0);
		courseService.insert(course);
		return "success!";
	}
	
	@RequestMapping(value="/download")  
    public ResponseEntity<byte[]> download() throws IOException {
    	List<Course> courses = courseService.listAll();
    	String path="course.xls";
    	courseService.createExcel(courses,path);
    	
        File file=new File(path);
        HttpHeaders headers = new HttpHeaders();  
        String fileName=new String("course.xls".getBytes("UTF-8"),"iso-8859-1");
        headers.setContentDispositionFormData("attachment", fileName); 
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM); 
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),headers, HttpStatus.CREATED);  
    }
}
