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
import com.hnnd.dao.MajorMapper;
import com.hnnd.entity.Major;
import com.hnnd.enums.FlagEnum;
import com.hnnd.enums.StatusEnum;
import com.hnnd.util.*;

@Service
public class MajorService extends BaseService<Major>{
	@Autowired
	MajorMapper majorDAO;
	
	
	
	public void imports(File file) {//导入全国专业
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
            //System.out.println("行数：" + rowLength + ",列数：" + colLength);
            for (int i = 1; i < rowLength; i++) {
                row = sheet.getRow(i);
                Major m=new Major();
                cell = row.getCell(0);
                cell.setCellType(Cell.CELL_TYPE_STRING); 
                //m.setId(cell.getStringCellValue());
                
                cell = row.getCell(1);
                cell.setCellType(Cell.CELL_TYPE_STRING); 
                m.setName(cell.getStringCellValue());
                
                cell = row.getCell(2);
                cell.setCellType(Cell.CELL_TYPE_STRING);
                m.setDetails(cell.getStringCellValue());

                m.setFlag(FlagEnum.NO);
                
                cell = row.getCell(4);
                cell.setCellType(Cell.CELL_TYPE_STRING);
                m.setArea(cell.getStringCellValue());
                
                m.setStatus(StatusEnum.STOP);
                System.out.println(m.toString());
                insert(m);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("end");
	}


	
	public void start(Major major) {
		//major= majorDAO.selectByPrimaryKey(major.getId());
		major.setStatus(StatusEnum.START);
		majorDAO.updateByStatus(major);
	}

	
	public void delete(Major major) {
		// TODO Auto-generated method stub
		major=majorDAO.selectByPrimaryKey(major.getId());
		major.setFlag(FlagEnum.YES);
		majorDAO.updateByFlag(major);
	}

	public List<Major> selectNoLocationMajor(){
		return majorDAO.selectNoLocationMajor();
	}
	

    
    

    

}
