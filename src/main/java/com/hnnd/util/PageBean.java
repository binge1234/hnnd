package com.hnnd.util;

import java.util.List;
public class PageBean<T> {
    private int currPage;  //当前页数
    private int pageSize;  //每一页的大小
    private int total;     //总数
    private int start;     //每一页的开始下标
    private int end;       //每一页的结束下标
    private List<T> result;//结果集
    
    
//    private static final int defaultPage=1;//默认为首页
//    private static final int defaultSize=5;//默认每页数量为5
    
    
    public PageBean(int currPage,int pageSize){
    	this.currPage = currPage;
    	this.pageSize = pageSize;
    	start = (currPage-1)*pageSize;
    	
    	
    }
//    public PageBean() {
//    	this.currPage = defaultPage;
//    	this.pageSize = defaultSize;
//    	start = (currPage-1)*pageSize;
//    	
//    }
    
	public int getCurrPage() {
		return currPage;
	}
	public void setCurrPage(int currPage) {
		this.currPage = currPage;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getEnd() {
		return end;
	}
	public void setEnd(int end) {
		this.end = end;
	}
	public List<T> getResult() {
		return result;
	}
	public void setResult(List<T> result) {
		this.result = result;
	}
	
	
	 @Override
	 public String toString() {
	        return "PageBean{" +
	                "currPage=" + currPage +
	                ", pageSize=" + pageSize +
	                ", total=" + total +
	                ", start=" + start +
	                ", end=" + end +
	                ", result=" + result +
	                '}';
	    }
	
	
    
    
    
    
}
