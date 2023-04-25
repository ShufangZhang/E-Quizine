
<!-- Masthead Heading-->
                <h1 class="masthead-heading text-uppercase mb-0">welcome</h1>
                <!-- Icon Divider-->
                <div class="divider-custom divider-light">
                    <div class="divider-custom-line"></div>
                    <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                    <div class="divider-custom-line"></div>
                </div>
				 <!-- Icon loading-->
				 <i class="fa fa-spinner fa-pulse fa-3x fa-fw"></i>
						<span class="sr-only">Loading...</span>
						
<?php echo validation_errors(); ?>
<?php echo form_open('accueil/afficher'); ?>
<label>joeur un match :</label><br>

<input type="text" name="pseudo" placeholder="votre pseudo!!" />
</br>
</br>

<input type="text" name="code" placeholder="entrez code match!!" />
</br>
</br>

<input type="submit" value="JOUER"/>
</form>


                <!-- actualites Section Heading-->
                <h2 class="page-section-heading text-center text-uppercase text-white">Actualités!</h2>
                <!-- Icon Divider-->
                <div class="divider-custom divider-light">
                    <div class="divider-custom-line"></div>
                    <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                    <div class="divider-custom-line"></div>
                </div>
				
				<!-- Icon hand-->
				<i class="fa fa-hand-lizard-o fa-3x" aria-hidden="true"></i> 
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
									  
									   <tbody>
									  <?php
				// Boucle de parcours de toutes les lignes du résultat obtenu
										if(isset($actu)) {
											if($nb->nombre!=0){
													foreach($actu as  $a ){
														echo "<tr>";
														echo "<th>".$a['actu_intitule']."</th>"	;
														echo "<th>".$a['actu_texte']."</th>";
														echo "<th>".$a['actu_date']."</th>";
														echo "<th>".$a['cpt_pseudo']."</th>";
														echo "</tr>	";
															
													}
											}
											else{
												echo "<h1>";
												echo $le_message;
												echo "</h1>";
											}
										}
										
													  
					
					?> 
									   </tbody>
				                 </table>
					
            </div>
        </section>

								 
								 
