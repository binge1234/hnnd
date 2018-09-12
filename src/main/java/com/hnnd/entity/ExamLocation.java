package com.hnnd.entity;

import com.hnnd.base.BaseEntity;

public class ExamLocation extends BaseEntity {
	// private Integer id;

	private String location;

	private Integer location_status;

	private Integer citycode;

	private Integer districtcode;

	private Integer majorid;

	private Integer capacity;
	
	private String code;
	
	private int totalcapacity;
	
	
	/*
	 * name 字段不是数据表里的属性
	 * 它存储专业名称
	 */
	private String name;
	/*
	 * count字段不是数据表里的属性
	 * 它存储该考点的考场个数
	 */
	private int count;

	/*
	 * ******************************************************
	 */
	
	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getTotalcapacity() {
		return totalcapacity;
	}

	public void setTotalcapacity(int totalcapacity) {
		this.totalcapacity = totalcapacity;
	}

	public Integer getCapacity() {
		return capacity;
	}

	public void setCapacity(Integer capacity) {
		this.capacity = capacity;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getMajorid() {
		return majorid;
	}

	public void setMajorid(Integer majorid) {
		this.majorid = majorid;
	}

	public Integer getCitycode() {
		return citycode;
	}

	public void setCitycode(Integer citycode) {
		this.citycode = citycode;
	}

	public Integer getDistrictcode() {
		return districtcode;
	}

	public void setDistrictcode(Integer districtcode) {
		this.districtcode = districtcode;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location == null ? null : location.trim();
	}

	public Integer getLocation_status() {
		return location_status;
	}

	public void setLocation_status(Integer location_status) {
		this.location_status = location_status;
	}
}