package com.hnnd.entity;

public class Certificate {
    private String certificate_id;

    private String user_id;
    private Integer certificate_type;

    private Integer certificate_level;

    private String certificate_desc;

    public String getCertificate_id() {
        return certificate_id;
    }

    public void setCertificate_id(String certificate_id) {
        this.certificate_id = certificate_id == null ? null : certificate_id.trim();
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id == null ? null : user_id.trim();
    }

    public Integer getCertificate_type() {
        return certificate_type;
    }

    public void setCertificate_type(Integer certificate_type) {
        this.certificate_type = certificate_type;
    }

    public Integer getCertificate_level() {
        return certificate_level;
    }

    public void setCertificate_level(Integer certificate_level) {
        this.certificate_level = certificate_level;
    }

    public String getCertificate_desc() {
        return certificate_desc;
    }

    public void setCertificate_desc(String certificate_desc) {
        this.certificate_desc = certificate_desc == null ? null : certificate_desc.trim();
    }
}