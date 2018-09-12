package com.hnnd.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.hnnd.base.BaseMapper;
import com.hnnd.base.BaseService;
import com.hnnd.dao.CourseMapper;
import com.hnnd.entity.Book;
import com.hnnd.entity.Course;
import com.hnnd.entity.Major;
import com.hnnd.enums.CourseTypeEnum;
import com.hnnd.enums.FlagEnum;
import com.hnnd.enums.StatusEnum;
import com.hnnd.util.PageBean;

@Service
public class CourseService extends BaseService<Course>{
	
	@Autowired
	CourseMapper courseDAO;
	@Autowired
    BaseMapper<Course> mapper;
	
	//mori:2018-08-09 10:04:11
	public void imports(File file) {//导入全国课程
		// TODO Auto-generated method stub
		System.out.println("begin");
		InputStream inputStream = null;
        Workbook workbook = null;
        try {
            inputStream = new FileInputStream(file);
            workbook = WorkbookFactory.create(inputStream);
            inputStream.close();
            //工作表对象
            Sheet sheet = workbook.getSheetAt(0);
            //总行数
            int rowLength = sheet.getLastRowNum()+1;
            //工作表的列
            Row row = sheet.getRow(0);
            //总列数
            int colLength = row.getLastCellNum();
            //得到指定的单元格
            Cell cell = row.getCell(0);
            //得到单元格样式
            System.out.println("行数：" + rowLength + ",列数：" + colLength);
            for (int i = 1; i < rowLength; i++) {
                row = sheet.getRow(i);
                Course course=new Course();
                
                cell = row.getCell(1);
                cell.setCellType(Cell.CELL_TYPE_STRING); 
                course.setBook_id(Integer.parseInt(cell.getStringCellValue()));
                
                cell = row.getCell(2);
                cell.setCellType(Cell.CELL_TYPE_STRING);
                course.setMajor_id(Integer.parseInt(cell.getStringCellValue()));

                cell = row.getCell(3);
                cell.setCellType(Cell.CELL_TYPE_STRING);
                course.setNormal_credits(Double.parseDouble(cell.getStringCellValue()));
                
                cell = row.getCell(4);
                cell.setCellType(Cell.CELL_TYPE_STRING);
                course.setFree_credits(Double.parseDouble(cell.getStringCellValue()));
                
                cell = row.getCell(5);
                cell.setCellType(Cell.CELL_TYPE_STRING);
                course.setFree_grade(Double.parseDouble(cell.getStringCellValue()));
                
                cell = row.getCell(6);
                cell.setCellType(Cell.CELL_TYPE_STRING);
                course.setStatus(Integer.parseInt(cell.getStringCellValue()));
                
                cell = row.getCell(7);
                //CourseTypeEnum
                cell.setCellType(Cell.CELL_TYPE_STRING);
                course.setType(CourseTypeEnum.get(Integer.parseInt(cell.getStringCellValue())));
                
                cell = row.getCell(8);
                cell.setCellType(Cell.CELL_TYPE_STRING);
                course.setCost(Double.parseDouble(cell.getStringCellValue()));
                
                cell = row.getCell(9);
                cell.setCellType(Cell.CELL_TYPE_STRING);
                course.setGrade_proportion(Double.parseDouble(cell.getStringCellValue()));
                
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                cell = row.getCell(10);   		
                switch (cell.getCellType()) {
	                case HSSFCell.CELL_TYPE_NUMERIC: 
	                  	if(HSSFDateUtil.isCellDateFormatted(cell)){        
	                  		String str = sdf.format(HSSFDateUtil.getJavaDate(cell.getNumericCellValue())).toString();          
	                  		System.out.println(str);
	                  		course.setStart_time(sdf.parse(str));
	                  	}
	                  	break;
                }
                
                
                cell = row.getCell(11);
                switch (cell.getCellType()) {
                case HSSFCell.CELL_TYPE_NUMERIC: 
                  	if(HSSFDateUtil.isCellDateFormatted(cell)){        
                  		String str = sdf.format(HSSFDateUtil.getJavaDate(cell.getNumericCellValue())).toString();          
                  		System.out.println(str);
                  		course.setEnd_time(sdf.parse(str));
                  	}
                  	break;
                }
                
                cell = row.getCell(12);
                switch (cell.getCellType()) {
                case HSSFCell.CELL_TYPE_NUMERIC: 
                  	if(HSSFDateUtil.isCellDateFormatted(cell)){        
                  		String str = sdf.format(HSSFDateUtil.getJavaDate(cell.getNumericCellValue())).toString();          
                  		System.out.println(str);
                  		course.setExam_time(sdf.parse(str));
                  	}
                  	break;
                }
                
                cell = row.getCell(13);
                cell.setCellType(Cell.CELL_TYPE_STRING);
                course.setCourse_name(cell.getStringCellValue());
                
                System.out.println(course.getBook_id()+" "+course.getFree_credits()+" "+" "+course.getStart_time());
                insert(course);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("end");
	}
	
	public PageBean<Course> queryByCoursePage(PageBean<Course> pageBean,List<Major> majors,List<Book> books){
    	int total = mapper.getTotal();
    	pageBean.setTotal(total);
		List<Course> result = mapper.selectByPage(pageBean.getStart(), pageBean.getPageSize());
		for(Course course : result) {
			for(Major major : majors) {
				if(course.getMajor_id() == major.getId()) {
					course.setMajor_name(major.getName());
					break;
				}
			}
		}
		for(Course course : result) {
			for(Book book : books) {
				if(course.getBook_id() == book.getId()) {
					course.setBook_name(book.getName());
					break;
				}
			}
		}
		pageBean.setResult(result);
		return pageBean;
    }
	
	public void saveEditCourse(List<Course> courses) {
		for(Course course : courses) {
			courseDAO.updateByPrimaryKey(course);
		}
	}
	
	public void createExcel(List<Course> courses,String path) {
		// 创建一个Excel文件
        HSSFWorkbook workbook = new HSSFWorkbook();
        // 创建一个工作表
        HSSFSheet sheet = workbook.createSheet("课程属性表");
        // 添加表头行
        HSSFRow hssfRow = sheet.createRow(0);
        // 设置单元格格式居中
        HSSFCellStyle cellStyle = workbook.createCellStyle();
        cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
        
        // 添加表头内容
        HSSFCell headCell = hssfRow.createCell(0);
        headCell.setCellValue("id");
        headCell.setCellStyle(cellStyle);

        headCell = hssfRow.createCell(1);
        headCell.setCellValue("book_id");
        headCell.setCellStyle(cellStyle);

        headCell = hssfRow.createCell(2);
        headCell.setCellValue("major_id");
        headCell.setCellStyle(cellStyle);

        headCell = hssfRow.createCell(3);
        headCell.setCellValue("normal_credits");
        headCell.setCellStyle(cellStyle);
        
        headCell = hssfRow.createCell(4);
        headCell.setCellValue("free_credits");
        headCell.setCellStyle(cellStyle);
        
        headCell = hssfRow.createCell(5);
        headCell.setCellValue("free_grade");
        headCell.setCellStyle(cellStyle);
        
        headCell = hssfRow.createCell(6);
        headCell.setCellValue("status");
        headCell.setCellStyle(cellStyle);
        
        headCell = hssfRow.createCell(7);
        headCell.setCellValue("type");
        headCell.setCellStyle(cellStyle);
        
        headCell = hssfRow.createCell(8);
        headCell.setCellValue("cost");
        headCell.setCellStyle(cellStyle);
        
        headCell = hssfRow.createCell(9);
        headCell.setCellValue("grade_proportion");
        headCell.setCellStyle(cellStyle);
        
        headCell = hssfRow.createCell(10);
        headCell.setCellValue("start_time");
        headCell.setCellStyle(cellStyle);
        
        headCell = hssfRow.createCell(11);
        headCell.setCellValue("end_time");
        headCell.setCellStyle(cellStyle);
        
        headCell = hssfRow.createCell(12);
        headCell.setCellValue("exam_time");
        headCell.setCellStyle(cellStyle);
        
        headCell = hssfRow.createCell(13);
        headCell.setCellValue("course_name");
        headCell.setCellStyle(cellStyle);
        // 添加数据内容

        System.out.println(courses.size());
        for (int i = 0; i < courses.size(); i++) {
            hssfRow = sheet.createRow(i+1);
            Course course = courses.get(i);

            // 创建单元格，并设置值
            HSSFCell cell = hssfRow.createCell(0);
            cell.setCellValue(course.getId());
            cell.setCellStyle(cellStyle);

            cell = hssfRow.createCell(1);
            cell.setCellValue(course.getBook_id());
            cell.setCellStyle(cellStyle);

            cell = hssfRow.createCell(2);
            cell.setCellValue(course.getMajor_id());
            cell.setCellStyle(cellStyle);
            
            cell = hssfRow.createCell(3);
            cell.setCellValue(course.getNormal_credits());
            cell.setCellStyle(cellStyle);
            
            cell = hssfRow.createCell(4);
            cell.setCellValue(course.getFree_credits());
            cell.setCellStyle(cellStyle);
            
            cell = hssfRow.createCell(5);
            cell.setCellValue(course.getFree_grade());
            cell.setCellStyle(cellStyle);
            
            cell = hssfRow.createCell(6);
            cell.setCellValue(course.getStatus());
            cell.setCellStyle(cellStyle);
            
            cell = hssfRow.createCell(7);
            cell.setCellValue(course.getType().getValue());
            cell.setCellStyle(cellStyle);
            
            cell = hssfRow.createCell(8);
            cell.setCellValue(course.getCost());
            cell.setCellStyle(cellStyle);
            
            cell = hssfRow.createCell(9);
            cell.setCellValue(course.getGrade_proportion());
            cell.setCellStyle(cellStyle);
            
            cell = hssfRow.createCell(10);
            cell.setCellValue(sdf.format(course.getStart_time()));
            cell.setCellStyle(cellStyle);
            
            cell = hssfRow.createCell(11);
            cell.setCellValue(sdf.format(course.getEnd_time()));
            cell.setCellStyle(cellStyle);
            
            cell = hssfRow.createCell(12);
            System.out.println(sdf.format(course.getExam_time()));
            cell.setCellValue(sdf.format(course.getExam_time()));
            cell.setCellStyle(cellStyle);
            
            cell = hssfRow.createCell(13);
            cell.setCellValue(course.getCourse_name());
            cell.setCellStyle(cellStyle);
        }
        try {
        	File pathFile = new File(path);
        	if(pathFile.exists()) {
        		pathFile.delete();
        	}
            OutputStream outputStream = new FileOutputStream(path);
            workbook.write(outputStream);
            outputStream.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
	}
	public int selectMajorByPrimaryKey(int id) {
		//major= majorDAO.selectByPrimaryKey(major.getId());
		return courseDAO.selectMajorByPrimaryKey(id);
	}
}
