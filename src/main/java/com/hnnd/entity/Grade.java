package com.hnnd.entity;

import com.hnnd.base.BaseEntity;

public class Grade extends BaseEntity{
    //private Integer id;

    private Integer user_id;
    
    private String name;
    private Integer course_id;
    
    private String course_name;

    private Double grade;

    private Double usual_grade;

    private Double final_grade;

    private String remark;


//    private Course tempCourse;
//    
//    public Course getTempCourse(){
//    	return tempCourse;
//    }

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

    public Double getGrade() {
        return grade;
    }

    public void setGrade(Double grade) {
        this.grade = grade;
    }

    public Double getUsual_grade() {
        return usual_grade;
    }

    public void setUsual_grade(Double usual_grade) {
        this.usual_grade = usual_grade;
    }

    public Double getFinal_grade() {
        return final_grade;
    }

    public void setFinal_grade(Double final_grade) {
        this.final_grade = final_grade;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

	public String getCourse_name() {
		return course_name;
	}

	public void setCourse_name(String course_name) {
		this.course_name = course_name;
	}


	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}