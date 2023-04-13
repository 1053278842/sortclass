package com.ssm.controller;

import com.ssm.domain.ClassSection;
import com.ssm.domain.SingleClass;
import com.ssm.domain.Student;
import com.ssm.domain.WeekTables;
import com.ssm.service.ICourseService;
import com.ssm.service.ISingleClassAllInfoService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Queue;

/**
 * 用于生成课表（无学生）
 * 通过条件周、班级名（可多选）
 */
@Controller
@RequestMapping("/Course")
public class CourseController {

    @Resource(name = "courseService")
    private ICourseService courseService;

    @Resource(name = "singleClassService")
    private ISingleClassAllInfoService singleClassService;


    @RequestMapping("/showCourseTable.do")
    public ModelAndView showCourseTable(HttpServletRequest request,
                                        @RequestParam(value = "week", defaultValue = "0") int week,
                                        @RequestParam(value = "className", defaultValue = "17计科（2+3）") String className) {
        ModelAndView mv = new ModelAndView();
        System.err.println(week + "|" + className);
        //生成完整的课程结构
        WeekTables weekTables = new WeekTables();
        //添加获取所有节次的课程以及班级信息
        weekTables.addClassSectionBySingleClassList(singleClassService.findClassesByWeekAndClassName(week, className));
        //动态化所有节次课程的出勤数量


        mv.setViewName("weekTable_hasStudents");
        mv.addObject("tables", weekTables);
        request.getSession().setAttribute("tables", weekTables);
        return mv;
    }

}
