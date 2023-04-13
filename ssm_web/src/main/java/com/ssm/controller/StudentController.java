package com.ssm.controller;

import com.alibaba.fastjson.JSONObject;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.ssm.domain.Student;
import com.ssm.service.IStudentService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.text.MessageFormat;
import java.util.Date;
import java.sql.Timestamp;

@Controller
@RequestMapping("/Student")
public class StudentController {

    @Resource(name = "studentService")
    IStudentService studentService;

    @RequestMapping("/addStudent.do")
//    public ModelAndView addStudent(String sno,String name,String classes,String[] freeClass){
    public ModelAndView addStudent(Student student, String[] freeClass) {
//        System.out.println(student);
        ModelAndView mv = new ModelAndView();
        //创建TimeData日期
        Date date = new Date();
        Timestamp timestamp = new Timestamp(date.getTime());
        student.setDate(timestamp);
        String freeClassResult = "";
        for (String s : freeClass
        ) {
            freeClassResult += ("," + s);
        }
        student.setFreeClasses(freeClassResult);
        studentService.insertStudentNoRepeat(student);
        mv.setViewName("/InputPages/inputVolunteerInfo");
        mv.addObject("Message", student);
        return mv;
    }

    @ResponseBody
    @RequestMapping("/isExistBySno.do")
    public String isExistBySno(@RequestBody @RequestParam(value = "sno") String sno) {
        String status = "";
        Student student = studentService.findStudentBySno(sno);
        //判断，给出返回类型
        if (student == null) {
            status = "新用户！";
        } else {
            status = "老朋友！";
        }
        String json = "{\"status\":\"" + status + "\"}";
        return json;
    }
}
