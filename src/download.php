<?php

$conn = mysqli_connect("localhost", "your_mysql_id", "your_mysql_pwd", "your_db_name");
if(!$conn){
	die("DB connection failed: " . mysqli_connect_error());
}

mysqli_set_charset($conn, "utf8");

$query = "select url, info from scrapbook";
$result = mysqli_query($conn, $query);
if(mysqli_num_rows($result) > 0){
	while($row = mysqli_fetch_assoc($result)){
		echo $row['url'] . "\n" . $row['info'] . "\n";
	}
}else{
	die("select failed" . mysqli_error());
}

mysqli_close($conn);
?>