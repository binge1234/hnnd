package com.hnnd.entity.shiro;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.hnnd.base.BaseEntity;

public class Role extends BaseEntity{


    private String name;

    private String remark;

    private Date startdate;

    private Date updatedate;


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
    @DateTimeFormat(pattern = "yyyy-MM-dd")  
    @JsonFormat(pattern = "yyyy-MM-dd",timezone="GMT+8")  
    public Date getStartdate() {
        return startdate;
    }

    public void setStartdate(Date startdate) {
        this.startdate = startdate;
    }
    @DateTimeFormat(pattern = "yyyy-MM-dd")  
    @JsonFormat(pattern = "yyyy-MM-dd",timezone="GMT+8") 
    public Date getUpdatedate() {
        return updatedate;
    }

    public void setUpdatedate(Date updatedate) {
        this.updatedate = updatedate;
    }
}