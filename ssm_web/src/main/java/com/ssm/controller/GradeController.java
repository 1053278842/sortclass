package com.ssm.controller;


import com.google.gson.Gson;
import com.ssm.domain.Grade;
import com.ssm.service.IGradeService;
import com.ssm.service.IStudentService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("/Grade")
public class GradeController {


    @Resource(name = "gradeService")
    private IGradeService gradeService;

    @ResponseBody
    @RequestMapping("/getAllGrade.do")
    public String getAllGrade() {
        List<Grade> gradeList = gradeService.findAll();
        Gson gson = new Gson();
        String json = gson.toJson(gradeList);
        System.err.println(json);
        return json;
    }
}
