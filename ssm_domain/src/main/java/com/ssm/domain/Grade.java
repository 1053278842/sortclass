package com.ssm.domain;

import java.util.List;

//对应数据库中的classes_grades表
public class Grade {
    private int id;//自增主键，无意义
    private String class_name;
    private int size;
    //与Course的多对多关系
    List<Course> courseList;

    public Grade(String className, int classSize) {
        class_name = className;
        size = classSize;
    }

    public Grade() {
    }

    @Override
    public String toString() {
        return "Grade{" +
                "id=" + id +
                ", class_name='" + class_name + '\'' +
                ", size=" + size +
                ", courseList=" + courseList +
                '}';
    }

    public List<Course> getCourseList() {
        return courseList;
    }

    public void setCourseList(List<Course> courseList) {
        this.courseList = courseList;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getClass_name() {
        return class_name;
    }

    public void setClass_name(String class_name) {
        this.class_name = class_name;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }

}
