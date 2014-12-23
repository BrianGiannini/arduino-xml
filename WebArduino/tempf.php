<!DOCTYPE html> 
<!--
Made By Brian Giannini
23/12/2014
-->
<head> 
	<meta charset="utf-8" />
	<title>Arduino sensors</title>
	<link rel="stylesheet" href="design.css" />
	<script type="text/javascript" src="https://www.google.com/jsapi?autoload={'modules':[{'name':'visualization','version':'1','packages':['corechart']}]}"></script>
	<script type="text/javascript">

      // Load the Visualization API and the piechart package.
    google.load('visualization', '1', {packages: ['corechart']});
    google.setOnLoadCallback(drawChart);

    function drawChart() {

    	//var rowTest= array(1;2, 2;3, 3;4 4;5);
      var data = new google.visualization.DataTable();
      data.addColumn('number', 'X');
      data.addColumn('number', '°C');

	<?php
	if(isset($_POST['submit'])){

	    $allowedExts = array("xml");  
	    $temp = explode(".", $_FILES["file"]["name"]);
		$extension = end($temp);	
		if (($_FILES["file"]["size"] < 200000000)
		&& in_array($extension, $allowedExts))
		{
			$nameFile=$_FILES["file"]["name"];
			 
				    move_uploaded_file($_FILES["file"]["tmp_name"], "" . $_FILES["file"]["name"]);

					$xmlDoc = simplexml_load_file($nameFile);
					$last = count($xmlDoc) - 1;
				
				
		}
		else
		{
			echo "Not a xml file !";
		}

			
		
		for ($i = 0; $i <= $last; $i++) {
	
	?>
		var time=<?php Print($xmlDoc->temperature[$i]->time); ?>;
	    var tempF=<?php Print($xmlDoc->temperature[$i]->valf); ?>;
     
    	data.addRows([[time, tempF]]);

    <?php
      }}
	?>

	var options = {
		width: 600,
		height: 300,
		hAxis: {
		  title: 'Time (sec)'
		},
		curveType: 'function',
		vAxis: {
		  title: 'Temperature'
		}
	};

	var chart = new google.visualization.LineChart(
	document.getElementById('display'));

	chart.draw(data, options);

    }
    </script>
</head>
<div id="bloc_page">
	<header>
		<h1><em>Arduino sensors</em> </h1>
	</header>
	<div>
		<p class="introduction">
			Here are display informations from the <span class="important">Arduino device. </span><br/>
			Work in progress... 
		</p>
   </div>
   <nav>
		<ul>
			<li><a href="tempc.php">Temperature °C</a></li>
			<li><a href="tempf.php">Temperature °F</a></li>
			<li><a href="">Luminosity</a></li>
		</ul>
	</nav>
	<section>
		<aside>
			<h1>Temperatures °C</h1>
		</aside>
			<article>
				<p>	
					<?php	
					if(isset($_POST['submit']))
						{
							if (($_FILES["file"]["size"] < 200000000)
							&& in_array($extension, $allowedExts))
							{
							echo ("Number of values : $last <br/>");
							echo ("Experiment duration : ". $xmlDoc->temperature[$i-1]->time . " sec");
							}
							else
							{
								echo "Not a xml file !";
							}
						}				
					?>

				</p>
				<form name="find" method="post"
						enctype="multipart/form-data">
						<input type="file" name="file" id="file"><br><br>
						<input type="submit" name="submit" value="Uploader le fichier xml">
				</form>	
				

			</article>
	</section>
</div>
<!--Div that will hold the graph-->
<div id="display"></div>


</html>