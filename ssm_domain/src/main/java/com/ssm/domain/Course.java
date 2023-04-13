package com.ssm.domain;

import java.util.List;

//对应数据库中的course表
public class Course {
    int id;
    String course_name;
    String course_time;//1-13
    String course_location;//35-3jt
    String course_teacher_name;
    String course_section;//Mon1
    //多对多关系 1：n
    List<Grade> gradeList;

    public Course(String courseName, String weekSection, String location, String teacherName, String courseSection) {
        course_name = courseName;
        course_time = weekSection;
        course_location = location;
        course_teacher_name = teacherName;
        course_section = courseSection;
    }

    public Course() {

    }

    @Override
    public String toString() {
        return "Course{" +
                "id=" + id +
                ", course_name='" + course_name + '\'' +
                ", course_time='" + course_time + '\'' +
                ", course_location='" + course_location + '\'' +
                ", course_teacher_name='" + course_teacher_name + '\'' +
                ", course_section='" + course_section + '\'' +
                ", gradeList=" + gradeList +
                '}';
    }

    public List<Grade> getGradeList() {
        return gradeList;
    }

    public void setGradeList(List<Grade> gradeList) {
        this.gradeList = gradeList;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCourse_name() {
        return course_name;
    }

    public void setCourse_name(String course_name) {
        this.course_name = course_name;
    }

    public String getCourse_time() {
        return course_time;
    }

    public void setCourse_time(String course_time) {
        this.course_time = course_time;
    }

    public String getCourse_location() {
        return course_location;
    }

    public void setCourse_location(String course_location) {
        this.course_location = course_location;
    }

    public String getCourse_teacher_name() {
        return course_teacher_name;
    }

    public void setCourse_teacher_name(String course_teacher_name) {
        this.course_teacher_name = course_teacher_name;
    }

    public String getCourse_section() {
        return course_section;
    }

    public void setCourse_section(String course_section) {
        this.course_section = course_section;
    }

}
