package com.hnnd.entity;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.hnnd.base.BaseEntity;
import com.hnnd.enums.CourseTypeEnum;

public class Course extends BaseEntity{
    private Integer id;

    private Integer book_id;
    
    private String book_name;

    private Integer major_id;
    
    private String major_name;

	private Double normal_credits;

    private Double free_credits;

    private Double free_grade;

    private Integer status;

    private CourseTypeEnum type;

    private Double cost;

    private Double grade_proportion;

    private Date start_time;

    private Date end_time;

    private Date exam_time;

    private String course_name;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getBook_id() {
        return book_id;
    }

    public void setBook_id(Integer book_id) {
        this.book_id = book_id;
    }

    public Integer getMajor_id() {
        return major_id;
    }

    public void setMajor_id(Integer major_id) {
        this.major_id = major_id;
    }

    public Double getNormal_credits() {
        return normal_credits;
    }

    public void setNormal_credits(Double normal_credits) {
        this.normal_credits = normal_credits;
    }

    public Double getFree_credits() {
        return free_credits;
    }

    public void setFree_credits(Double free_credits) {
        this.free_credits = free_credits;
    }

    public Double getFree_grade() {
        return free_grade;
    }

    public void setFree_grade(Double free_grade) {
        this.free_grade = free_grade;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public CourseTypeEnum getType() {
        return type;
    }

    public void setType(CourseTypeEnum type) {
        this.type = type;
    }

    public Double getCost() {
        return cost;
    }

    public void setCost(Double cost) {
        this.cost = cost;
    }

    public Double getGrade_proportion() {
        return grade_proportion;
    }

    public void setGrade_proportion(Double grade_proportion) {
        this.grade_proportion = grade_proportion;
    }

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm",timezone="GMT+8")
    public Date getStart_time() {
        return start_time;
    }

    public void setStart_time(Date start_time) {
        this.start_time = start_time;
    }

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm",timezone="GMT+8")
    public Date getEnd_time() {
        return end_time;
    }

    public void setEnd_time(Date end_time) {
        this.end_time = end_time;
    }

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm",timezone="GMT+8")
    public Date getExam_time() {
        return exam_time;
    }

    public void setExam_time(Date exam_time) {
        this.exam_time = exam_time;
    }

    public String getCourse_name() {
        return course_name;
    }

    public void setCourse_name(String course_name) {
        this.course_name = course_name == null ? null : course_name.trim();
    }
    
    public String getMajor_name() {
		return major_name;
	}
	public void setMajor_name(String major_name) {
		this.major_name = major_name;
	}

	public String getBook_name() {
		return book_name;
	}

	public void setBook_name(String book_name) {
		this.book_name = book_name;
	}
	
	
}