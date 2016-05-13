<?php

include("config.php");

$url = $_GET["url"];
$info = $_GET["info"];

$conn = mysqli_connect("localhost", $db_id, $db_pwd, $db_name);
if(!$conn){
	die("DB connection failed: " . mysql_connect_error());
}

mysqli_set_charset($conn, "utf8");

$query = "insert into scrapbook (url, info) values ('$url', '$info')";
if(mysqli_query($conn, $query)){
	echo "success";
}else{
	die("insert failed" . mysqli_error());
}

mysqli_close($conn);
?>
