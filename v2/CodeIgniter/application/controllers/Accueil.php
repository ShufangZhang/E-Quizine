<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Accueil extends CI_Controller {
	public function __construct()
	 {
			parent::__construct();
			$this->load->model('db_model');

			$this->load->helper('url');
	 }
	 
	
	
		public function afficher(){
			$this->load->helper('form');
			$this->load->library('form_validation');
			$this->form_validation->set_rules('code', 'code', 'required',array('required'=>
'Veuillez saisir code de match !'));
			$this->form_validation->set_rules('pseudo', 'pseudo', 'required',array('required'=>
'Veuillez saisir votre pseudo !'));
			$data['titre'] = "actualite";
			$data['actu'] = $this->db_model->get_all_actualite();
			$data['nb'] = $this->db_model->get_nb_actualite();
			$data['le_message']="'Aucune actualité pour l'instant !'";
			
		//Chargement de la view haut.php
		$this->load->view('templates/haut');
		
		//chargement de la view des matchs dont le code saisi et pseudo choisi
			 if ($this->form_validation->run() == FALSE){
					 $this->load->view('page_accueil',$data);
			 }
			 else{
					 $code = $this->input->post('code');
					 $pseudo=$this->input->post('pseudo');
					 $data['match'] = $this->db_model->get_match($code);
					$data['match_id'] = $this->db_model->get_match_id($code);
					 $data['nombre']=$this->db_model->verif_pseudo($pseudo,$code);
					 $meme_pseudo=$data['nombre']->nb;
					 
							//si le code de match est bon
								if ($this->db_model->join_match($code)){
									//si le pseudo saiai pour ce match  n'existe pas encore
									if($meme_pseudo == 0){ 
												//si le quiz est activé
												if($this->db_model->quiz_etat($code)){	
													//si le match activé
													if($this->db_model->match_etat($code)){
														//ajouter un nouvau joueur dans phpadmin
														$this->db_model->ajout_joueur($pseudo,$code);
														//afficher les donées de match
														 $this->load->view('match_afficher',$data);
													}
													else{
														//afficher match désactivé et redirect vers la page accueil si match désactive
														$this->load->view('match_desactive');
														$this->load->view('page_accueil',$data);
													}
												}
												else{
													//afficher quiz désactivé et redirect le page accueil si le quiz est désactivé
													$this->load->view('quiz_desactive');
													$this->load->view('page_accueil',$data);
												}
										
									}
									else{
									
									//pseudo déja existe, afficher l'erro et rester sur la page connecter (page_accueil)
									$this->load->view('jrs_pseudo_repete');
									$this->load->view('page_accueil',$data);
									}
								}
								else{
									//si le code n'est pas bon, rester sur la page connecter
											$this->load->view('code_match_erro');

									 		$this->load->view('page_accueil',$data);


								}
							
						
					
						
					
			}
			
			
			
		$this->load->view('templates/bas');

	}
}
?>


