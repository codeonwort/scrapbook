<?php

include("config.php");

$row = $_GET["row"];

$conn = mysqli_connect("localhost", $db_id, $db_pwd, $db_name);
if(!$conn){
	die("DB connection failed: " . mysql_connect_error());
}

mysqli_set_charset($conn, "utf8");

$query = "delete from scrapbook where id='$row'";
if(mysqli_query($conn, $query)){
	echo "success";
}else{
	die("remove failed" . mysqli_error());
}

mysqli_close($conn);
?>
