<?php
$stp = time();
date_default_timezone_set('America/New_York');
?>
<html style="background-color: #000">
	<head>
		<meta http-equiv="Refresh" content="60">
		<title>Arduino data</title>
	</head>

	<body>
	<h3 style="color:#fff;">Melbourne, FL data; loaded <?php echo date('m.d.Y H:i:s'); ?></h3>
		<img src="T3.png?<?php echo $stp; ?>" /> &nbsp;&nbsp;&nbsp;
<img src="LIGHT.png?<?php echo $stp; ?>" />
	<br />
	<img src="RH.png?<?php echo $stp; ?>" /> &nbsp;&nbsp;&nbsp;
<img src="TL.png?<?php echo $stp; ?>" />
	<br />
	<img src="TH.png?<?php echo $stp; ?>" /> &nbsp;&nbsp;&nbsp;
<img src="LH.png?<?php echo $stp; ?>" />
	<br />

	</body>

</html>
