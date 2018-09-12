package com.hnnd.entity;

import com.hnnd.base.BaseEntity;

public class ExamClassroom extends BaseEntity{
    private Integer id;

    private Integer exam_location_id;

    private String teaching_building;
    private String classroom;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getExam_location_id() {
        return exam_location_id;
    }

    public void setExam_location_id(Integer exam_location_id) {
        this.exam_location_id = exam_location_id;
    }

    public String getTeaching_building() {
        return teaching_building;
    }

    public void setTeaching_building(String teaching_building) {
        this.teaching_building = teaching_building == null ? null : teaching_building.trim();
    }

    public String getClassroom() {
        return classroom;
    }

    public void setClassroom(String classroom) {
        this.classroom = classroom == null ? null : classroom.trim();
    }
}