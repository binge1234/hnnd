package com.hnnd.enums;

import com.fasterxml.jackson.annotation.JsonValue;

public enum FlagEnum {
	YES(0,"ÊÇ"),
	NO(1,"·ñ");
	
	private String value;
	  private int index;
	 
	  private FlagEnum( int index,String value) {
	    this.value = value;
	    this.index = index;
	  }
	  
	  public static FlagEnum get(String value){
	    for (FlagEnum p : FlagEnum.values()) {
	      if (p.getValue().equals(value)) {
	        return p;
	      }
	    }
	    return null;
	  }
	  
	  public static FlagEnum get(int index){
	    for (FlagEnum p : FlagEnum.values()) {
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
