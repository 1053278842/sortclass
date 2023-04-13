package com.ssm.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

public class ClassSection implements Serializable {
    private String classSectionName;//课次名 例如Mon1
    private List<SingleClass> singleClasses; //WARNING 本课次所包含的课程信息（班级、课、志愿学生）,无实际用处，只用来渲染前端
    private Queue<SingleClass> singleClassesQueue;//本课次所包含的课程信息（班级、课、志愿学生）

    //功能性
    private Queue<Student> selectedStudentQueue;//已经选择本课次作为志愿时间的学生
    private float weight;//权重:课程数量/志愿人数(越大优先级越高)
    private int dynamicNumberOneFrequency;//保存动态出勤人数——在分配时计算出来

    /**
     * 根据传入的课程数量动态分配该节次合适的出勤次数
     * 不会出现例如：课程10节，单人出勤9课程时，会导致第二个人只用出勤一次的不合理/极端情况
     * 6/5=1.2 向上取整 2 6/3=2完美 小数0.0
     * 23/7=3.28 23/4=5.7 23/6=4
     * 首先将课程数量/限定的最大出勤数,对结果向上取整
     * 再将课程数量/结果，对二次结果向上取整得出合理的出勤人数
     *
     * @param courseNumber 传入的对应节次课程数量
     */
    public void setDynaicNumberByCourseNumber(int courseNumber, int numberOneFrequency) {
        double tempResult = Math.ceil((double) courseNumber / numberOneFrequency);
        dynamicNumberOneFrequency = (int) Math.ceil(courseNumber / tempResult);
    }

    public ClassSection(String classSectionName) {
        this.classSectionName = classSectionName;
        singleClasses = new ArrayList<SingleClass>();
        singleClassesQueue = new LinkedList<>();
        selectedStudentQueue = new LinkedList<>();
        weight = 0;
    }

    public Queue<Student> getSelectedStudentQueue() {
        return selectedStudentQueue;
    }

    public Queue<SingleClass> getSingleClassesQueue() {
        return singleClassesQueue;
    }

    public void setSingleClassesQueue(Queue<SingleClass> singleClassesQueue) {
        this.singleClassesQueue = singleClassesQueue;
    }

    public void setSelectedStudentQueue(Queue<Student> selectedStudentQueue) {
        this.selectedStudentQueue = selectedStudentQueue;
    }

    public float getWeight() {
        return weight;
    }

    public void setWeight(float weight) {
        this.weight = weight;
    }

    public String getClassSectionName() {
        return classSectionName;
    }

    public void setClassSectionName(String classSectionName) {
        this.classSectionName = classSectionName;
    }

    public List<SingleClass> getSingleClasses() {
        return singleClasses;
    }

    public void setSingleClasses(List<SingleClass> singleClasses) {
        this.singleClasses = singleClasses;
    }

    public int getDynamicNumberOneFrequency() {
        return dynamicNumberOneFrequency;
    }

    public void setDynamicNumberOneFrequency(int dynamicNumberOneFrequency) {
        this.dynamicNumberOneFrequency = dynamicNumberOneFrequency;
    }

    @Override
    public String toString() {
        return "ClassSection{" +
                "classSectionName='" + classSectionName + '\'' +
                ", singleClasses=" + singleClasses +
                ", singleClassesQueue=" + singleClassesQueue +
                ", selectedStudentQueue=" + selectedStudentQueue +
                ", weight=" + weight +
                '}';
    }
}
