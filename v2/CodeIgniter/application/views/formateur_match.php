<html>


<div>
<table border="1" cellspacing="1" border-color="#b6ff00">

 <style>
 table,table tr th, table tr td { border:1px solid #0094ff; }
      table { width: 200px; min-height: 25px; line-height: 25px; text-align: center; border-collapse: collapse; padding:2px;}   
  </style>
  
<thead>
<tr>
<td>match intitule</td>
<td>quiz intitule</td>
<td>match code</td>
<td>date debut</td>
<td>date fin</td>
</tr>
</thead>
 
 
 <tbody>
 <tr>
 <?php
 if($match_id != null ){
 
echo "<td>".$match_id->mth_intitule."</td>";
echo "<td>".$match_id->qz_intitule."</td>";
echo "<td>".$match_id->mth_code."</td>";
echo "<td>".$match_id->mth_date_debut."</td>";
echo "<td>".$match_id->mth_date_fin."</td>";


 }
?>
</tr>
 </tbody>
 
</table>
</div>








<div>
<head>
<style>
.question {
  background-color: tomato;
  color: white;
  border: 2px solid black;
  margin: 20px;
  padding: 20px;
}
</style>
</head>

<body>
<?php
	if ($match != null){
?>

<?php
		// Boucle de parcours de toutes les lignes du résultat obtenu
		echo "<form>";
				foreach($match as  $mth ){
					if (!isset($traite[$mth["ques_id"]])){
						$id=$mth["ques_id"];
						?>
						<div class="question">
						<?php
						echo "<h2>";
						echo $mth["ques_texte"];
						echo "</h2>";
						
					
						foreach($match as $m ){	
							
							if(strcmp($id,$m["ques_id"])==0){
							?>
									
							<?php
								echo "<p>".$m["rep_texte"]."</p>";
							}
							
						}
						echo "</div> ";

						$traite[$mth["ques_id"]]=1; 
					}
				}
				?>
			
<?php
	}
	
?> 
</body>
</div>


</html>

