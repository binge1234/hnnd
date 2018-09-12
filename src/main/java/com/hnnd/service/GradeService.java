package com.hnnd.service;

import java.io.*;
import java.util.List;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hnnd.base.BaseService;
import com.hnnd.dao.CourseMapper;
import com.hnnd.dao.GradeMapper;
import com.hnnd.entity.Grade;
import com.hnnd.entity.Major;
import com.hnnd.enums.FlagEnum;
import com.hnnd.enums.StatusEnum;
import com.hnnd.util.*;

@Service
public class GradeService extends BaseService<Grade> {
	@Autowired
	GradeMapper gradeDAO;
	
	//CourseMapper courseDAO;
	public void imports(File file) {//����ɼ�
		// TODO Auto-generated method stub
		System.out.println("begin");
		InputStream inputStream = null;
        Workbook workbook = null;
        try {
            inputStream = new FileInputStream(file);
            workbook = WorkbookFactory.create(inputStream);
            inputStream.close();
            //���������
            Sheet sheet = workbook.getSheetAt(0);
            //������
            int rowLength = sheet.getLastRowNum()+1;
            //���������
            Row row = sheet.getRow(0);
            //������
            int colLength = row.getLastCellNum();
            //�õ�ָ���ĵ�Ԫ��
            Cell cell = row.getCell(0);
            //�õ���Ԫ����ʽ
            //System.out.println("������" + rowLength + ",������" + colLength);
            for (int i = 1; i < rowLength; i++) {
                row = sheet.getRow(i);
                Grade m=new Grade();
                cell = row.getCell(0);
                cell.setCellType(Cell.CELL_TYPE_STRING); 
                m.setId(Integer.parseInt(cell.getStringCellValue()));
                
                cell = row.getCell(1);
                cell.setCellType(Cell.CELL_TYPE_STRING);  
                m.setUser_id(Integer.parseInt(cell.getStringCellValue()));
                
                cell = row.getCell(2);
                cell.setCellType(Cell.CELL_TYPE_STRING); 
                m.setCourse_id(Integer.parseInt(cell.getStringCellValue()));

                cell = row.getCell(3);
                cell.setCellType(Cell.CELL_TYPE_STRING);
                m.setGrade(Double.parseDouble(cell.getStringCellValue()));
                
                cell = row.getCell(4);
                cell.setCellType(Cell.CELL_TYPE_STRING);
                m.setUsual_grade(Double.parseDouble(cell.getStringCellValue()));
                
                cell = row.getCell(5);
                cell.setCellType(Cell.CELL_TYPE_STRING);
                m.setFinal_grade(Double.parseDouble(cell.getStringCellValue()));
                
                cell = row.getCell(6);
                cell.setCellType(Cell.CELL_TYPE_STRING);
                m.setRemark(cell.getStringCellValue());
                System.out.println(m.toString());
                insert(m);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("end");
	}
	
	public void UsualViolate(Grade grade) {
		//major= majorDAO.selectByPrimaryKey(major.getId());
		grade.setRemark("һ��Υ��");
		System.out.println(grade.getId()+" "+grade.getName()+" "+grade.getCourse_name()
		+" "+grade.getGrade()+" "+grade.getUsual_grade()+" "+grade.getFinal_grade()+" "+grade.getRemark());
		gradeDAO.updateByViolate(grade);
	}
	
	public void SeriousViolate(Grade grade) {
		//major= majorDAO.selectByPrimaryKey(major.getId());
		grade.setRemark("����Υ��");
		System.out.println(grade.getId()+" "+grade.getName()+" "+grade.getCourse_name()
		+" "+grade.getGrade()+" "+grade.getUsual_grade()+" "+grade.getFinal_grade()+" "+grade.getRemark());
		gradeDAO.updateByViolate(grade);
	}
	
	public void GradeError(Grade grade) {
		//major= majorDAO.selectByPrimaryKey(major.getId());
		System.out.println(grade.getCourse_id());
		grade.setUser_id(3);
		grade.setRemark("������ӳ�ɼ�����");
		gradeDAO.updateErrorMessage(grade);
	}
	
	public List<Grade> SearchByStudent(){
		return (List<Grade>) gradeDAO.selectByStudent(3);
	}
	
	public List<Grade> SearchErrorByPage(){
		return (List<Grade>) gradeDAO.selectErrorByPage("������ӳ�ɼ�����");
	}
}