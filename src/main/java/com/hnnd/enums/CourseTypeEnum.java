package com.hnnd.enums;

import org.springframework.context.annotation.Primary;

import com.fasterxml.jackson.annotation.JsonValue;

public enum CourseTypeEnum {
   Common(1,"�����γ�"),
   Primary(2,"���Ŀγ�"),
   Base(3,"�����γ�"),
   Practice(4,"ʵ���γ�");
	private String value;
	private int index;
	 
	  private CourseTypeEnum(int index,String value) {
	    this.value = value;
	    this.index = index;
	  }
	  
	  public static CourseTypeEnum get(String value){
	    for (CourseTypeEnum p : CourseTypeEnum.values()) {
	      if (p.getValue().equals(value)) {
	        return p;
	      }
	    }
	    return null;
	  }
	  
	  public static CourseTypeEnum get(int index){
	    for (CourseTypeEnum p : CourseTypeEnum.values()) {
	      if (p.getIndex() == index) {
	        return p;
	      }
	    }
	    return null;
	  }
	  @JsonValue
	  public String getValue() {
	    return value;
	  }
	 
	  public void setValue(String value) {
	    this.value = value;
	  }
	 
	  public int getIndex() {
	    return index;
	  }
	 
	  public void setIndex(int index) {
	    this.index = index;
	  }

}
