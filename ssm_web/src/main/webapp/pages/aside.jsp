<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
        <!-- Sidebar user panel -->
        <div class="user-panel">
            <div class="pull-left image">
                <img src="${pageContext.request.contextPath}/img/user2-160x160.jpg" class="img-circle" alt="User Image">
            </div>
            <div class="pull-left info">
                <p>刘xx</p>
                <a href="#"><i class="fa fa-circle text-success"></i> 在线</a>
            </div>
        </div>
        <!-- search form -->
        <!--<form action="#" method="get" class="sidebar-form">
    <div class="input-group">
        <input type="text" name="q" class="form-control" placeholder="搜索...">
        <span class="input-group-btn">
        <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
        </button>
      </span>
    </div>
    </form>-->
        <!-- /.search form -->


        <!-- sidebar menu: : style can be found in sidebar.less -->
        <ul class="sidebar-menu">
            <li class="header">菜单</li>

            <li id="admin-index"><a href="${pageContext.request.contextPath}/pages/main.jsp"><i
                    class="fa fa-dashboard"></i> <span>首页</span></a></li>

            <!-- 菜单 -->

            <li class="treeview">
                <a href="#">
                    <i class="fa fa-cogs"></i> <span>排班生成</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">

                    <li id="system-setting">
                        <a href="${pageContext.request.contextPath}/pages/setGenerateTableParam.jsp">
                            <i class="fa fa-circle-o"></i> 参数设置
                        </a>
                    </li>

                </ul>
            </li>

            <li class="treeview">
                <a href="#">
                    <i class="fa fa-book"></i> <span>基础数据</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">

                    <li id="travellog-manage">
                        <a href="${pageContext.request.contextPath}/pages/main.jsp">
                            <i class="fa fa-circle-o"></i> 志愿者管理
                        </a>
                    </li>

                    <li id="travellog-review">
                        <a href="${pageContext.request.contextPath}/pages/setTableViewParam.jsp">
                            <i class="fa fa-circle-o"></i> 课程管理
                        </a>
                    </li>


                </ul>
            </li>


            <li class="treeview">
                <a href="#">
                    <i class="fa fa-book"></i> <span>数据录入</span>
                    <span class="pull-right-container">
                    <i class="fa fa-angle-left pull-right"></i>
              </span>
                </a>
                <ul class="treeview-menu">

                    <li id="travellog-manage">
                        <a href="${pageContext.request.contextPath}/pages/InputPages/inputVolunteerInfo.jsp"
                           target="_blank">
                            <i class="fa fa-circle-o"></i> 志愿申请界面
                        </a>
                    </li>

                    <li id="system-setting">
                        <a href="${pageContext.request.contextPath}/pages/InputPages/inputClassCourseInfo.jsp">
                            <i class="fa fa-circle-o"></i> 班级课表录入
                        </a>
                    </li>

                    <li id="travellog-review">
                        <a href="">
                            <i class="fa fa-circle-o"></i> 维护中...
                        </a>
                    </li>

                </ul>
            </li>

            <li class="treeview">
                <a href="documentation.jsp">
                    <i class="fa fa-optin-monster"></i> <span>操作手册</span>
                </a>
            </li>
            <!-- 菜单 /-->
        </ul>
    </section>
    <!-- /.sidebar -->
</aside>

