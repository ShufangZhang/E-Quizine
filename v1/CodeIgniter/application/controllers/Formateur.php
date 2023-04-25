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
			$data['roleF']='F';
			$data['roleA']='A';
			
			$this->form_validation->set_rules('mdp', 'mdp', 'required');
			$this->form_validation->set_rules('mdp2', 'mdp2', 'required');
			
			//modifier mot de passe
			if ($this->form_validation->run() == FALSE){
					 $this->load->view('formateur_modifier',$data);
					 $this->load->view('templates/bas');
					 
					 
			}
			else{
				
				$new_mdp=$this->input->post('mdp');
				$new_mdp_confim=$this->input->post('mdp2');
				 
						if(strcmp($new_mdp,$new_mdp_confim)==0){
							$this->db_model->modifier_mdp_formateur($pseudo,$new_mdp);
													 
								  
									if(strcmp($data['profil']->plf_role,$data['roleF'])==0){						 

										 
										 $this->load->view('menu_formateur',$data);

										 $this->load->view('templates/bas');

									}
									else {
										if(strcmp($data['profil']->plf_role,$data['roleA'])==0){

										 $this->load->view('menu_administrateur',$data);

										$this->load->view('templates/bas');
										}
									 

									}
							$this->load->view('mdp_succes');

						}
						else{

							 $this->load->view('formateur_modifier',$data);
							$this->load->view('mdp_non_pareil');

							 $this->load->view('templates/bas');
							 
						}
				
				
			}

		 
	 }	 
}
?>