<?php
$array[] = 0;
for ($i = 0; $i < 10; $i++) {
    $str = "s" . $i;
    $array[$i] = $_POST[$str];
}
print_r($array);
?>
