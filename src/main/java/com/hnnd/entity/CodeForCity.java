package com.hnnd.entity;

import com.hnnd.base.BaseEntity;

public class CodeForCity extends BaseEntity{
	private Integer citycode;
	private String city_name;
	public Integer getCitycode() {
		return citycode;
	}
	public void setCitycode(Integer citycode) {
		this.citycode = citycode;
	}
	public String getCity_name() {
		return city_name;
	}
	public void setCity_name(String city_name) {
		this.city_name = city_name;
	}
}