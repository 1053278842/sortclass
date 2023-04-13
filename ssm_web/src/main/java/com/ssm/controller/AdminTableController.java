package com.ssm.controller;

import com.ssm.domain.ClassSection;
import com.ssm.domain.SingleClass;
import com.ssm.domain.Student;
import com.ssm.domain.WeekTables;
import com.ssm.service.IStudentService;
import com.ssm.service.ISingleClassAllInfoService;
import jdk.internal.util.xml.impl.Input;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Queue;

//@SessionAttribute(value ={"tables"})
@Controller
@RequestMapping("/AdminTable")
public class AdminTableController {

    @Resource(name = "studentService")
    IStudentService studentService;

    @Resource(name = "singleClassService")
    ISingleClassAllInfoService singleClassService;


    /**
     * @param week                 周
     * @param frequency            一周最多出勤频次
     * @param numberOfOneFrequency 单个频次下最多的查看班级数量
     * @param dateRange            日期范围，中间用“-”隔开的两个日期组成的String字符串
     * @param weekSectionRange     只会有：Mon Tue Wed Thu Fri null 这几种值！
     * @return 返回一个WeekTable的格式最终排班表格
     */
    @RequestMapping("/generateTable.do")
//    public ModelAndView addStudent(String sno,String name,String classes,String[] freeClass){
    public ModelAndView generateTable(int week, int frequency, int numberOfOneFrequency, String dateRange, String[] weekSectionRange,
                                      HttpServletRequest request) {

        ModelAndView mv = new ModelAndView();
        mv.setViewName("weekTable_hasStudents");

        String beforDate, afterDate;

        //获取日期范围内的学生
        String[] tempStrArray = dateRange.split("-");
        beforDate = tempStrArray[0];
        afterDate = tempStrArray[1];
        List<Student> dateRangeStudentList = studentService.findStudentByDateRang(beforDate, afterDate);


        //生成完整的课程结构
        WeekTables weekTables = new WeekTables();
        //添加获取所有节次的课程以及班级信息
        weekTables.allocationClassSection(singleClassService.findClassesByWeek(week), weekSectionRange);
        //动态化所有节次课程的出勤数量
        weekTables.setDynamicManagementNumber(numberOfOneFrequency);

        //如果范围内的不存在学生，则无返回值.只返回课程结构
        if(dateRangeStudentList==null||dateRangeStudentList.size()==0){
            mv.addObject("tables", weekTables);
            request.getSession().setAttribute("tables", weekTables);
            return mv;
        }

        //将student根据freeClass加入到weekTables中对应的SingleClass中
        //遍历WeekTable中的mon1-fir7
        for (ClassSection cs : weekTables.getAllClassSectionList()) {
            //将范围内的student根据其course_section为条件，加入到ClassSection课次类中
            for (Student s : dateRangeStudentList) {

                //保存格式化切分后得到FreeClass（Mon1)
                String[] tempClassSectionName = s.getFreeClassFormatArray();

                //匹配后加入到cs的selectedStudents中
                for (int i = 0; i < tempClassSectionName.length; i++) {
                    if (cs.getClassSectionName().equals(tempClassSectionName[i])) {
                        cs.getSelectedStudentQueue().offer(s);
                    }
                }

            }
        }

        //重要性排序
        weekTables.setWeekClassSectionWeight();
        weekTables.setWeekClassSectionByWeightDesc();//weekTables.allWeekClassSection已经按照权重降序排列过了

        while (true) {
            ClassSection cs = weekTables.getAllClassSectionList().get(0);//最重要的ClassSection
            //遍历节次下的班级-课程信息列表
            Queue<SingleClass> scQueue = cs.getSingleClassesQueue();
            //遍历节次下的意向学生列表
            Queue<Student> studentQueue = cs.getSelectedStudentQueue();
            //出勤次数，动态调整后的
            int temp_NumberOfOneFrequency = cs.getDynamicNumberOneFrequency();

            //临时变量，记录单个student在本节次下的出勤次数
            int tempNumber = 0;

            while (scQueue.peek() != null) {

                SingleClass sc = scQueue.peek();//获取该节次下入学年升序排列的班级-课程对象
                Student student = studentQueue.peek();//获取该节次下出勤次数（times)升序排列的学生对象

                //对应出列poll()和setCanSelected(false)的情况，即达到当前频率下的最大次数和达到最大频率
                if (student.isCanSelected() && student != null) {

                    //指定该学生为本班级-课程对象的查课人
                    sc.setStudent(student);
//                    System.out.println(student.getName());
                    tempNumber++;
                    //该课程以及完成分配，不再重新使用.并存储起来方便前端渲染
                    cs.getSingleClasses().add(scQueue.poll());
//                    scQueue.poll();

                    //课程排满后，学生未用完的情况下，仍需重算weight
                    if (scQueue.peek() == null) {
                        //当该节次排满后，学生的出勤频次+1
                        //逻辑相同，顾不冗余填写
                        tempNumber = temp_NumberOfOneFrequency;
                    }

                    //当前频次次数达到最大时，该ClassSection的队列中删去该学生
                    if (tempNumber >= temp_NumberOfOneFrequency) {
                        studentQueue.poll();
                        student.addHasSelectedTimes();//已被选择次数++,标记该学生已经被选择了多少次
                        //当该学生出勤频率达到最大限制时，限制该生的选择
                        if (student.getHasSelectedTimes() >= frequency) {
                            student.setCanSelected(false);//禁用该学生
                        }

                        //TODO 此处重算所有weight,重新循环！
                        weekTables.setWeekClassSectionWeight();
                        weekTables.setWeekClassSectionByWeightDesc();
                        break;
                    }
                } else if (!student.isCanSelected()) {
                    //TODO 或改成，当student.setCanSelected(false)时，poll掉所有的ClassSection中studengQueue与之相等的student
                    studentQueue.poll();
                    //TODO 此处重算所有weight,重新循环！
                    weekTables.setWeekClassSectionWeight();
                    weekTables.setWeekClassSectionByWeightDesc();
                    break;
                }
            }
            //课程排满或学生用完时,跳出循环
            //即所有的权重都等于0
            boolean flagComplete = true;
            for (ClassSection tempCs : weekTables.getAllClassSectionList()) {
                float tempWeight = tempCs.getWeight();
                if (tempWeight > 0) {
                    flagComplete = false;
                    break;
                }
            }
            if (flagComplete) {
                break;
            }
        }

        mv.setViewName("weekTable_hasStudents");
        mv.addObject("tables", weekTables);
        request.getSession().setAttribute("tables", weekTables);
        return mv;
    }


    @ResponseBody
    @RequestMapping("/addTimes.do")
    public void addTimes(HttpServletRequest request) throws Exception {
        //获取weekTable数据
//        System.out.println(request.toString());
        WeekTables weekTables = (WeekTables) request.getSession().getAttribute("tables");

        //将sj内的student addTimes
        for (ClassSection cs : weekTables.getAllClassSectionList()) {
            for (SingleClass sc : cs.getSingleClasses()) {
                int tempId = sc.getStudent().getId();
                studentService.updateAddTimesById(tempId);
            }
        }
//        return "weekTable_hasStudents";
    }


    //WARNING 未完成样式部分
    //FIXME 该部分关于样式部分未完成，也可以通过使用模板快速实现
    @RequestMapping("/excelPrint.do")
    public String excelPrint(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {

        //获取weekTable数据
        WeekTables weekTables = (WeekTables) request.getSession().getAttribute("tables");


        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFPalette palette = workbook.getCustomPalette(); //调色板实例
        HSSFCellStyle cellStyle = workbook.createCellStyle();
        HSSFFont fontStyle = workbook.createFont();

        palette.setColorAtIndex((short) 64, (byte) 55, (byte) 85, (byte) 86);//标题背景深绿色
        palette.setColorAtIndex((short) 63, (byte) 95, (byte) 158, (byte) 160);//周段背景绿色
        palette.setColorAtIndex((short) 62, (byte) 128, (byte) 187, (byte) 215);//日段背景浅蓝色

        HSSFSheet sheet = workbook.createSheet("最终表格");
        for (int i = 1; i < 6; i++) {
            sheet.autoSizeColumn(i);
            sheet.setColumnWidth(i, 256 * 60);
        }
        sheet.setColumnWidth(0, 256 * 5);

        HSSFRow row1 = sheet.createRow(0);
        HSSFCell cell = row1.createCell(0);

        fontStyle = workbook.createFont();
        fontStyle.setColor(HSSFColor.WHITE.index);
        fontStyle.setFontHeightInPoints((short) (18));
        fontStyle.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        cellStyle = workbook.createCellStyle();
        cellStyle.setFont(fontStyle);
        cellStyle.setFillBackgroundColor((short) 64);
        cell.setCellValue("课程表");
        row1.setRowStyle(cellStyle);
        cell.setCellStyle(cellStyle);
        row1.setHeight((short) (27 * 30));
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 5));


//        cell.setCellStyle(cellStyle);
        HSSFRow row2 = sheet.createRow(1);
        row1.setHeight((short) (27 * 15));
        fontStyle = workbook.createFont();
        fontStyle.setColor(HSSFColor.WHITE.index);
        fontStyle.setFontHeightInPoints((short) (16));
        cellStyle = workbook.createCellStyle();
        cellStyle.setFont(fontStyle);
        cellStyle.setFillBackgroundColor((short) 63);
        row2.setRowStyle(cellStyle);
        row2.createCell(0).setCellValue("");
        row2.createCell(1).setCellValue("周一");
        row2.createCell(2).setCellValue("周二");
        row2.createCell(3).setCellValue("周三");
        row2.createCell(4).setCellValue("周四");
        row2.createCell(5).setCellValue("周五");

        HSSFRow row3 = sheet.createRow(2);
        HSSFRow row4 = sheet.createRow(3);
        HSSFRow row5 = sheet.createRow(4);
        HSSFRow row6 = sheet.createRow(5);
        row1.setHeight((short) (27 * 15));
        fontStyle = workbook.createFont();
        fontStyle.setFontHeightInPoints((short) (16));
        cellStyle = workbook.createCellStyle();
        cellStyle.setFont(fontStyle);
        cellStyle.setFillBackgroundColor((short) 62);
        row3.setRowStyle(cellStyle);
        row4.setRowStyle(cellStyle);
        row5.setRowStyle(cellStyle);
        row6.setRowStyle(cellStyle);
        row3.createCell(0).setCellValue("第1、2节");
        row4.createCell(0).setCellValue("第1、2节");
        row5.createCell(0).setCellValue("第1、2节");
        row6.createCell(0).setCellValue("第1、2节");


        String str = "";
        for (ClassSection cs : weekTables.getAllClassSectionList()
        ) {

            String tempWeekSection = cs.getClassSectionName().substring(0, cs.getClassSectionName().length() - 1);
            String tempDaySection = cs.getClassSectionName().substring(cs.getClassSectionName().length() - 1);
            HSSFRow tempRow = null;
            HSSFCell tempCell = null;
            int daySectionInt = 0;

            switch (tempDaySection) {
                case "1":
                    tempRow = row3;
                    break;
                case "3":
                    tempRow = row4;
                    break;
                case "5":
                    tempRow = row5;
                    break;
                case "7":
                    tempRow = row6;
                    break;

            }

            switch (tempWeekSection) {
                case "Mon":
                    daySectionInt = 1;
                    break;
                case "Tue":
                    daySectionInt = 2;
                    break;
                case "Web":
                    daySectionInt = 3;
                    break;
                case "Thu":
                    daySectionInt = 4;
                    break;
                case "Fri":
                    daySectionInt = 5;
                    break;
            }

            tempCell = tempRow.createCell(daySectionInt);
            cellStyle = workbook.createCellStyle();
            cellStyle.setWrapText(true);
            tempCell.setCellStyle(cellStyle);

            for (SingleClass sc : cs.getSingleClasses()
            ) {
                str += sc.getGrade().getClass_name() + "/(应到人数：" + sc.getGrade().getSize() + ")/" + sc.getCourse().getCourse_name() +
                        "/" + sc.getCourse().getCourse_location() + "/" + sc.getCourse().getCourse_teacher_name() + "/" + sc.getStudent().getName() + "\r\n";
            }

            tempCell.setCellValue(str);

        }


        // 输出到临时文件
        String storePath = request.getSession().getServletContext().getRealPath("/") + "upload";
        File parentDirBefor = new File(storePath);
        if (!parentDirBefor.exists()) {
            parentDirBefor.mkdir();
        }
        parentDirBefor = new File(storePath + "/temp");
        if (!parentDirBefor.exists()) {
            parentDirBefor.mkdir();
        }
        String fileName = "Volunteer_Table-" + (new Date()).getTime() + "." + "xls";
        FileOutputStream fout = null;
        try {
            fout = new FileOutputStream(storePath + fileName);
            workbook.write(fout);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (fout != null) {
                    fout.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        // 找到文件并下载
        File file = new File(storePath + fileName);
        if (!file.exists()) {
            throw new RuntimeException("file do not exist");
        }
        InputStream inputStream = null;
        ServletOutputStream servletOutputStream = null;
        // 重置response
        response.reset();
        //设置http头信息的内容
        response.setCharacterEncoding("utf-8");
        response.setContentType("application/vnd.ms-excel");
        response.addHeader("Content-Disposition", "attachment;filename=\"" + fileName + "\"");
        int fileLength = (int) file.length();
        response.setContentLength(fileLength);

        try {
            if (fileLength != 0) {
                inputStream = new FileInputStream(file);
                byte[] buf = new byte[4096];
                // 创建输出流
                servletOutputStream = response.getOutputStream();
                int readLength;
                // 读取文件内容并输出到response的输出流中
                while ((readLength = inputStream.read(buf)) != -1) {
                    servletOutputStream.write(buf, 0, readLength);
                }
            }
        } catch (IOException e) {
            throw new RuntimeException("download file error");
        } finally {
            try {
                // 关闭ServletOutputStream
                if (servletOutputStream != null) {
                    servletOutputStream.flush();
                    servletOutputStream.close();
                }
                // 关闭InputStream
                if (inputStream != null) {
                    inputStream.close();
                }
                // 删除临时文件
                file.delete();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return null;
    }
}
