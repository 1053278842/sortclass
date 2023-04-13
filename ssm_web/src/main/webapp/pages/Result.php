<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>无标题文档</title>
</head>
<?php
session_start();
$a = $_SESSION['sease'];
print_r($a);
$xh = $_POST['xh'];
echo("<hr>" . "结果为：" . "<br>");
if (isset($_POST['xh']) && $_POST['xh'] != "") {
    echo $a[$xh];
} elseif (isset($_POST['cj']) && $_POST['cj'] != "") {
    foreach ($a as $key => $value) {
        if ($a[$key] == $_POST['cj']) {
            echo($key);
        }
    }
} elseif (isset($_POST['delete']) && $_POST['delete'] != "") {
    unset($a[$_POST['delete']]);
    print_r($a);
    echo("删除成功");
    foreach ($a as $key => $value) {
        echo("<font color='#99ffff'>");
        echo("<br>");
        echo("学号:");
        echo($key);
        echo("成绩：");
        echo($value);
        echo("<br>");
        echo("</font>");
    }
}
?>
<body>
</body>
</html>
