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
	<?php
		$c = 1;
		$picnames = [ "T.png", "LIGHT.png", "TL.png", "HISTO2D_TL.png", "HISTO_T.png", "HISTO_LIGHT.png" ];
		for ($i = 0; $i<sizeof($picnames); $i++) {
			if ($c % 2 == 1) {
				echo '<img src="'.$picnames[$i].'?'.$stp.'" />&nbsp;&nbsp;&nbsp;'; 
			} else if ($c % 2 == 0) {
				echo '<img src="'.$picnames[$i].'?'.$stp.'" /><br />';
			}	
			$c++;
		}


	?>

	</body>

</html>
