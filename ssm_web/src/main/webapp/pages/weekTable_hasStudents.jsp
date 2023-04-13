<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/table.css">
    <%-- <script type="text/javascript" src="${pageContext.request.contextPath }/JS/jszip.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/JS/demo.page.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/JS/excel-gen.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/JS/FileSaver.js"></script>
    <script src="http://libs.baidu.com/jquery/1.9.0/jquery.js"></script> --%>

    <!-- 	<script type="text/javascript">
          $(document).ready(function(){
            alert()
            excel = new ExcelGen({
              "src_id":"FinalTable",//table的id
              "show_header":true
            });
            $("#generate-excel").click(function () {
              excel.generate();//执行导入包中的方法。
            })
          });
        </script> -->
    <!-- 页面meta -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>表格</title>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <link rel="stylesheet" href="../plugins/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../plugins/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="../plugins/ionicons/css/ionicons.min.css">
    <link rel="stylesheet" href="../plugins/iCheck/square/blue.css">
    <link rel="stylesheet" href="../plugins/morris/morris.css">
    <link rel="stylesheet" href="../plugins/jvectormap/jquery-jvectormap-1.2.2.css">
    <link rel="stylesheet" href="../plugins/datepicker/datepicker3.css">
    <link rel="stylesheet" href="../plugins/daterangepicker/daterangepicker.css">
    <link rel="stylesheet" href="../plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">
    <link rel="stylesheet" href="../plugins/datatables/dataTables.bootstrap.css">
    <link rel="stylesheet" href="../plugins/treeTable/jquery.treetable.css">
    <link rel="stylesheet" href="../plugins/treeTable/jquery.treetable.theme.default.css">
    <link rel="stylesheet" href="../plugins/select2/select2.css">
    <link rel="stylesheet" href="../plugins/colorpicker/bootstrap-colorpicker.min.css">
    <link rel="stylesheet" href="../plugins/bootstrap-markdown/css/bootstrap-markdown.min.css">
    <link rel="stylesheet" href="../plugins/adminLTE/css/AdminLTE.css">
    <link rel="stylesheet" href="../plugins/adminLTE/css/skins/_all-skins.min.css">
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../plugins/ionslider/ion.rangeSlider.css">
    <link rel="stylesheet" href="../plugins/ionslider/ion.rangeSlider.skinNice.css">
    <link rel="stylesheet" href="../plugins/bootstrap-slider/slider.css">
    <link rel="stylesheet" href="../plugins/bootstrap-datetimepicker/bootstrap-datetimepicker.css">
</head>
<body class="hold-transition skin-green-light">
<div class="wrapper">

    <table border="1px" id="FinalTable" class="table table-bordered table-hover dataTable">
        <tr style="line-height: 2px;">
            <td colspan="6"><h3>课程表</h3></td>
        </tr>
        <tr id="title_table">
            <td></td>
            <td>周一</td>
            <td>周二</td>
            <td>周三</td>
            <td>周四</td>
            <td>周五</td>
        </tr>
        <tr class="even">
            <td>第1、2节</td>

            <td>
                <ul>
                    <c:forEach items="${tables.allClassSectionList}" var="table" varStatus="vs">
                        <c:if test="${table.classSectionName=='Mon1'}">
                            <c:forEach items="${table.singleClasses}" var="sc" varStatus="vs2">
                                <li>${sc.grade.class_name}/(应到人数：${sc.grade.size})/${sc.course.course_name}/${sc.course.course_location}/${sc.course.course_teacher_name}
                                    <span style="color:red;">${sc.student.name}</span></li>
                            </c:forEach>
                            <c:forEach items="${table.singleClassesQueue}" var="scq" varStatus="vsq">
                                <li>${scq.grade.class_name}/(应到人数：${scq.grade.size})/${scq.course.course_name}/${scq.course.course_location}/${scq.course.course_teacher_name}
                                    <span style="color:red;">${scq.student.name}</span></li>
                            </c:forEach>
                        </c:if>
                    </c:forEach>
                </ul>
            </td>
            <td>
                <ul>
                    <c:forEach items="${tables.allClassSectionList}" var="table" varStatus="vs">
                        <c:if test="${table.classSectionName=='Tue1'}">
                            <c:forEach items="${table.singleClasses}" var="sc" varStatus="vs2">
                                <li>${sc.grade.class_name}/(应到人数：${sc.grade.size})/${sc.course.course_name}/${sc.course.course_location}/${sc.course.course_teacher_name}
                                    <span style="color:red;">${sc.student.name}</span></li>
                            </c:forEach>
                            <c:forEach items="${table.singleClassesQueue}" var="scq" varStatus="vsq">
                                <li>${scq.grade.class_name}/(应到人数：${scq.grade.size})/${scq.course.course_name}/${scq.course.course_location}/${scq.course.course_teacher_name}
                                    <span style="color:red;">${scq.student.name}</span></li>
                            </c:forEach>
                        </c:if>
                    </c:forEach>

                </ul>
            </td>
            <td>
                <ul>
                    <c:forEach items="${tables.allClassSectionList}" var="table" varStatus="vs">
                        <c:if test="${table.classSectionName=='Web1'}">
                            <c:forEach items="${table.singleClasses}" var="sc" varStatus="vs2">
                                <li>${sc.grade.class_name}/(应到人数：${sc.grade.size})/${sc.course.course_name}/${sc.course.course_location}/${sc.course.course_teacher_name}
                                    <span style="color:red;">${sc.student.name}</span></li>
                            </c:forEach>
                            <c:forEach items="${table.singleClassesQueue}" var="scq" varStatus="vsq">
                                <li>${scq.grade.class_name}/(应到人数：${scq.grade.size})/${scq.course.course_name}/${scq.course.course_location}/${scq.course.course_teacher_name}
                                    <span style="color:red;">${scq.student.name}</span></li>
                            </c:forEach>
                        </c:if>
                    </c:forEach>
                </ul>
            </td>
            <td>
                <ul>
                    <c:forEach items="${tables.allClassSectionList}" var="table" varStatus="vs">
                        <c:if test="${table.classSectionName=='Thu1'}">
                            <c:forEach items="${table.singleClasses}" var="sc" varStatus="vs2">
                                <li>${sc.grade.class_name}/(应到人数：${sc.grade.size})/${sc.course.course_name}/${sc.course.course_location}/${sc.course.course_teacher_name}
                                    <span style="color:red;">${sc.student.name}</span></li>
                            </c:forEach>
                            <c:forEach items="${table.singleClassesQueue}" var="scq" varStatus="vsq">
                                <li>${scq.grade.class_name}/(应到人数：${scq.grade.size})/${scq.course.course_name}/${scq.course.course_location}/${scq.course.course_teacher_name}
                                    <span style="color:red;">${scq.student.name}</span></li>
                            </c:forEach>
                        </c:if>
                    </c:forEach>
                </ul>
            </td>
            <td>
                <ul>
                    <c:forEach items="${tables.allClassSectionList}" var="table" varStatus="vs">
                        <c:if test="${table.classSectionName=='Fri1'}">
                            <c:forEach items="${table.singleClasses}" var="sc" varStatus="vs2">
                                <li>${sc.grade.class_name}/(应到人数：${sc.grade.size})/${sc.course.course_name}/${sc.course.course_location}/${sc.course.course_teacher_name}
                                    <span style="color:red;">${sc.student.name}</span></li>
                            </c:forEach>
                            <c:forEach items="${table.singleClassesQueue}" var="scq" varStatus="vsq">
                                <li>${scq.grade.class_name}/(应到人数：${scq.grade.size})/${scq.course.course_name}/${scq.course.course_location}/${scq.course.course_teacher_name}
                                    <span style="color:red;">${scq.student.name}</span></li>
                            </c:forEach>
                        </c:if>
                    </c:forEach>
                </ul>
            </td>
        </tr>

        <tr class="odd">
            <td>第3、4节</td>

            <td>
                <ul>
                    <c:forEach items="${tables.allClassSectionList}" var="table" varStatus="vs">
                        <c:if test="${table.classSectionName=='Mon3'}">
                            <c:forEach items="${table.singleClasses}" var="sc" varStatus="vs2">
                                <li>${sc.grade.class_name}/(应到人数：${sc.grade.size})/${sc.course.course_name}/${sc.course.course_location}/${sc.course.course_teacher_name}
                                    <span style="color:red;">${sc.student.name}</span></li>
                            </c:forEach>
                            <c:forEach items="${table.singleClassesQueue}" var="scq" varStatus="vsq">
                                <li>${scq.grade.class_name}/(应到人数：${scq.grade.size})/${scq.course.course_name}/${scq.course.course_location}/${scq.course.course_teacher_name}
                                    <span style="color:red;">${scq.student.name}</span></li>
                            </c:forEach>
                        </c:if>
                    </c:forEach>
                </ul>
            </td>
            <td>
                <ul>
                    <c:forEach items="${tables.allClassSectionList}" var="table" varStatus="vs">
                        <c:if test="${table.classSectionName=='Tue3'}">
                            <c:forEach items="${table.singleClasses}" var="sc" varStatus="vs2">
                                <li>${sc.grade.class_name}/(应到人数：${sc.grade.size})/${sc.course.course_name}/${sc.course.course_location}/${sc.course.course_teacher_name}
                                    <span style="color:red;">${sc.student.name}</span></li>
                            </c:forEach>
                            <c:forEach items="${table.singleClassesQueue}" var="scq" varStatus="vsq">
                                <li>${scq.grade.class_name}/(应到人数：${scq.grade.size})/${scq.course.course_name}/${scq.course.course_location}/${scq.course.course_teacher_name}
                                    <span style="color:red;">${scq.student.name}</span></li>
                            </c:forEach>
                        </c:if>
                    </c:forEach>
                </ul>
            </td>
            <td>
                <ul>
                    <c:forEach items="${tables.allClassSectionList}" var="table" varStatus="vs">
                        <c:if test="${table.classSectionName=='Web3'}">
                            <c:forEach items="${table.singleClasses}" var="sc" varStatus="vs2">
                                <li>${sc.grade.class_name}/(应到人数：${sc.grade.size})/${sc.course.course_name}/${sc.course.course_location}/${sc.course.course_teacher_name}
                                    <span style="color:red;">${sc.student.name}</span></li>
                            </c:forEach>
                            <c:forEach items="${table.singleClassesQueue}" var="scq" varStatus="vsq">
                                <li>${scq.grade.class_name}/(应到人数：${scq.grade.size})/${scq.course.course_name}/${scq.course.course_location}/${scq.course.course_teacher_name}
                                    <span style="color:red;">${scq.student.name}</span></li>
                            </c:forEach>
                        </c:if>
                    </c:forEach>
                </ul>
            </td>
            <td>
                <ul>
                    <c:forEach items="${tables.allClassSectionList}" var="table" varStatus="vs">
                        <c:if test="${table.classSectionName=='Thu3'}">
                            <c:forEach items="${table.singleClasses}" var="sc" varStatus="vs2">
                                <li>${sc.grade.class_name}/(应到人数：${sc.grade.size})/${sc.course.course_name}/${sc.course.course_location}/${sc.course.course_teacher_name}
                                    <span style="color:red;">${sc.student.name}</span></li>
                            </c:forEach>
                            <c:forEach items="${table.singleClassesQueue}" var="scq" varStatus="vsq">
                                <li>${scq.grade.class_name}/(应到人数：${scq.grade.size})/${scq.course.course_name}/${scq.course.course_location}/${scq.course.course_teacher_name}
                                    <span style="color:red;">${scq.student.name}</span></li>
                            </c:forEach>
                        </c:if>
                    </c:forEach>
                </ul>
            </td>
            <td>
                <ul>
                    <c:forEach items="${tables.allClassSectionList}" var="table" varStatus="vs">
                        <c:if test="${table.classSectionName=='Fri3'}">
                            <c:forEach items="${table.singleClasses}" var="sc" varStatus="vs2">
                                <li>${sc.grade.class_name}/(应到人数：${sc.grade.size})/${sc.course.course_name}/${sc.course.course_location}/${sc.course.course_teacher_name}
                                    <span style="color:red;">${sc.student.name}</span></li>
                            </c:forEach>
                            <c:forEach items="${table.singleClassesQueue}" var="scq" varStatus="vsq">
                                <li>${scq.grade.class_name}/(应到人数：${scq.grade.size})/${scq.course.course_name}/${scq.course.course_location}/${scq.course.course_teacher_name}
                                    <span style="color:red;">${scq.student.name}</span></li>
                            </c:forEach>
                        </c:if>
                    </c:forEach>
                </ul>
            </td>
        </tr>

        <tr class="even">
            <td>第5、6节</td>

            <td>
                <ul>
                    <c:forEach items="${tables.allClassSectionList}" var="table" varStatus="vs">
                        <c:if test="${table.classSectionName=='Mon5'}">
                            <c:forEach items="${table.singleClasses}" var="sc" varStatus="vs2">
                                <li>${sc.grade.class_name}/(应到人数：${sc.grade.size})/${sc.course.course_name}/${sc.course.course_location}/${sc.course.course_teacher_name}
                                    <span style="color:red;">${sc.student.name}</span></li>
                            </c:forEach>
                            <c:forEach items="${table.singleClassesQueue}" var="scq" varStatus="vsq">
                                <li>${scq.grade.class_name}/(应到人数：${scq.grade.size})/${scq.course.course_name}/${scq.course.course_location}/${scq.course.course_teacher_name}
                                    <span style="color:red;">${scq.student.name}</span></li>
                            </c:forEach>
                        </c:if>
                    </c:forEach>
                </ul>
            </td>
            <td>
                <ul>
                    <c:forEach items="${tables.allClassSectionList}" var="table" varStatus="vs">
                        <c:if test="${table.classSectionName=='Tue5'}">
                            <c:forEach items="${table.singleClasses}" var="sc" varStatus="vs2">
                                <li>${sc.grade.class_name}/(应到人数：${sc.grade.size})/${sc.course.course_name}/${sc.course.course_location}/${sc.course.course_teacher_name}
                                    <span style="color:red;">${sc.student.name}</span></li>
                            </c:forEach>
                            <c:forEach items="${table.singleClassesQueue}" var="scq" varStatus="vsq">
                                <li>${scq.grade.class_name}/(应到人数：${scq.grade.size})/${scq.course.course_name}/${scq.course.course_location}/${scq.course.course_teacher_name}
                                    <span style="color:red;">${scq.student.name}</span></li>
                            </c:forEach>
                        </c:if>
                    </c:forEach>
                </ul>
            </td>
            <td>
                <ul>
                    <c:forEach items="${tables.allClassSectionList}" var="table" varStatus="vs">
                        <c:if test="${table.classSectionName=='Web5'}">
                            <c:forEach items="${table.singleClasses}" var="sc" varStatus="vs2">
                                <li>${sc.grade.class_name}/(应到人数：${sc.grade.size})/${sc.course.course_name}/${sc.course.course_location}/${sc.course.course_teacher_name}
                                    <span style="color:red;">${sc.student.name}</span></li>
                            </c:forEach>
                            <c:forEach items="${table.singleClassesQueue}" var="scq" varStatus="vsq">
                                <li>${scq.grade.class_name}/(应到人数：${scq.grade.size})/${scq.course.course_name}/${scq.course.course_location}/${scq.course.course_teacher_name}
                                    <span style="color:red;">${scq.student.name}</span></li>
                            </c:forEach>
                        </c:if>
                    </c:forEach>
                </ul>
            </td>
            <td>
                <ul>
                    <c:forEach items="${tables.allClassSectionList}" var="table" varStatus="vs">
                        <c:if test="${table.classSectionName=='Thu5'}">
                            <c:forEach items="${table.singleClasses}" var="sc" varStatus="vs2">
                                <li>${sc.grade.class_name}/(应到人数：${sc.grade.size})/${sc.course.course_name}/${sc.course.course_location}/${sc.course.course_teacher_name}
                                    <span style="color:red;">${sc.student.name}</span></li>
                            </c:forEach>
                            <c:forEach items="${table.singleClassesQueue}" var="scq" varStatus="vsq">
                                <li>${scq.grade.class_name}/(应到人数：${scq.grade.size})/${scq.course.course_name}/${scq.course.course_location}/${scq.course.course_teacher_name}
                                    <span style="color:red;">${scq.student.name}</span></li>
                            </c:forEach>
                        </c:if>
                    </c:forEach>
                </ul>
            </td>
            <td>
                <ul>
                    <c:forEach items="${tables.allClassSectionList}" var="table" varStatus="vs">
                        <c:if test="${table.classSectionName=='Fri5'}">
                            <c:forEach items="${table.singleClasses}" var="sc" varStatus="vs2">
                                <li>${sc.grade.class_name}/(应到人数：${sc.grade.size})/${sc.course.course_name}/${sc.course.course_location}/${sc.course.course_teacher_name}
                                    <span style="color:red;">${sc.student.name}</span></li>
                            </c:forEach>
                            <c:forEach items="${table.singleClassesQueue}" var="scq" varStatus="vsq">
                                <li>${scq.grade.class_name}/(应到人数：${scq.grade.size})/${scq.course.course_name}/${scq.course.course_location}/${scq.course.course_teacher_name}
                                    <span style="color:red;">${scq.student.name}</span></li>
                            </c:forEach>
                        </c:if>
                    </c:forEach>
                </ul>
            </td>
        </tr>

        <tr class="odd">
            <td>第7、8节</td>

            <td>
                <ul>
                    <c:forEach items="${tables.allClassSectionList}" var="table" varStatus="vs">
                        <c:if test="${table.classSectionName=='Mon7'}">
                            <c:forEach items="${table.singleClasses}" var="sc" varStatus="vs2">
                                <li>${sc.grade.class_name}/(应到人数：${sc.grade.size})/${sc.course.course_name}/${sc.course.course_location}/${sc.course.course_teacher_name}
                                    <span style="color:red;">${sc.student.name}</span></li>
                            </c:forEach>
                            <c:forEach items="${table.singleClassesQueue}" var="scq" varStatus="vsq">
                                <li>${scq.grade.class_name}/(应到人数：${scq.grade.size})/${scq.course.course_name}/${scq.course.course_location}/${scq.course.course_teacher_name}
                                    <span style="color:red;">${scq.student.name}</span></li>
                            </c:forEach>
                        </c:if>
                    </c:forEach>
                </ul>
            </td>
            <td>
                <ul>
                    <c:forEach items="${tables.allClassSectionList}" var="table" varStatus="vs">
                        <c:if test="${table.classSectionName=='Tue7'}">
                            <c:forEach items="${table.singleClasses}" var="sc" varStatus="vs2">
                                <li>${sc.grade.class_name}/(应到人数：${sc.grade.size})/${sc.course.course_name}/${sc.course.course_location}/${sc.course.course_teacher_name}
                                    <span style="color:red;">${sc.student.name}</span></li>
                            </c:forEach>
                            <c:forEach items="${table.singleClassesQueue}" var="scq" varStatus="vsq">
                                <li>${scq.grade.class_name}/(应到人数：${scq.grade.size})/${scq.course.course_name}/${scq.course.course_location}/${scq.course.course_teacher_name}
                                    <span style="color:red;">${scq.student.name}</span></li>
                            </c:forEach>
                        </c:if>
                    </c:forEach>
                </ul>
            </td>
            <td>
                <ul>
                    <c:forEach items="${tables.allClassSectionList}" var="table" varStatus="vs">
                        <c:if test="${table.classSectionName=='Web7'}">
                            <c:forEach items="${table.singleClasses}" var="sc" varStatus="vs2">
                                <li>${sc.grade.class_name}/(应到人数：${sc.grade.size})/${sc.course.course_name}/${sc.course.course_location}/${sc.course.course_teacher_name}
                                    <span style="color:red;">${sc.student.name}</span></li>
                            </c:forEach>
                            <c:forEach items="${table.singleClassesQueue}" var="scq" varStatus="vsq">
                                <li>${scq.grade.class_name}/(应到人数：${scq.grade.size})/${scq.course.course_name}/${scq.course.course_location}/${scq.course.course_teacher_name}
                                    <span style="color:red;">${scq.student.name}</span></li>
                            </c:forEach>
                        </c:if>
                    </c:forEach>
                </ul>
            </td>
            <td>
                <ul>
                    <c:forEach items="${tables.allClassSectionList}" var="table" varStatus="vs">
                        <c:if test="${table.classSectionName=='Thu7'}">
                            <c:forEach items="${table.singleClasses}" var="sc" varStatus="vs2">
                                <li>${sc.grade.class_name}/(应到人数：${sc.grade.size})/${sc.course.course_name}/${sc.course.course_location}/${sc.course.course_teacher_name}
                                    <span style="color:red;">${sc.student.name}</span></li>
                            </c:forEach>
                            <c:forEach items="${table.singleClassesQueue}" var="scq" varStatus="vsq">
                                <li>${scq.grade.class_name}/(应到人数：${scq.grade.size})/${scq.course.course_name}/${scq.course.course_location}/${scq.course.course_teacher_name}
                                    <span style="color:red;">${scq.student.name}</span></li>
                            </c:forEach>
                        </c:if>
                    </c:forEach>
                </ul>
            </td>
            <td>
                <ul>
                    <c:forEach items="${tables.allClassSectionList}" var="table" varStatus="vs">
                        <c:if test="${table.classSectionName=='Fri7'}">
                            <c:forEach items="${table.singleClasses}" var="sc" varStatus="vs2">
                                <li>${sc.grade.class_name}/(应到人数：${sc.grade.size})/${sc.course.course_name}/${sc.course.course_location}/${sc.course.course_teacher_name}
                                    <span style="color:red;">${sc.student.name}</span></li>
                            </c:forEach>
                            <c:forEach items="${table.singleClassesQueue}" var="scq" varStatus="vsq">
                                <li>${scq.grade.class_name}/(应到人数：${scq.grade.size})/${scq.course.course_name}/${scq.course.course_location}/${scq.course.course_teacher_name}
                                    <span style="color:red;">${scq.student.name}</span></li>
                            </c:forEach>
                        </c:if>
                    </c:forEach>
                </ul>
            </td>
        </tr>
    </table>
    <%--	<button type="button" class="btn btn-success" id="generate-excel" onclick="window.location.href ='${pageContext.request.contextPath}/AdminTable/excelPrint.do'">导出Excel</button>--%>
    <div class="text-center with-border">
        <button style="margin-top: 0px;" type="button" class="btn btn-lg btn-block btn-success" id="generate-excel"
                onclick="return alert('此功能维护中！')">导出Excel
        </button>
        <button style="margin-top: 0px;" type="button" class="btn btn-lg btn-block btn-primary" id="addTimesBtn"
        >确定为最终表格后请点击我！
        </button>
    </div>
</div>

<script src="${pageContext.request.contextPath}/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/jQueryUI/jquery-ui.min.js"></script>
<script>
    $.widget.bridge('uibutton', $.ui.button);
</script>
<script src="${pageContext.request.contextPath}/plugins/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/raphael/raphael-min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/morris/morris.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/sparkline/jquery.sparkline.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<script src="${pageContext.request.contextPath}/plugins/knob/jquery.knob.js"></script>
<script src="${pageContext.request.contextPath}/plugins/daterangepicker/moment.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/daterangepicker/daterangepicker.js"></script>
<script src="${pageContext.request.contextPath}/plugins/daterangepicker/daterangepicker.zh-CN.js"></script>
<script src="${pageContext.request.contextPath}/plugins/datepicker/bootstrap-datepicker.js"></script>
<script src="${pageContext.request.contextPath}/plugins/datepicker/locales/bootstrap-datepicker.zh-CN.js"></script>
<script src="${pageContext.request.contextPath}/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/fastclick/fastclick.js"></script>
<script src="${pageContext.request.contextPath}/plugins/iCheck/icheck.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/adminLTE/js/app.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/treeTable/jquery.treetable.js"></script>
<script src="${pageContext.request.contextPath}/plugins/select2/select2.full.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.zh-CN.js"></script>
<script src="${pageContext.request.contextPath}/plugins/bootstrap-markdown/js/bootstrap-markdown.js"></script>
<script src="${pageContext.request.contextPath}/plugins/bootstrap-markdown/locale/bootstrap-markdown.zh.js"></script>
<script src="${pageContext.request.contextPath}/plugins/bootstrap-markdown/js/markdown.js"></script>
<script src="${pageContext.request.contextPath}/plugins/bootstrap-markdown/js/to-markdown.js"></script>
<script src="${pageContext.request.contextPath}/plugins/ckeditor/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/plugins/input-mask/jquery.inputmask.js"></script>
<script src="${pageContext.request.contextPath}/plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
<script src="${pageContext.request.contextPath}/plugins/input-mask/jquery.inputmask.extensions.js"></script>
<script src="${pageContext.request.contextPath}/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/datatables/dataTables.bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/chartjs/Chart.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/flot/jquery.flot.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/flot/jquery.flot.resize.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/flot/jquery.flot.pie.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/flot/jquery.flot.categories.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/ionslider/ion.rangeSlider.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/bootstrap-slider/bootstrap-slider.js"></script>
<script src="${pageContext.request.contextPath}/plugins/bootstrap-datetimepicker/bootstrap-datetimepicker.js"></script>
<script src="${pageContext.request.contextPath}/plugins/bootstrap-datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script>
    $(function () {
        $("#addTimesBtn").click(function () {
            //获取excel格式文件
            var statu = confirm("是否确定最终效果?确认后不可更改！");
            if (!statu) {
                return false;
            }
            <%--window.location.href="${pageContext.request.contextPath}/AdminTable/addTimes.do";--%>
            $.ajax({
                url: "${pageContext.request.contextPath}/AdminTable/addTimes.do",
                type: "post",
                success: function (data) {
                    alert("表内志愿者出勤次数已自增！")
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(XMLHttpRequest.status);
                    alert(XMLHttpRequest.readyState);
                    alert(textStatus);
                }
            })
        })
    })

</script>
</body>
</html>