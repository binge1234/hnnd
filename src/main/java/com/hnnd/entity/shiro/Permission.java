package com.hnnd.entity.shiro;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.hnnd.base.BaseEntity;

public class Permission extends BaseEntity{


    private String name;

    private String remark;

    private String url;

    private Date startDate;

    private Date updateDate;


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }
    @DateTimeFormat(pattern = "yyyy-MM-dd")  
    @JsonFormat(pattern = "yyyy-MM-dd",timezone="GMT+8") 
    public Date getStartdate() {
        return startDate;
    }

    public void setStartdate(Date startDate) {
        this.startDate = startDate;
    }
    @DateTimeFormat(pattern = "yyyy-MM-dd")  
    @JsonFormat(pattern = "yyyy-MM-dd",timezone="GMT+8") 
    public Date getUpdatedate() {
        return updateDate;
    }

    public void setUpdatedate(Date updateDate) {
        this.updateDate = updateDate;
    }
}