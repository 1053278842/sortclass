package com.ssm.domain;

import java.io.Serializable;

public class CourseGradeRelationship implements Serializable {
    private int id;
    private int grades_id;
    private int course_id;

    public CourseGradeRelationship() {
    }

    @Override
    public String toString() {
        return "CourseGradeRelationship{" +
                "id=" + id +
                ", grades_id=" + grades_id +
                ", course_id=" + course_id +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getGrades_id() {
        return grades_id;
    }

    public void setGrades_id(int grades_id) {
        this.grades_id = grades_id;
    }

    public int getCourse_id() {
        return course_id;
    }

    public void setCourse_id(int course_id) {
        this.course_id = course_id;
    }
}
