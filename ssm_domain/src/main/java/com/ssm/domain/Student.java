package com.ssm.domain;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

public class Student implements Serializable {
    //mysql table filed
    private int id;
    private String name;
    private String classes;
    private String sno;
    private String freeClasses;
    private int times;
    private Timestamp date;
    //custom
    private int hasSelectedTimes;//被选择次数
    private boolean canSelected = true;
    //	private float impoRatio;//
    //方便遍历freeClasses;
    private String freeClassSplitFlag = ",";
    ////////////////////////

    public void addTimes() {
        times++;
    }

    public int getHasSelectedTimes() {
        return hasSelectedTimes;
    }

    public void setHasSelectedTimes(int hasSelectedTimes) {
        this.hasSelectedTimes = hasSelectedTimes;
    }

    public String[] getFreeClassFormatArray() {
        String[] tempStr = freeClasses.split(freeClassSplitFlag);
        return tempStr;
    }


    public boolean isCanSelected() {
        return canSelected;
    }

    public void setCanSelected(boolean canSelected) {
        this.canSelected = canSelected;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }

    public int getId() {
        return id;
    }

    public int getTimes() {
        return times;
    }

    public void setTimes(int times) {
        this.times = times;
    }

    public String getFreeClasses() {
        return freeClasses;
    }

    public void setFreeClasses(String freeClasses) {
        this.freeClasses = freeClasses;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getClasses() {
        return classes;
    }

    public void setClasses(String classes) {
        this.classes = classes;
    }

    public String getSno() {
        return sno;
    }

    public void setSno(String sno) {
        this.sno = sno;
    }

    @Override
    public String toString() {
        return "Student{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", classes='" + classes + '\'' +
                ", sno='" + sno + '\'' +
                ", freeClasses='" + freeClasses + '\'' +
                ", times=" + times +
                ", date=" + date +
                ", selectedTimes=" + hasSelectedTimes +
                ", canSelected=" + canSelected +
                '}';
    }

    public void addHasSelectedTimes() {
        hasSelectedTimes++;
    }
}
