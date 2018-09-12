package com.hnnd.entity;

public class Violation {
    private Integer id;

    private Integer user_id;

    private Integer course_id;

    private Integer violation_type;
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUser_id() {
        return user_id;
    }

    public void setUser_id(Integer user_id) {
        this.user_id = user_id;
    }

    public Integer getCourse_id() {
        return course_id;
    }

    public void setCourse_id(Integer course_id) {
        this.course_id = course_id;
    }

    public Integer getViolation_type() {
        return violation_type;
    }

    public void setViolation_type(Integer violation_type) {
        this.violation_type = violation_type;
    }
}