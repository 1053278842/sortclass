<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/InputVolunteer.css">
    <script src="${pageContext.request.contextPath}/plugins/jQuery/jquery-2.2.3.min.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
    <%--渐变动画jquery插件引用--%>
    <script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
    <script type="text/javascript">
        function CheckForm() {
            if (!(CheckName())) {
                alert("请按要求填写信息！");
            }
            return CheckName();
        }

        function CheckName() {
            var name = document.getElementsByName("name")[0].value;
            var sno = document.getElementsByName("sno")[0].value;
            var classes = document.getElementsByName("classes")[0].value;
            if (name == "")
                return false;
            if (sno == "")
                return false;
            if (classes == "")
                return false;
            return true;
        }
    </script>
    <meta charset="UTF-8">
    <title>志愿者信息录入</title>
</head>
<body>
<img alt="" src="${pageContext.request.contextPath}/img/校徽.png" id="logo">
<form action="${pageContext.request.contextPath}/Student/addStudent.do" onsubmit="return CheckForm()">
    <div id="InfoBg">
        <table id="BigTable">
            <caption><h3>志愿者信息录入系统</h3></caption>
            <tr>
                <td class="FirstField">学 号：</td>
                <td><input class="Data_Text" type="text" name="sno" oninput="value=value.replace(/[^\d]/g,'')"
                           maxlength="11" placeholder="">
                    <span id="snoTips" style="font-weight: 700"></span></td>
            </tr>
            <tr>
                <td class="FirstField">姓 名：</td>
                <td><input class="Data_Text" type="text" name="name" placeholder=""></td>
            </tr>
            <tr>
                <td class="FirstField">班 级：</td>
                <td>
                    <input class="Data_Text" type="text" name="classes" placeholder="">
                </td>
            </tr>
            <%--            <tr>--%>
            <%--                <td class="FirstField">类    型：</td>--%>
            <%--                <td>--%>
            <%--                    <input type="radio" name="type" value="volunteer" checked="checked">志愿者--%>
            <%--                    <input type="radio" name="type" value="membership">学生会成员--%>
            <%--                </td>--%>
            <%--            </tr>--%>
            <tr>
                <td class="FirstField2" valign="top" colspan="2">空闲课程：</td>
            </tr>
            <tr>
                <td colspan="2">
                    <table id="SmallTable">
                        <tr>
                            <td>周 一:</td>
                            <td>
                                &nbsp;&nbsp;&nbsp;&nbsp;<span name="Mon1">1</span><input type="checkbox"
                                                                                         name="freeClass" value="Mon1">
                                &nbsp;&nbsp;&nbsp;&nbsp;<span name="Mon3">3</span><input type="checkbox"
                                                                                         name="freeClass" value="Mon3">
                                &nbsp;&nbsp;&nbsp;&nbsp;<span name="Mon5">5</span><input type="checkbox"
                                                                                         name="freeClass" value="Mon5">
                                &nbsp;&nbsp;&nbsp;&nbsp;<span name="Mon7">7</span><input type="checkbox"
                                                                                         name="freeClass" value="Mon7">
                            </td>
                        </tr>
                        <tr>
                            <td>周 二:</td>
                            <td>
                                &nbsp;&nbsp;&nbsp;&nbsp;<span name="Thu1">1</span><input type="checkbox"
                                                                                         name="freeClass" value="Tue1">
                                &nbsp;&nbsp;&nbsp;&nbsp;<span name="Tue3">3</span><input type="checkbox"
                                                                                         name="freeClass" value="Tue3">
                                &nbsp;&nbsp;&nbsp;&nbsp;<span name="Tue5">5</span><input type="checkbox"
                                                                                         name="freeClass" value="Tue5">
                                &nbsp;&nbsp;&nbsp;&nbsp;<span name="Tue7">7</span><input type="checkbox"
                                                                                         name="freeClass" value="Tue7">
                            </td>
                        </tr>
                        <tr>
                            <td>周 三:</td>
                            <td>
                                &nbsp;&nbsp;&nbsp;&nbsp;<span name="Web1">1</span><input type="checkbox"
                                                                                         name="freeClass" value="Web1">
                                &nbsp;&nbsp;&nbsp;&nbsp;<span name="Web3">3</span><input type="checkbox"
                                                                                         name="freeClass" value="Web3">
                                &nbsp;&nbsp;&nbsp;&nbsp;<span name="Web5">5</span><input type="checkbox"
                                                                                         name="freeClass" value="Web5">
                                &nbsp;&nbsp;&nbsp;&nbsp;<span name="Web7">7</span><input type="checkbox"
                                                                                         name="freeClass" value="Web7">
                            </td>
                        </tr>
                        <tr>
                            <td>周 四:</td>
                            <td>
                                &nbsp;&nbsp;&nbsp; <span name="Thu1">1</span><input type="checkbox" name="freeClass"
                                                                                    value="Thu1">
                                &nbsp;&nbsp;&nbsp;&nbsp;<span name="Thu3">3</span><input type="checkbox"
                                                                                         name="freeClass" value="Thu3">
                                &nbsp;&nbsp;&nbsp;&nbsp;<span name="Thu5">5</span><input type="checkbox"
                                                                                         name="freeClass" value="Thu5">
                                &nbsp;&nbsp;&nbsp;&nbsp;<span name="Thu7">7</span><input type="checkbox"
                                                                                         name="freeClass" value="Thu7">
                            </td>
                        </tr>
                        <tr>
                            <td>周 五:</td>
                            <td>
                                &nbsp;&nbsp;&nbsp;&nbsp;<span name="Fri1">1</span><input type="checkbox"
                                                                                         name="freeClass" value="Fri1">
                                &nbsp;&nbsp;&nbsp;&nbsp;<span name="Fri3">3</span><input type="checkbox"
                                                                                         name="freeClass" value="Fri3">
                                &nbsp;&nbsp;&nbsp;&nbsp;<span name="Fri5">5</span><input type="checkbox"
                                                                                         name="freeClass" value="Fri5">
                                &nbsp;&nbsp;&nbsp;&nbsp;<span name="Fri7">7</span><input type="checkbox"
                                                                                         name="freeClass" value="Fri7">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="2"><input type="submit" value="提交" class="Input_Button">
                    <input type="reset" value="清空" class="Input_Button"></td>
            </tr>

        </table>
    </div>
    <div style="text-align: center;padding-top: 20px;color:#841f00;">
        <c:if test="${Message!=null}">
            ${Message.name} 同学于 ${Message.date} 选课成功！
        </c:if>
    </div>
</form>
<div id="Foot">
    <div><span>合肥学院</span><span>©</span><span>HEFEI UNIVERSITY</span></div>
    <div><span>人工智能与大数据学院</span><span>·</span><span>办公室</span></div>
</div>

<script>
    //可视化
    $(function () {
        $.ajax({
            type: "get",
            url: "${pageContext.request.contextPath}/AdminStudent/findAllByMoreCondition.do",
            contentType: "application/json;charset=UTF-8",
            dataType: "json",
            success: function (data) {
                if (data == null || data == "") {
                    alert("数据回传空！");
                } else {
                    <%--alert("传回分页数据——pageNum：${pageInfo.pageNum}size:${pageInfo.pageSize}");--%>
                    //列表区域
                    var str = "";
                    $("#data_list").html(str);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(XMLHttpRequest.status);
                alert(XMLHttpRequest.readyState);
                alert(textStatus);
            }
        })
    })

    $(function () {
        //关于snoinput空间的动态ajax和动画效果
        $("input[name='sno']").keyup(function () {
            var snoValue = $("input[name='sno']").val();
            /*******************！这里需要引用外部文件！*************************/
            var pattern = /^((1\d{9})|(2\d{10}))$/;
            /*******************！这里需要引用外部文件！*************************/
            if (!pattern.test(snoValue)) {
                if (snoValue == null || snoValue.length == 0 || snoValue == "") {
                    $("#snoTips").hide();
                    var inputWidth = parseInt($("input[name='name']").css("width"));
                    $("#snoTips").fadeOut("fast", function () {
                        $("input[name='sno']").animate({
                            width: inputWidth,
                        }, "fast");
                    });
                } else {
                    //将show调整到animate width 后即可解决抖动问题，但因为很动感，没有解决这个BUG
                    $("#snoTips").show();
                    $("#snoTips").text("X");
                    var spanWidth = parseInt($("#snoTips").css("width"));
                    var inputWidth = parseInt($("input[name='name']").css("width"));
                    // $("input[name='sno']").css("width",reslutWidth);
                    $("input[name='sno']").animate({
                        width: inputWidth - spanWidth,
                    }, 200, function () {
                        // $("#snoTips").fadeToggle(50);
                    });
                    $("#snoTips").animate({color: "rgb(208,0,33)"}, 50);

                }

            } else {
                $.ajax({
                    type: "get",
                    url: "${pageContext.request.contextPath}/Student/isExistBySno.do",
                    contentType: "application/json;charset=UTF-8",
                    data: {
                        "sno": snoValue
                    },
                    dataType: "json",
                    success: function (data) {
                        $("#snoTips").hide();
                        $("#snoTips").text(data.status);
                        var spanWidth = parseInt($("#snoTips").css("width"));
                        var inputWidth = parseInt($("input[name='name']").css("width"));
                        // $("input[name='sno']").css("width",reslutWidth);
                        $("input[name='sno']").animate({
                            width: inputWidth - spanWidth,
                        }, 200, function () {
                            $("#snoTips").fadeToggle(70);
                        });
                        if (data.status == "老朋友！") {
                            $("#snoTips").animate({color: "rgb(210,105,30)"}, 70);
                            // $("#snoTips").animate({color:"chocolate"});
                        } else {
                            //$("#snoTips").animate({color:"cadetblue",});
                            $("#snoTips").animate({color: "rgb(95,158,160)"}, 50);
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert(XMLHttpRequest.status);
                        alert(XMLHttpRequest.readyState);
                        alert(textStatus);
                    }
                })
            }
        });
    })
</script>
</body>
</html>