<html>

<style>
.nowrap{white-space:nowrap;}
</style>

<div>
<table class="table table-bordered">
 <thead>
 <tr>
 
 <h1>quiz intitule</h1>


 </tr>
 </thead>
 
 <tbody>
 <tr>
 <?php
 if($match_id != null ){

echo "<h2>".$match_id->qz_intitule."</h2>";

 }
?>
</tr>
 </tbody>
</table>
</div>

<div>
<?php
	if ($match != null){
?>
<?php
		// Boucle de parcours de toutes les lignes du résultat obtenu
				foreach($match as  $mth ){
					if (!isset($traite[$mth["ques_id"]])){
						$id=$mth["ques_id"];

						echo "<p >";
						echo $mth["ques_texte"];
						echo "</p>"	;

						foreach($match as $m ){	
							
							if(strcmp($id,$m["ques_id"])==0){
								echo "<p>".$m["rep_texte"]."</p>";
							}
							
						}
						$traite[$mth["ques_id"]]=1; 
						
					}
				}
			
			

	}
	else {
		echo "<br />";
		echo "Aucun résultat !";
	}
?> 
</div>


</html>

else{
											 
										}