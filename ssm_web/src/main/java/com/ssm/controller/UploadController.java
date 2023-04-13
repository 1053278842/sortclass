package com.ssm.controller;

import com.ssm.dao.ICourseDao;
import com.ssm.domain.Course;
import com.ssm.domain.Grade;
import com.ssm.service.ICourseService;
import com.ssm.service.IGradeService;
import com.ssm.utils.CourseSectionUtils;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.text.MessageFormat;
import java.util.LinkedList;
import java.util.Properties;
import java.util.Queue;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Controller
@RequestMapping("/upload")
public class UploadController {

    @Resource(name = "courseService")
    private ICourseService courseService;

    @Resource(name = "gradeService")
    private IGradeService gradeService;

    /**
     * 上传测试
     * MultipartFile类型变量的命名要和表单上传的name一致
     */
    @RequestMapping("/fileUpload.do")
    public ModelAndView fileUpload(int ClassSize, HttpServletRequest request, MultipartFile upload) throws IOException, BiffException {
        InputStream is = UploadController.class.getClassLoader().getResourceAsStream("regular_expression.properties");
        Properties regularProperties = new Properties();
        regularProperties.load(is);

        ////////////////获取人数
        int classSize_temp = ClassSize;
        ////////////////
        System.out.println("出发！");
        //路径
        String path = request.getSession().getServletContext().getRealPath("/uploads/");
        File file = new File(path);
        if (!file.exists()) {
            file.mkdir();
        }
        //唯一值命名
        String fileName = upload.getOriginalFilename();
        String uuid = UUID.randomUUID().toString().replace("-", "");
        fileName = uuid + "_" + fileName;
        upload.transferTo(new File(path, fileName));

        ModelAndView mv = new ModelAndView();
        mv.setViewName("main");
        ///分析
        //获取上传的文件
        Workbook workbook = Workbook.getWorkbook(upload.getInputStream());
        //DAO变量命名
        String className_temp = null;

        //迭代取excel表内的值
        //分析并存放周次“Course_Section"
        String courseSection = "";
        System.out.println("总行数：" + workbook.getSheet(0).getRows());
        int gid = -1;//存放班级的数据库内ID
        Sheet sheet = workbook.getSheet(0);
        //存放正则表达式的规则
        String pattern_str = "(\\S+)/(\\d{1,2}-?\\d{0,2})[\\u4e00-\\u9fa5]/[\\u4e00-\\u9fa5]{1,4}\\s{1,4}(\\d{1,2}-\\d{1,3}J?T?j?t?\\(?\\S{0,9}\\)?)/(\\S{2,8})/\\d{1,3}/\\d\\.?\\d?|"
                + "(\\S+)/(\\(\\d{1,2}-\\d{1,2}[\\u4e00-\\u9fa5]\\)\\d{1,2}-?\\d{0,2})[\\u4e00-\\u9fa5]/[\\u4e00-\\u9fa5]{1,4}\\s{1,4}(\\d{1,2}-\\d{1,3}J?T?j?t?\\(?\\S{0,9}\\)?)/(\\S{2,8})/\\d{1,3}/\\d\\.?\\d?";
        pattern_str = regularProperties.getProperty("ClassCourseTable.course");
        Pattern pattern = Pattern.compile(pattern_str);


        //计数校验用变量
        int count = 0;
        for (int j = 0; j < 9; j++) {
            for (int i = 0; i < sheet.getRows() - 3; i++) {
                try {
                    String temp_Content = sheet.getCell(j, i).getContents();
                    if (temp_Content != null && temp_Content != "") {
                        //正则
                        Matcher matcher = pattern.matcher(temp_Content);
                        //此处还需要判断正则是否通过，只有课程信息才需要计算课程时间CourseSection
                        //这里已经find过一次了，所以使用do while而不是while循环
                        if (i + 1 == 1 && j + 1 == 1) {//标题行
                            className_temp = CourseSectionUtils.getClassName(temp_Content);
                            className_temp = className_temp.replaceAll("课表", "");
                            System.out.println(className_temp);
                            System.out.println("班级人数：" + classSize_temp);
                            //插入班级
                            Grade grade = new Grade(className_temp, classSize_temp);
                            try {
                                gid = gradeService.insertReturnId(grade);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        }
                        if (matcher.find()) {
                            //获得节次
                            int temp_Row, temp_Cell;
                            temp_Row = i + 1;
                            temp_Cell = j + 1;
                            courseSection = CourseSectionUtils.getCourseSectionByXY(temp_Cell, temp_Row);
                            //通过正则组选择获得关键信息
                            Queue<String> queue_ClassValue = new LinkedList<String>();
                            String temp_Str = "";
                            do {
                                for (int ii = 1; ii <= matcher.groupCount(); ii++) {
                                    temp_Str = matcher.group(ii);
                                    if (temp_Str != null) {
                                        queue_ClassValue.offer(temp_Str);
                                    }
                                }
                                String courseName_temp = queue_ClassValue.poll();
                                String weekSection_temp = queue_ClassValue.poll();


                                //tips 需要对location_temp进行二次正则判定，因为有的课程是“（5-5节）6-18周”的格式，如果不将其括号内的内容剔除，会导致数据库查询出错结果
                                String location_temp = queue_ClassValue.poll();
                                String pattern_brackets_str = "\\(\\d{1,2}-\\d{1,2}[\\u4e00-\\u9fa5]\\)";//（4-4节)
                                pattern_brackets_str = regularProperties.getProperty("ClassCourseTable.brackets");
                                Pattern pattern_brackets = Pattern.compile(pattern_brackets_str);
                                Matcher matcher_brackets = pattern_brackets.matcher(weekSection_temp);

                                String temp_bracketsContent = "";
                                if (matcher_brackets.find()) {
                                    temp_bracketsContent = matcher_brackets.group();
                                    location_temp += temp_bracketsContent;
                                }
                                weekSection_temp = matcher_brackets.replaceAll("");//替换成空


                                String teacherName_temp = queue_ClassValue.poll();

                                System.out.println(MessageFormat.format("行:{0},列：{1} || 课程名：{2},周次：{3},地点：{4},教师名称：{5},节次：{6}",
                                        i + 1, j + 1, courseName_temp, weekSection_temp, location_temp, teacherName_temp, courseSection));
                                //TODO 插入数据
                                Course course = new Course(courseName_temp, weekSection_temp, location_temp, teacherName_temp, courseSection);


                                try {
                                    courseService.insertCourseAndGrades(course, gid);
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }

                                count++;
                            } while (matcher.find());
                        }
                    }
                } catch (Exception e) {
                    System.err.println(MessageFormat.format("行为{0},列为{1}", i + 1, j + 1));
                }
            }
        }
        System.out.println("总计提取课程数：" + count);
        return mv;

    }

}
