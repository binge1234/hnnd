package com.hnnd.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hnnd.base.BaseService;
import com.hnnd.dao.ExamClassroomMapper;
import com.hnnd.entity.ExamClassroom;
import com.hnnd.entity.Major;
import com.hnnd.enums.FlagEnum;
import com.hnnd.enums.StatusEnum;
import com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException;

@Service
public class ExamClassroomService extends BaseService<ExamClassroom>{
	@Autowired
	ExamClassroomMapper examClassroomDao;
	
	public long imports(File file, Integer examLocationId) {
		//System.out.println("==================================begin service");
		InputStream inputStream = null;
        Workbook workbook = null;
        try {
            inputStream = new FileInputStream(file);
            workbook = WorkbookFactory.create(inputStream);
            inputStream.close();
            
            Sheet sheet = workbook.getSheetAt(0);

            Row row = sheet.getRow(0);
            Cell cell = row.getCell(0);
            
            int rowLength = sheet.getLastRowNum()+1;
            int colLength = row.getLastCellNum();            
           
            //System.out.println("+++++++++++++++++++++行数：" + rowLength + ",列数：" + colLength);
            for (int i = 1; i < rowLength; i++) {
                row = sheet.getRow(i);
                ExamClassroom classroom=new ExamClassroom();
                classroom.setExam_location_id(examLocationId);
                
                cell = row.getCell(0);
                cell.setCellType(Cell.CELL_TYPE_STRING); 
                classroom.setTeaching_building(cell.getStringCellValue());
                
                cell = row.getCell(1);
                cell.setCellType(Cell.CELL_TYPE_STRING);
                classroom.setClassroom(cell.getStringCellValue());

                //System.out.println(classroom.toString());
                insert(classroom);
            }
            return rowLength-1;
        } catch (Exception e) {
            e.printStackTrace();
            if(e instanceof InvalidFormatException)
            	return -2;
            if(e instanceof MySQLIntegrityConstraintViolationException)
            	return -3;//duplicate
            if(e instanceof NullPointerException)
            	return -4;
            return -5;
        }
        //System.out.println("end service");
	}

	public int getClassroomCount(int locationId) {
		return examClassroomDao.selectClassroomCount(locationId);
	}
}