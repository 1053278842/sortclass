package com.ssm.controller;

import com.github.pagehelper.PageInfo;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.ssm.domain.Student;
import com.ssm.service.IStudentService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.text.MessageFormat;
import java.util.List;

@Controller
@RequestMapping("/AdminStudent")
public class AdminStudentController {

    @Resource(name = "studentService")
    private IStudentService studentService;


    /**
     * 删除选则的若干id，使用@ResponseBody，不会产生404
     *
     * @param ids id的集合
     * @return 返回order by date desc 的默认数据列表
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping("/deleteById.do")
    public void deleteByIds(int id) throws Exception {
        studentService.deleteById(id);
        System.out.println(id + "已被删除！");
    }

    /**
     * 增加Times+1
     *
     * @param id
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping("/updateAddTimesById.do")
    public void updateAddTimesById(int id) throws Exception {
        studentService.updateAddTimesById(id);
        System.out.println("自增执行" + id);
    }

    /**
     * 减少Times-1
     *
     * @param id
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping("/updateMinusTimesById.do")
    public void updateMinusTimesById(int id) throws Exception {
        studentService.updateMinusTimesById(id);
    }

    /**
     * 清空Time
     *
     * @param id
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping("/updateClearTimesById.do")
    public void updateClearTimesById(int id) throws Exception {
        studentService.updateClearTimesById(id);
    }

    @ResponseBody
    @RequestMapping("/findAllByMoreCondition.do")
    public String findAllByMoreCondition(@RequestBody @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
                                         @RequestBody @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                                         @RequestBody @RequestParam(value = "field", defaultValue = "date") String field,
                                         @RequestBody @RequestParam(value = "sortDire", defaultValue = "desc") String sortDire,
                                         @RequestBody @RequestParam(value = "likeValue", defaultValue = "") String likeValue,
                                         HttpSession session) throws Exception {
        List<Student> students = studentService.findAllByMoreCondition(pageNum, pageSize, field, sortDire);
        //likeValue有值就是模糊搜索，只需要pageNum,pageSize,likeValue三个属性
        if (likeValue != null && !likeValue.equals("") && likeValue.length() > 0 && !likeValue.equals("null")) {
            students = studentService.findAllByLikeValue(pageNum, pageSize, field, sortDire, likeValue);
        }
        PageInfo<Student> pageInfo = new PageInfo((students));
        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        System.out.println(MessageFormat.format("后台收到的数据||pageNum:{0},pageSize:{1},field:{2},sortDire:{3},likeValue:{4}", pageNum, pageSize, field, sortDire, likeValue));
        for (Student s : pageInfo.getList()
        ) {
            System.out.println(s.getDate() + "xx" + s.getName());
        }
        System.out.println("e:" + gson.toJson(pageInfo));
        System.out.println(MessageFormat.format("field:{0},sortDire:{1}", field, sortDire));
        return gson.toJson(pageInfo);
    }
}
