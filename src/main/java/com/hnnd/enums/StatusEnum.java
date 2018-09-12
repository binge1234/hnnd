package com.hnnd.enums;

import com.fasterxml.jackson.annotation.JsonValue;

public enum StatusEnum {
	START(1,"∆Ù”√"),
	STOP(2,"Ω˚”√");
	
	private String value;
	  private int index;
	 
	  private StatusEnum( int index,String value) {
	    this.value = value;
	    this.index = index;
	  }
	  
	  public static StatusEnum get(String value){
	    for (StatusEnum p : StatusEnum.values()) {
	      if (p.getValue().equals(value)) {
	        return p;
	      }
	    }
	    return null;
	  }
	  
	  public static StatusEnum get(int index){
	    for (StatusEnum p : StatusEnum.values()) {
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
