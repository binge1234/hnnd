package com.hnnd.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.List;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hnnd.base.BaseService;
import com.hnnd.dao.ApplyExamInfoMapper;
import com.hnnd.entity.ApplyExamInfo;
import com.hnnd.entity.Major;
import com.hnnd.enums.FlagEnum;
import com.hnnd.enums.StatusEnum;

@Service
public class ApplyExamInfoService extends BaseService<ApplyExamInfo>{
	@Autowired
	private ApplyExamInfoMapper applyExamInfoDao;
	public void imports(File file){
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
                ApplyExamInfo apply=new ApplyExamInfo();
                cell = row.getCell(0);
                cell.setCellType(Cell.CELL_TYPE_STRING);
                //apply.setId(Integer.parseInt(cell.getStringCellValue()));
                
                cell = row.getCell(1);
                cell.setCellType(Cell.CELL_TYPE_STRING); 
                apply.setUser_id(Integer.parseInt(cell.getStringCellValue()));
                
                cell = row.getCell(2);
                cell.setCellType(Cell.CELL_TYPE_STRING);
                apply.setCourse_id(Integer.parseInt(cell.getStringCellValue()));
                
                cell = row.getCell(3);
                cell.setCellType(Cell.CELL_TYPE_STRING);
                apply.setExam_classroom_id(Integer.parseInt(cell.getStringCellValue()));
                
                cell = row.getCell(4);
                cell.setCellType(Cell.CELL_TYPE_STRING);
                apply.setSeat_number(Integer.parseInt(cell.getStringCellValue()));
                
                apply.setExam_number("0000000000");
                apply.setStatus(0);
                apply.setResult(0);
                
                ApplyExamInfo flag=applyExamInfoDao.selectByUidCid(apply.getUser_id(),apply.getCourse_id());
        		if(flag==null){
        			applyExamInfoDao.insert(apply);
        		}
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
	}
	public void check(ApplyExamInfo applyExamInfo) {
		//major= majorDAO.selectByPrimaryKey(major.getId());
		applyExamInfo.setResult(1);
		applyExamInfoDao.updateByPrimaryKey(applyExamInfo);
	}
	public ApplyExamInfo selectByPrimaryKey(int key) {
		//major= majorDAO.selectByPrimaryKey(major.getId());
		return applyExamInfoDao.selectByPrimaryKey(key);
	}
	public void setExamNumber(){
		List<ApplyExamInfo> applyExamInfoList=applyExamInfoDao.selectAll();
		int uidlen=4;//userid长度
		int cidlen=3;//courseid长度
		int eidlen=3;//examclassroomid长度
		int snumlen=3;//seatnumber长度
		for(ApplyExamInfo apply:applyExamInfoList){
			StringBuffer ustring=new StringBuffer();
			ustring.append(apply.getUser_id());
			while(ustring.length()<uidlen){
				ustring.insert(0, "0");
			}
			StringBuffer cstring=new StringBuffer();
			cstring.append(apply.getCourse_id());
			while(cstring.length()<cidlen){
				cstring.insert(0, "0");
			}
			StringBuffer estring=new StringBuffer();
			estring.append(apply.getExam_classroom_id());
			while(estring.length()<eidlen){
				estring.insert(0, "0");
			}
			StringBuffer sstring=new StringBuffer();
			sstring.append(apply.getSeat_number());
			while(sstring.length()<snumlen){
				sstring.insert(0, "0");
			}
			
			StringBuffer examString=new StringBuffer();
			examString.append(ustring).append(cstring).append(estring).append(sstring);
			String exam_number=new String(examString);
			apply.setExam_number(exam_number);
			applyExamInfoDao.updateByPrimaryKey(apply);
		}
	}
	public void insertApply(ApplyExamInfo applyExamInfo){
		applyExamInfoDao.insert(applyExamInfo);
	}
	public ApplyExamInfo selectByUidCid(int user_id,int course_id){
		return applyExamInfoDao.selectByUidCid(user_id,course_id);
	}
}




