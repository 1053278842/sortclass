<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="content-wrapper" style="overflow-x: auto">

    <!-- 内容头部 -->
    <section class="content-header">
        <h1>
            志愿者列表
            <small>Volunteer</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> 首页</a></li>
            <li><a href="#">维护中！</a></li>
            <li class="active">志愿者列表</li>
        </ol>
    </section>
    <!-- 内容头部 /-->

    <!-- 正文区域 -->
    <section class="content" style="min-width: 1400px">

        <!-- .box-body -->
        <div class="box box-primary">
            <div class="box-header with-border">
                <h3 class="box-title">Volunteer List</h3>
            </div>

            <div class="box-body">

                <!-- 数据表格 -->
                <div class="table-box">

                    <!--工具栏-->
                    <div class="pull-left">
                        <div class="form-group form-inline">
                            <div class="btn-group">
                                <button type="button" class="btn btn-default" title="新建" id="btn_add"><i
                                        class="fa fa-file-o"></i> 新建
                                </button>
                                <button type="button" class="btn btn-default" title="删除" id="btn_delete"><i
                                        class="fa fa-trash-o"></i> 删除
                                </button>
                                <button type="button" class="btn btn-default" title="重置" id="btn_refresh"><i
                                        class="fa fa-refresh"></i> 重置
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="box-tools pull-right">
                        <div class="has-feedback">
                            <input type="text" id="volunteer_search" class="form-control input-sm" placeholder="搜索">
                            <span id="volunteer_search_button"
                                  class="glyphicon glyphicon-search form-control-feedback"></span>
                        </div>
                    </div>
                    <!--工具栏/-->

                    <!--数据列表-->
                    <table id="dataList" class="table table-bordered table-striped table-hover dataTable">
                        <thead>
                        <tr>
                            <th class="" style="padding-right:0px;width: 3%;">
                                <input id="selall" type="checkbox" class="icheckbox_square-blue">
                            </th>
                            <th id="volunteer_id" onclick="ChangeSortingDirection(this.id,'id')" style="width: 5%;"
                                class="sorting_desc_disabled sorting_desc">ID
                            </th>
                            <th id="volunteer_sno" onclick="ChangeSortingDirection(this.id,'sno')" style="width: 9%;"
                                class="sorting_desc_disabled sorting_desc">学生学号
                            </th>
                            <th id="volunteer_name" onclick="ChangeSortingDirection(this.id,'name')" style="width: 6%;"
                                class="sorting_desc_disabled sorting_desc">学生姓名
                            </th>
                            <th id="volunteer_classes" onclick="ChangeSortingDirection(this.id,'classes')"
                                style="width: 18%;"
                                class="sorting_desc_disabled sorting_desc">所属班级
                            </th>
                            <th id="volunteer_date" onclick="ChangeSortingDirection(this.id,'date')"
                                class="sorting_desc">志愿时间（最近）
                            </th>
                            <th id="volunteer_freeClasses" style="width: 17%;"
                                class="sorting_desc_disabled sorting_desc">志愿节次（最近）
                            </th>
                            <th id="volunteer_times" onclick="ChangeSortingDirection(this.id,'times')"
                                class="text-center sorting_desc_disabled sorting_desc">出勤次数
                            </th>
                            <th id="volunteer_edit" style="width: 7.5%;text-align: center;padding-right: 0px;"
                                class="text-center">操作
                            </th>
                        </tr>
                        </thead>
                        <tbody id="data_list">

                        </tbody>
                    </table>
                    <!--数据列表/-->


                </div>
                <!-- 数据表格 /-->


            </div>
            <!-- /.box-body -->

            <!-- .box-footer-->
            <div class="box-footer">
                <div class="pull-left">
                    <div class="form-group form-inline">
                        <span hidden id="pageIntr_Field"></span><span hidden id="pageIntr_SortDire"></span><span hidden
                                                                                                                 id="pageIntr_likeValue"></span>
                        当前第 <span id="pageIntr_Num"></span> 页,单页 <span id="pageIntr_Size"></span> 条数据。<br>
                        总共 <span id="pageIntr_Pages"></span> 页，共 <span id="pageIntr_total"></span> 条数据。 每页
                        <select class="form-control" id="pageSizeSelect" onchange="ChangePageSize()">
                            <option value=1>1</option>
                            <option value=5>5</option>
                            <option value=10 selected>10</option>
                            <option value=15>15</option>
                            <option value=20>20</option>
                        </select> 条
                    </div>
                </div>

                <div class="box-tools pull-right">
                    <ul class="pagination">

                    </ul>
                </div>

            </div>
            <!-- /.box-footer-->


        </div>

    </section>
    <!-- 正文区域 /-->

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
<script type="text/javascript">
    //
    var enterKeyMark = false;

    $(document).ready(function () {
        refreshPage();
    });

    function refreshPage(field, sortDire, pageNum, pageSize, likeValue) {
        if (field == null) {
            field = "date";
        }
        if (sortDire == null) {
            sortDire = "desc";
        }
        if (pageNum == null) {
            pageNum = 1;
        }
        pageSize = $("#pageSizeSelect").val();//默认10
        //模糊搜索才会用到
        if (likeValue == null || likeValue == "") {
            likeValue = null;
            $("#volunteer_search").val("");
        }
        // alert("发送后——字段："+field+"升降序"+sortDire+"当前页："+pageNum+"size:"+pageSize);
        $.ajax(
            {
                type: "get",
                url: "${pageContext.request.contextPath}/AdminStudent/findAllByMoreCondition.do",
                contentType: "application/json;charset=UTF-8",
                data: {
                    "field": field,
                    "sortDire": sortDire,
                    "pageNum": pageNum,
                    "pageSize": pageSize,
                    "likeValue": likeValue,
                },
                dataType: "json",
                success: function (data) {
                    if (data == null || data == "") {
                        alert("数据回传空！");
                    } else {
                        <%--alert("传回分页数据——pageNum：${pageInfo.pageNum}size:${pageInfo.pageSize}");--%>
                        //列表区域
                        var str = "";
                        for (var i = 0; i < data.list.length; i++) {
                            str += "<tr>" +
                                '<td><input name="ids" type="checkbox" value="' + data.list[i].id + '"></td>' +
                                '<td>' + data.list[i].id + '</td>' +
                                '<td>' + data.list[i].sno + '</td>' +
                                '<td>' + data.list[i].name + '</td>' +
                                '<td>' + data.list[i].classes + '</td>' +
                                '<td>' + data.list[i].date + '</td>' +
                                '<td>' + data.list[i].freeClasses + '</td>' +
                                '<td>' + data.list[i].times + '</td>' +
                                '<td class="text-center">' +
                                '<button onclick="  addTimes(' + data.list[i].id + ')" type="button" class="btn bg-olive btn-xs">+1</button>' +
                                '<button onclick="minusTimes(' + data.list[i].id + ')" type="button" class="btn btn-danger btn-xs">-1</button>' +
                                '<button onclick="clearTimes(' + data.list[i].id + ')" type="button" class="btn btn-warning btn-xs">=0</button>' +
                                '</td>' +
                                "</tr>"
                        }
                        $("#data_list").html(str);

                        //分页区域 总条数区
                        $("#pageIntr_Num").html(data.pageNum);
                        $("#pageIntr_Size").html(data.pageSize);
                        $("#pageIntr_Pages").html(data.pages);
                        $("#pageIntr_total").html(data.total);
                        //隐藏参数
                        $("#pageIntr_Field").html(field);
                        $("#pageIntr_SortDire").html(sortDire);

                        //分页区域 按钮区
                        var str = "";
                        var dotBeforFlag = false;
                        var dotAfterFlag = false;
                        str = "<li><a href='#' onclick='refreshPage(\"" + field + "\",\"" + sortDire + "\"," + 1 + "," + data.pageSize + ",\"" + likeValue + "\")'aria-label='Previous'>首页</a></li>"
                            + "<li><a href='#' onclick='refreshPage(\"" + field + "\",\"" + sortDire + "\"," + (data.pageNum - 1) + "," + data.pageSize + ",\"" + likeValue + "\")'>上一页</a></li>"
                        for (var i = 1; i <= data.pages; i++) {
                            if (i == 1 || i == data.pages || i <= data.pageNum + 2 && i >= data.pageNum - 2) {
                                str += "<li><a href='#' onclick='refreshPage(\"" + field + "\",\"" + sortDire + "\"," + i + "," + data.pageSize + ",\"" + likeValue + "\")'>" + i + "</a></li>";
                            } else if (i > data.pageNum + 2 && !dotAfterFlag) {
                                str += "<li><a href='#'>...</a></li>";
                                dotAfterFlag = true;
                            } else if (i < data.pageNum - 2 && !dotBeforFlag) {
                                str += "<li><a href='#'>...</a></li>";
                                dotBeforFlag = true;
                            }
                        }
                        str += "<li><a href='#' onclick='refreshPage(\"" + field + "\",\"" + sortDire + "\"," + (data.pageNum + 1) + "," + data.pageSize + ",\"" + likeValue + "\")' aria-label='Next'>下一页</a></li>";
                        str += "<li><a href='#' onclick='refreshPage(\"" + field + "\",\"" + sortDire + "\"," + data.pages + "," + $("#pageIntr_Size").text() + ",\"" + likeValue + "\")' aria-label='Next'>尾页</a></li>";
                        $(".pagination").html(str);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    // alert(XMLHttpRequest.status);
                    // alert(XMLHttpRequest.readyState);
                    // alert(textStatus);
                }
            }
        )
    }

    function ChangeSortingDirection(tableId, field) {
        var currentClass = $("#" + tableId).attr("class");
        var sortDire;
        var pageNum = "";
        var pageSize = "";
        $("#dataList tr th").attr("class", "sorting_desc_disabled:not(" + currentClass + ")");
        if (currentClass == "sorting_desc") {
            $("#" + tableId).attr("class", "sorting_asc");
            sortDire = "asc";
        } else {
            $("#" + tableId).attr("class", "sorting_desc");
            sortDire = "desc";
        }
        // alert("字段："+field+"升降序"+sortDire+"当前页："+pageNum+"size:"+pageSize);
        refreshPage(field, sortDire, pageNum, pageSize, $("#volunteer_search").val());
    }

    function ChangePageSize() {
        refreshPage($("#pageIntr_Field:hidden").text(), $("#pageIntr_SortDire:hidden").text(), $("#pageIntr_Num").text(), $("#pageSizeSelect").text(), $("#volunteer_search").val());
    }

    $(document).ready(function () {
        // 选择框
        $(".select2").select2();

        // WYSIHTML5编辑器
        $(".textarea").wysihtml5({
            locale: 'zh-CN'
        });
    });


    // 设置激活菜单
    function setSidebarActive(tagUri) {
        var liObj = $("#" + tagUri);
        if (liObj.length > 0) {
            liObj.parent().parent().addClass("active");
            liObj.addClass("active");
        }
    }


    $(document).ready(function () {

        // 激活导航位置
        setSidebarActive("admin-datalist");

        // 列表按钮
        $("#dataList td input[type='checkbox']").iCheck({
            checkboxClass: 'icheckbox_square-blue',
            increaseArea: '20%'
        });
        // 全选操作
        $("#selall").click(function () {
            var clicks = $(this).is(':checked');
            if (!clicks) {
                $("#dataList td input[type='checkbox']").iCheck("uncheck");
            } else {
                $("#dataList td input[type='checkbox']").iCheck("check");
            }
            $(this).data("clicks", !clicks);
        });
    });

    //搜索
    $(function () {
        $("#volunteer_search_button").attr("onclick", "null");
        $("#volunteer_search_button").click(function () {
            //搜索
            refreshPage($("#pageIntr_Field:hidden").text(), $("#pageIntr_SortDire:hidden").text(), $("#pageIntr_Num").text(), $("#pageSizeSelect").text(), $("#volunteer_search").val());
        })
        $("body").keydown(function () {
            if (event.keyCode == 13) {
                enterKeyMark = true;
                $("#volunteer_search_button").click();
            }
        });
        $("#volunteer_search").blur(function () {
            if (!enterKeyMark) {
                $("#volunteer_search").val("");
            }
        });
    })

    //增加Times次数
    function addTimes(id) {
        var statu = confirm("是否要增加出勤次数?");
        if (!statu) {
            return false;
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/AdminStudent/updateAddTimesById.do",
            type: "post",
            data: {
                "id": id
            },
            async: false,//同步
            success: function () {

            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("删除操作，后台出错！");
                alert(XMLHttpRequest.status);
                alert(XMLHttpRequest.readyState);
                alert(textStatus);
            }
        })
        //同changePageSize()函数
        refreshPage($("#pageIntr_Field:hidden").text(), $("#pageIntr_SortDire:hidden").text(), $("#pageIntr_Num").text(), $("#pageSizeSelect").text(), $("#volunteer_search").val());
    }

    //减少Times次数
    function minusTimes(id) {
        var statu = confirm("是否要减少出勤次数?");
        if (!statu) {
            return false;
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/AdminStudent/updateMinusTimesById.do",
            type: "post",
            data: {
                "id": id
            },
            async: false,//同步
            success: function () {

            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("删除操作，后台出错！");
                alert(XMLHttpRequest.status);
                alert(XMLHttpRequest.readyState);
                alert(textStatus);
            }
        })
        //同changePageSize()函数
        refreshPage($("#pageIntr_Field:hidden").text(), $("#pageIntr_SortDire:hidden").text(), $("#pageIntr_Num").text(), $("#pageSizeSelect").text(), $("#volunteer_search").val());
    }

    //清空Times次数
    function clearTimes(id) {
        var statu = confirm("是否要清空出勤次数?");
        if (!statu) {
            return false;
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/AdminStudent/updateClearTimesById.do",
            type: "post",
            data: {
                "id": id
            },
            async: false,//同步
            success: function () {

            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("删除操作，后台出错！");
                alert(XMLHttpRequest.status);
                alert(XMLHttpRequest.readyState);
                alert(textStatus);
            }
        })
        //同changePageSize()函数
        refreshPage($("#pageIntr_Field:hidden").text(), $("#pageIntr_SortDire:hidden").text(), $("#pageIntr_Num").text(), $("#pageSizeSelect").text(), $("#volunteer_search").val());
    }

    //三个按钮 添加 刷新 删除
    $(document).ready(function () {
        $("#btn_add").click(function () {
            window.open("${pageContext.request.contextPath}/pages/InputPages/inputVolunteerInfo.jsp");
        })
        $("#btn_refresh").click(function () {
            enterKeyMark = false;
            $("#pageSizeSelect").val("10");
            refreshPage();
        });
        $("#btn_delete").click(function () {
            var statu = confirm("确认删除？");
            if (!statu) {
                return false;
            }
            $("input[name='ids']:checked").each(function () {
                $.ajax({
                    url: "${pageContext.request.contextPath}/AdminStudent/deleteById.do",
                    type: "post",
                    data: {
                        "id": $(this).val()
                    },
                    async: false,//同步
                    success: function () {

                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("删除操作，后台出错！");
                        alert(XMLHttpRequest.status);
                        alert(XMLHttpRequest.readyState);
                        alert(textStatus);
                    }
                })
            });
            //同changePageSize()函数
            refreshPage($("#pageIntr_Field:hidden").text(), $("#pageIntr_SortDire:hidden").text(), $("#pageIntr_Num").text(), $("#pageSizeSelect").text(), $("#volunteer_search").val());
        });
        //添加按钮将会跳转到志愿录入界面！
    });

</script>