<?php

include("config.php");

$conn = mysqli_connect("localhost", $db_id, $db_pwd, $db_name);
if(!$conn){
	die("DB connection failed: " . mysqli_connect_error());
}

mysqli_set_charset($conn, "utf8");

$query = "select id, url, info from scrapbook";
$result = mysqli_query($conn, $query);
if(mysqli_num_rows($result) > 0){
	while($row = mysqli_fetch_assoc($result)){
		echo $row['id'] . "\n" . $row['url'] . "\n" . $row['info'] . "\n";
	}
}else{
	die("select failed" . mysqli_error());
}

mysqli_close($conn);
?>
