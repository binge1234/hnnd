package com.hnnd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hnnd.base.BaseService;
import com.hnnd.dao.ExamLocationMapper;
import com.hnnd.entity.ExamLocation;
import com.hnnd.util.GenLocationCode;

@Service
public class ExamLocationService extends BaseService<ExamLocation> {
	@Autowired
	ExamLocationMapper examLocationDao;
	
	public void insert_examLocation(ExamLocation examLocation) {
		examLocationDao.insert(examLocation);
	}
	
	public void start_examLocation(ExamLocation examLocation) {
		examLocation.setLocation_status(1);
		examLocationDao.updateByPrimaryKeySelective(examLocation);
	}
	
	public void stop_examLocation(ExamLocation examLocation) {
		examLocation.setLocation_status(0);
		examLocationDao.updateByPrimaryKeySelective(examLocation);
	}
	
	public void add_LocationMajor(ExamLocation examLocation) {
		examLocationDao.updateByPrimaryKeySelective(examLocation);
	}
	
	public void del_LocationMajor(ExamLocation examLocation) {
		examLocationDao.updateWithMajorNull(examLocation);
	}
	/*public List<ExamLocation> list_examLocation(){
		return examLocationDao.selectAll();
	}*/
	/*public void insert_examLocationMajor(ExamLocation examLocation){
		
	}
	
	public void delete_examLocationMajor(ExamLocation examLocation) {
		
	}*/
	private ExamLocation selectNewestId() {
		return examLocationDao.selectNewestId();
	}
	
	public void gen_examLocationCode() {
		ExamLocation examLocation=selectNewestId();
		examLocation.setCode(GenLocationCode.generate(examLocation.getCitycode(), examLocation.getDistrictcode(), examLocation.getId()));
		examLocationDao.updateWithCode(examLocation);
	}
	
	public void updateTotalCapacity(Integer id) {
		examLocationDao.updateTotalCapacity(id);
	}
	
	public int selectForApply(int majorid,int citycode,int districtcode){
		return examLocationDao.selectForApply(citycode,districtcode,majorid);
	}
}