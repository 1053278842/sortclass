<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>AdminLTE 2 | Documentation</title>
    <meta content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.6 -->
    <!-- Font Awesome -->
    <!-- Ionicons -->
    <!-- Theme style -->
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <link rel="stylesheet" href="../plugins/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="..//plugins/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="../plugins/ionicons/css/ionicons.min.css">
    <link rel="stylesheet" href="../plugins/adminLTE/css/AdminLTE.css">
    <link rel="stylesheet" href="../plugins/adminLTE/css/skins/_all-skins.min.css">
    <link rel="stylesheet" href="../css/style.css">
</head>

<body class="skin-blue fixed" data-spy="scroll" data-target="#scrollspy">
<div class="wrapper">
    <!-- 页面头部 -->
    <jsp:include page="header.jsp"></jsp:include>
    <!-- 页面头部 /-->

    <!-- 导航侧栏 -->
    <jsp:include page="aside.jsp"></jsp:include>
    <!-- 导航侧栏 /-->
    <!-- Left side column. contains the logo and sidebar -->

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <h1>
                葵花宝典
                <small>Version 2.3</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
                <li class="active">Documentation</li>
            </ol>
        </div>

        <!-- Main content -->
        <div class="content body">

            <section id="introduction">
                <h2 class="page-header"><a href="#introduction">简介</a></h2>
                <p class="lead">
                <p>葵花宝典</p>
                这是一款分布式的信息管理系统，及信息录入、数据管理、数据筛选、一键排课的信息管理系统。“葵花宝典”可以理解为他的操作手册！
                本文档将指导您初入系统并探索的各种组件。
                </p>
            </section>
            <!-- /#introduction -->


            <!-- ============================================================= -->

            <section id="download">
                <h2 class="page-header"><a href="#download">首页</a></h2>
                <p class="lead">
                    首页是您每次打开本系统跳转到的界面，它默认指向志愿者数据管理页面。
                </p>
            </section>

            <section id="dependencies">
                <h2 class="page-header"><a href="#dependencies">排班生成</a></h2>
                <p class="lead">顾名思义，该模块生成最终排班表格，其参数如下</p>
                <ul class="bring-up">
                    <li><a href="#">week: 需要检索出的周次，例如我需要第十周的课程表排班情况，那么就输入“10”</a></li>
                    <li><a href="#">Frequency: 最多出勤频次X，李玲同学本周最多参与X次查课，比如（Mon1、Mon5、Fri7...)这X个课次.</a></li>
                    <li><a href="#">Number Of One Frequency: 单次出勤最多查X节课,比如Mon1课次查（高数、语文、英语...）这X个节课</a></li>
                    <li><a href="#">Volunteer Data Range:
                        志愿者检索日期范围，例如09/01公开了志愿者申请界面，今天是09/05.那么将日期划定为09/01-09/06即可检索到这期间所有的志愿登录信息。(选择09/06是因为09/05只能界定都5号的0:00分)</a>
                    </li>
                    <li><a href="#">Week Section Range :选择哪个就展示对应的星期，例如本周因调休放假，周三全体放假。那么可以将周三x去，以便系统排班。</a></li>
                </ul>
                <p class="lead">submit点击生成按钮后</p>
                <ul class="bring-up">
                    <li><a href="#">导出Excel: 可以导出该页面的EXCEL文档</a></li>
                    <li><a href="#">确定为最终表格后请点我！:只有确定使用该表，并执行该表格排班的时候才点击。点击后会对表内的志愿者加权，降低他们下次被排到的概率，公平公正！</a></li>
                </ul>
            </section>


            <hr>
            <!-- ============================================================= -->
            <br>
            <section id="advice">
                <h2 class="page-header"><a href="#advice">基础数据</a></h2>
                <p class="lead">
                    对志愿者、班级进行数据管理
                </p>
                <p class="lead">
                    1、志愿者管理
                </p>

                <ul>
                    <li>新建按钮：点击后转到志愿者录入信息界面</li>
                    <li>删除按钮：会将列表数据中打钩√的数据删除</li>
                    <li>重置按钮：重置搜索框、重置所有的排序条件，回到原始状态</li>
                    <li>搜索框： 可以模糊搜索信息，比如学号、姓名、班级、志愿节次等，注意：重置可以清楚模糊搜索的状态！</li>
                    <li>+1: 可以将该记录的出勤次数+1，降低下次排到它的概率</li>
                    <li>-1: 可以将该记录的出勤次数-1，提高下次排到它的概率</li>
                    <li>=0: 情况该记录的出勤次数。</li>
                </ul>
                <br>
                <p class="lead">
                    2、课程管理
                </p>

                <ul>
                    <li>week: 查询的周，不填时默认是全学期</li>
                    <li>Class Name： 班级名称，请在下拉框中选择。</li>
                    <li>ps:提交后与生成最终表格的页面一样，只是没有学生，只有该班级对应周次的课程情况。可用于核对自动录入的课程是否准确，或查看具体课程情况。</li>
                    <li>不要点击“确定为最终表格后请点我！”按钮，会发生报错！</li>
                </ul>
            </section>


            <!-- ============================================================= -->
            <!-- ============================================================= -->
            <hr>
            <br>
            <section id="advice">
                <h2 class="page-header"><a href="#advice">数据录入</a></h2>
                <p class="lead">
                    对志愿者、班级的数据进行录入
                </p>
                <p class="lead">
                    1、志愿者申请界面
                </p>

                <ul>
                    <li>可以实时判断学号是否输入准确，会给出反馈是否是新/老志愿者。</li>
                    <li>只要学号正确，可以覆盖先前录入的数据，只更新其学号外的所有数据。</li>
                    <li>旧网址可以使用，但不推荐。建议使用本系统新的志愿者申请界面
                        （<a href="http://onemorechance.xyz/ssm_web_warOutput/pages/InputPages/inputVolunteerInfo.jsp">
                            http://onemorechance.xyz/ssm_web_warOutput/pages/InputPages/inputVolunteerInfo.jsp）</a></li>
                </ul>
                <br>
                <p class="lead">
                    2、班级课程录入
                </p>

                <ul>
                    <li>Class Size :即课表班级的人数，该数据会在最终生成的课表中显示！</li>
                    <li>File input ：课表文件，一般为学校官网上下载下来的文件。</li>
                    <li>提交后可以在"基础数据-课程管理"中查看效果是否匹配，如果不匹配请联系数据库管理员修改正则表达式！</li>
                    <li>如果某课程发生变动，有必要调整时，只需要将修改过后的课表（一定要按照格式，对应周次节次）重新提交进系统即可。</li>
                    <li>注意：课表录入系统暂时没有清库功能，如果到使用都下一学期，需要联系数据库管理员进行清库操作，否则生成的最终表格会有多余的数据。</li>
                </ul>
            </section>


            <!-- ============================================================= -->
            <!-- ============================================================= -->
            <hr>
            <br>
            <section id="advice">
                <h2 class="page-header"><a href="#advice">其他</a></h2>
                <p class="lead">

                </p>
                <p class="lead">
                    其他
                </p>

                <ul>
                    <li>服务器管理人员QQ:1053278842</a></li>
                </ul>
                <br>
            </section>


            <!-- ============================================================= -->
            <hr>
            <br>
            <section id="advice">
                <h2 class="page-header"><a href="#advice">日常操作顺序</a></h2>
                <p class="lead">
                    正常排课
                </p>
                <ul>
                    <li>1、公式志愿者申请界面<a
                            href="http://onemorechance.xyz/ssm_web_warOutput/pages/InputPages/inputVolunteerInfo.jsp">
                        http://onemorechance.xyz/ssm_web_warOutput/pages/InputPages/inputVolunteerInfo.jsp）</a></li>
                    <li>2、在排班生成-参数设置中，设置好对应的参数</li>
                    <li>3、提交参数，根据排课效果确定是否需要调整参数（频次，单频次最多出勤次数）</li>
                    <li>4、确定最终效果的表格，点击“确定为最终表格后请点击我”，增加表内人员权重</li>
                </ul>
                <br>

                <p class="lead">
                    有请假情况时
                </p>
                <ul>
                    <li>1、在基础数据-志愿者管理界面模糊搜索请假人信息</a></li>
                    <li>2、对其权重减少，减少次数=最终表格内该志愿者名字出现的次数</li>
                </ul>
                <br>

                <p class="lead">
                    节假日时
                </p>
                <ul>
                    <li>1、在排班生成-参数设置中，设置好对应的参数</a></li>
                    <li>2、将不上课的周次添加/删除。</li>
                    <li>3、提交并生成。</li>
                </ul>
                <br>

                <p class="lead">
                    下一学期开始时
                </p>
                <ul>
                    <li>1、联系数据库管理员/服务器管理员</a></li>
                    <li>2、要求删除课程数据</li>
                    <li>3、在数据录入-班级课表录入 中对新一学期的课程文件进行提交</li>
                </ul>
                <br>
            </section>

        </div>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->

    <footer class="main-footer">
        <div class="pull-right hidden-xs">
            <b>Version</b> 2.0.0
        </div>
        <strong>BGS &copy; 2021-2021 <a href="#">人工智能与大数据学院</a>.</strong> All rights reserved.
    </footer>

    <!-- Control Sidebar -->
    <aside class="control-sidebar control-sidebar-dark">
        <!-- Create the tabs -->
        <div class="pad">
            This is an example of the control sidebar.
        </div>
    </aside>
    <!-- /.control-sidebar -->
    <!-- Add the sidebar's background. This div must be placed
       immediately after the control sidebar -->
    <div class="control-sidebar-bg"></div>

</div>
<!-- ./wrapper -->

<!-- jQuery 2.2.3 -->
<!-- Bootstrap 3.3.6 -->
<!-- FastClick -->
<!-- AdminLTE App -->
<!-- SlimScroll 1.3.0 -->
<script src="../plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="../plugins/bootstrap/js/bootstrap.min.js"></script>
<script src="../plugins/fastclick/fastclick.min.js"></script>
<script src="../plugins/adminLTE/js/app.min.js"></script>
<script src="../plugins/slimScroll/jquery.slimscroll.min.js"></script>
</body>

</html>