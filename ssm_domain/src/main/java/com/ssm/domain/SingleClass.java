package com.ssm.domain;

/**
 * 存放班级、课程、值班人员（1:1:1)关系的类
 */
public class SingleClass {
    private int id;
    private Grade grade;
    private Course course;
    //dao不生成
    private Student student;


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Grade getGrade() {
        return grade;
    }

    public void setGrade(Grade grade) {
        this.grade = grade;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }

    @Override
    public String toString() {
        return "SingleClass{" +
                "id=" + id +
                ", grade=" + grade +
                ", course=" + course +
                ", student=" + student +
                '}';
    }
}
