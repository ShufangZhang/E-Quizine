<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Formateur extends CI_Controller {
	
			public function __construct()
			 {
					parent::__construct();
					$this->load->model('db_model');

					$this->load->helper('url_helper');
			 }
	 
	 public function modifier(){
			$this->load->helper('form');
			$this->load->library('form_validation');
			$pseudo = $this ->session->userdata('username');
					
		 $data['profil'] = $this->db_model->get_profil($pseudo);
			$data['prof'] = $this->db_model->get_profil($pseudo);
			$data['roleF']='F';
			$data['roleA']='A';
							
			$this->form_validation->set_rules('mdp', 'mdp', 'trim|required|
min_length[5]|max_length[12]',array('required'=>
'Veuillez saisir mot de passe !'));
			$this->form_validation->set_rules('mdp2', 'mdp2', 'trim|required|
min_length[5]|max_length[12]',array('required'=>
'Veuillez saisir confirmer mot de passe !'));
			
			//modifier mot de passe
			if ($this->form_validation->run() == FALSE){
					 $this->load->view('formateur_modifier',$data);
					 $this->load->view('templates/bas');
					 
					 
			}
			else{
				
				$new_mdp=$this->input->post('mdp');
				$new_mdp_confim=$this->input->post('mdp2');
				 
				if(strcmp($new_mdp,$new_mdp_confim)==0){//vérifier si les de mdp saisi sont pareil
							
					$this->db_model->modifier_mdp_formateur($pseudo,$new_mdp);
					$this->load->view('profil',$data);
					$this->load->view('mdp_succes');
				}
				else{
					$this->load->view('formateur_modifier',$data);
					$this->load->view('mdp_non_pareil');

					$this->load->view('templates/bas');
							 
				}				
			}

		 
	 }	
//lister tous les quiz et match de formateur	 
	 public function lister(){
		 
					 
		$pseudo = $this ->session->userdata('username');
		$data['match'] = $this->db_model->all_match($pseudo);

		$this->load->view('formateur_quiz',$data);
		$this->load->view('templates/bas');
		
	}
	//supprimer un match
	public function supprimer_match($match_id){
		
		$pseudo = $this ->session->userdata('username');
		$data['match'] = $this->db_model->all_match($pseudo);
		
		if($this->db_model->supprimer_joueur($match_id)){		
			if($this->db_model->supprimer_match($match_id)){
				$this->load->view('formateur_quiz',$data);
					$this->load->view('templates/bas');
			}
		}
	}
	//raz un match
	public function raz_match($match_id){
		$pseudo = $this ->session->userdata('username');
		$data['match'] = $this->db_model->all_match($pseudo);
		
		if($this->db_model->reset_match($match_id) and $this->db_model->supprimer_joueur($match_id)){
				$this->load->view('formateur_quiz',$data);
				$this->load->view('templates/bas');
			
		}
	}
	//activer un match
	public function activer($match_id){
		$pseudo = $this ->session->userdata('username');
		$data['match'] = $this->db_model->all_match($pseudo);

		if($this->db_model->activer_match($match_id)){
		$this->load->view('formateur_quiz',$data);
		$this->load->view('templates/bas');
		}
	}
	//désactiver un match
	public function desactiver($match_id){
		$pseudo = $this ->session->userdata('username');
		$data['match'] = $this->db_model->all_match($pseudo);

		if($this->db_model->desactiver_match($match_id)){
		$this->load->view('formateur_quiz',$data);
		$this->load->view('templates/bas');
		}
	}
	 //afficher les questions et les reponse des match
	public function match_info($code){
		$this->load->view('menu_formateur');

			if ($code==FALSE)
						{ $url=base_url(); header("Location:$url");}
			else{
						 $data['match'] = $this->db_model->get_match($code);
						 $data['match_id'] = $this->db_model->get_match_id($code);
						 

						 $this->load->view('formateur_match',$data);
						 

			}
			$this->load->view('templates/bas');
	}
	

}
?>