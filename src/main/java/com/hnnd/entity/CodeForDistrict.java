package com.hnnd.entity;

import com.hnnd.base.BaseEntity;

public class CodeForDistrict extends BaseEntity{
	private Integer districtcode;
	private String district_name;
	private Integer citycode;
	public Integer getDistrictcode() {
		return districtcode;
	}
	public void setDistrictcode(Integer districtcode) {
		this.districtcode = districtcode;
	}
	public String getDistrict_name() {
		return district_name;
	}
	public void setDistrict_name(String district_name) {
		this.district_name = district_name;
	}
	public Integer getCitycode() {
		return citycode;
	}
	public void setCitycode(Integer citycode) {
		this.citycode = citycode;
	}
}