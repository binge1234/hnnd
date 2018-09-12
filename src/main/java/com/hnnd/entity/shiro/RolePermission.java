package com.hnnd.entity.shiro;

import com.hnnd.base.BaseEntity;

public class RolePermission extends BaseEntity{

    private Integer rid;

    private Integer pid;


    public Integer getRid() {
        return rid;
    }

    public void setRid(Integer rid) {
        this.rid = rid;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }
}