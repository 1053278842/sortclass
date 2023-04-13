package com.ssm.utils;

import java.io.IOException;
import java.io.InputStream;
import java.text.MessageFormat;
import java.util.Properties;

/**
 * 课程节次类
 */
public class CourseSectionUtils {

    public static String getClassName(String content) throws IOException {

        InputStream is = CourseSectionUtils.class.getClassLoader().getResourceAsStream("regular_expression.properties");
        Properties regularProperties = new Properties();
        regularProperties.load(is);

        String reg1 = "\\d{4}-\\d{4}\\S{5}";
        reg1 = regularProperties.getProperty("ClassCourseTable.classNameBefor");
        String reg2 = "\\S{2}：\\S+\\）?";
        reg2 = regularProperties.getProperty("ClassCourseTable.classNameAfter");

        content = content.replaceAll(reg1, "");
        content = content.replaceAll(reg2, "");
        content = content.trim();
        return content;
    }

    /**
     * 根据传入的行列（1,1）坐标系生成课程节次
     * 返回节次字符串
     * 类型为Mon1,Mon7,Fri5
     */
    public static String getCourseSectionByXY(int cell, int row) {
        /***getCell(列X,行Y) 坐标系(0,0)
         * +1对标（1，1)坐标系 一下使用（1,1）坐标系
         * (1,1)坐标为标题行
         * (3,3) Mon1   (4,3) Mon3   (5,3) Mon5  (6,3) Mon7
         * (3,4) Thu1                            (6,4) Thu7
         *
         String temp_Content=sheet.getCell(j,i).getContents();
         System.out.println(MessageFormat.format("行:{0}，列：{1}",i+1,j+1) +sheet.getCell(j,i).getContents());
         **/
        String courseSection = "";
        switch (cell) {
            case 3:
                courseSection = "Mon";
                break;
            case 4:
                courseSection = "Tue";
                break;
            case 5:
                courseSection = "Web";
                break;
            case 6:
                courseSection = "Thu";
                break;
            case 7:
                courseSection = "Fri";
                break;
        }
        switch (row) {
            case 3:
                courseSection += "1";
                break;
            case 4:
                courseSection += "3";
                break;
            case 5:
                courseSection += "5";
                break;
            case 6:
                courseSection += "7";
                break;
        }
        return courseSection;
    }
}
