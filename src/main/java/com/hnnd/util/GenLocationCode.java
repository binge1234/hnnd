package com.hnnd.util;

public class GenLocationCode {
	public static String generate(Integer citycode, Integer districtcode, Integer id) {
		String code=new String();
		if(citycode<10)code="0";
		code+=citycode.toString();
		
		if(districtcode<10)code+="0";
		code+=districtcode.toString();
		
		Integer shortId=id%1000;
		if(shortId<10)code+="0";
		if(shortId<100)code+="0";
		//if(shortId==0)code+="0";
		code+=shortId.toString();
		
		return code;
	}
}
