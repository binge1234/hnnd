package com.hnnd.entity.shiro;

import com.hnnd.base.BaseEntity;

public class UserRole extends BaseEntity{

    private Integer uid;

    private Integer rid;


    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public Integer getRid() {
        return rid;
    }

    public void setRid(Integer rid) {
        this.rid = rid;
    }
}