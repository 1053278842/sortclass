package com.ssm.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * 是最终返回生成表的载体
 */
public class WeekTables implements Serializable {
    public int weekIndex;
    public List<ClassSection> allClassSectionList;

    /**
     * 根据传入的SingClass列表，比对节次（course_section）.分配进对应得到SingleClassesList中
     */
    public void addClassSectionBySingleClassList(List<SingleClass> singleClasses) {
        for (SingleClass sc : singleClasses) {
            for (ClassSection cs : allClassSectionList) {
                if (sc.getCourse().getCourse_section().equals(cs.getClassSectionName())) {
                    cs.getSingleClasses().add(sc);
                }
            }
        }
    }

    /**
     * 根据传入的SingClass列表，比对节次（course_section）.分配进对应得到SingleClassesList中
     */
    public void allocationClassSection(List<SingleClass> singleClasses, String[] weekSectionRange) {
        for (SingleClass sc : singleClasses) {
            //用来做周段校验
            String formatWeekSectionBySc = sc.getCourse().getCourse_section().substring(0, sc.getCourse().getCourse_section().length() - 1);
            //格式转换 FIXME 解决Web和Wed命名冲突的问题
            if (formatWeekSectionBySc.equals("Web")) {
                formatWeekSectionBySc = "Wed";
            }
            for (int i = 0; i < weekSectionRange.length; i++) {
                if (formatWeekSectionBySc.equals(weekSectionRange[i])) {

                    for (ClassSection cs : allClassSectionList) {
                        if (cs.getClassSectionName().equals(sc.getCourse().getCourse_section())) {
                            //                    cs.getSingleClasses().add(sc);
                            cs.getSingleClassesQueue().offer(sc);
                        }
                    }
                }
            }
        }
    }

    /**
     * 根据班级数量合理分配出勤人数
     * Tips 注意，该方法要在班级全部分配到ClassSection后再执行
     */
    public void setDynamicManagementNumber(int numberOneFrequency) {
        for (ClassSection cs : allClassSectionList) {
            cs.setDynaicNumberByCourseNumber(cs.getSingleClassesQueue().size(), numberOneFrequency);
        }
    }

    /**
     * 返回allClassSectionList的排序，按照其ClassSection节次的权重weight。weight越高越靠前
     */
    public ClassSection[] getWeekClassSectionByWeightDesc() {
        ClassSection[] tempArray = allClassSectionList.toArray(new ClassSection[allClassSectionList.size()]);
        for (int i = 0; i < tempArray.length - 1; i++) {
            for (int j = 0; j < tempArray.length - 1; j++) {
                if (tempArray[j].getWeight() < tempArray[j + 1].getWeight()) {
                    ClassSection temp = tempArray[j];
                    tempArray[j] = tempArray[j + 1];
                    tempArray[j + 1] = temp;
                }
            }
        }
        return tempArray;
    }

    public WeekTables() {
        weekIndex = -1;
        allClassSectionList = new ArrayList<ClassSection>();

        allClassSectionList.add(new ClassSection("Mon1"));
        allClassSectionList.add(new ClassSection("Mon3"));
        allClassSectionList.add(new ClassSection("Mon5"));
        allClassSectionList.add(new ClassSection("Mon7"));

        allClassSectionList.add(new ClassSection("Tue1"));
        allClassSectionList.add(new ClassSection("Tue3"));
        allClassSectionList.add(new ClassSection("Tue5"));
        allClassSectionList.add(new ClassSection("Tue7"));

        allClassSectionList.add(new ClassSection("Web1"));
        allClassSectionList.add(new ClassSection("Web3"));
        allClassSectionList.add(new ClassSection("Web5"));
        allClassSectionList.add(new ClassSection("Web7"));

        allClassSectionList.add(new ClassSection("Thu1"));
        allClassSectionList.add(new ClassSection("Thu3"));
        allClassSectionList.add(new ClassSection("Thu5"));
        allClassSectionList.add(new ClassSection("Thu7"));

        allClassSectionList.add(new ClassSection("Fri1"));
        allClassSectionList.add(new ClassSection("Fri3"));
        allClassSectionList.add(new ClassSection("Fri5"));
        allClassSectionList.add(new ClassSection("Fri7"));

    }


    @Override
    public String toString() {
        return "WeekTables{" +
                "weekIndex=" + weekIndex +
                ", allClassSectionList=" + allClassSectionList +
                '}';
    }

    public void setWeekIndex(int weekIndex) {
        this.weekIndex = weekIndex;
    }

    public int getWeekIndex() {
        return weekIndex;
    }

    public List<ClassSection> getAllClassSectionList() {
        return allClassSectionList;
    }

    public void setAllClassSectionList(List<ClassSection> allClassSectionList) {
        this.allClassSectionList = allClassSectionList;
    }


    /**
     * 对allClassSectionList的排序，按照其ClassSection节次的权重weight。weight越高越靠前
     */
    public void setWeekClassSectionByWeightDesc() {
        for (int i = 0; i < allClassSectionList.size() - 1; i++) {
            for (int j = 0; j < allClassSectionList.size() - 1; j++) {
                if (allClassSectionList.get(j).getWeight() < allClassSectionList.get(j + 1).getWeight()) {
                    ClassSection temp = allClassSectionList.get(j);
                    allClassSectionList.set(j, allClassSectionList.get(j + 1));
                    allClassSectionList.set(j + 1, temp);
                }
            }
        }
    }

    /**
     * 针对WeekTables的allClassSectionList列表中的ClassSection，计算并赋值权重weight
     */
    public void setWeekClassSectionWeight() {
        for (ClassSection cs : allClassSectionList) {
            if (cs.getSelectedStudentQueue().size() == 0) {
                cs.setWeight(0);
            } else {
                cs.setWeight((float) cs.getSingleClassesQueue().size() / cs.getSelectedStudentQueue().size());
            }
        }
    }
}
