package com.ssm.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtils {
    /**
     * 日期的格式toString
     *
     * @param date    日期
     * @param pattern 格式
     * @return 格式版的日期
     */
    public static String DateToString(Date date, String pattern) {
        SimpleDateFormat sdf = new SimpleDateFormat(pattern);
        return sdf.format(date);
    }

    /**
     * 根据格式将str转化为Date类型
     *
     * @param str
     * @param pattern
     * @return
     * @throws ParseException
     */
    public static Date StringToDate(String str, String pattern) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat(pattern);
        return sdf.parse(str);
    }
}
