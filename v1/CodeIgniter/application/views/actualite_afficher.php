<br />

<h1><?php echo $titre;?></h1>
<br />
<table class="table table-bordered">
<thead>
									  <tr>
										<th>titre</th>
										<th>texte</th>
										<th>publication</th>
										<th>auteur</th>
									  </tr>
									  </thead>
<body>
<?php
if(isset($actu)) {
		if($nb->nombre==0){
		echo "<tr>";
		echo "<td>"; echo $actu->actu_intitule; echo "</td>";
		echo "<td>"; echo $actu->actu_texte; echo "</td>";

		echo "<td>"; echo $actu->actu_date; echo "</td>";
		echo "<td>"; echo $actu->cpt_pseudo; echo "</td>";
		echo "</tr>";
		
			
		}
		else{
					echo "<h1>";

			echo $le_message;
					echo "</h1>";

		}
}

?>
</body>
</table>

									
										
									  