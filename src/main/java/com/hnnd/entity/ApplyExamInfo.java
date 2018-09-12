package com.hnnd.entity;

import com.hnnd.base.BaseEntity;

public class ApplyExamInfo extends BaseEntity{
    private Integer id;
    private Integer user_id;

    private Integer course_id;

    private Integer exam_classroom_id;

    private Integer status;

    private Integer result;

    private String exam_number;

    private Integer seat_number;
    
    private Integer location_id;
    
    public Integer getLocation_id() {
		return location_id;
	}

	public void setLocation_id(Integer location_id) {
		this.location_id = location_id;
	}


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

    public Integer getExam_classroom_id() {
        return exam_classroom_id;
    }

    public void setExam_classroom_id(Integer exam_classroom_id) {
        this.exam_classroom_id = exam_classroom_id;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getResult() {
        return result;
    }

    public void setResult(Integer result) {
        this.result = result;
    }

    public String getExam_number() {
        return exam_number;
    }

    public void setExam_number(String exam_number) {
        this.exam_number = exam_number == null ? null : exam_number.trim();
    }

    public Integer getSeat_number() {
        return seat_number;
    }

    public void setSeat_number(Integer seat_number) {
        this.seat_number = seat_number;
    }
    @Override
	public String toString() {
		return "ApplyExamInfo [id=" + id + ", user_id=" + user_id + ", course_id=" + course_id + ", exam_classroom_id="
				+ exam_classroom_id + ", status=" + status + ", result=" + result + ", exam_number=" + exam_number
				+ ", seat_number=" + seat_number + ", location_id=" + location_id + "]";
	}
}