<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Compte extends CI_Controller {


		 public function __construct()
		 {
		 parent::__construct();
		 $this->load->model('db_model');
		 $this->load->helper('url_helper');
		 }
//lister tous les comptes
		 public function lister()
		 {
		 $data['titre'] = 'all compte :';
		 $data['info'] = $this->db_model->get_all_compte();
		 $this->load->view('compte_liste',$data);
		 }

//connecter un compte
		 
		 public function connecter(){
			$this->load->helper('form');
			$this->load->library('form_validation');
			$this->form_validation->set_rules('pseudo', 'pseudo', 'required',array('required'=>
'Veuillez saisir votre pseudo !'));
			$this->form_validation->set_rules('mdp', 'mdp', 'required',array('required'=>
'Veuillez saisir votre mot de passe !'));
			 
			if ($this->form_validation->run() == FALSE){
					$this->load->view('templates/haut');
				
					 $this->load->view('compte_connecter');
					 $this->load->view('templates/bas');
					 
					 
			}
			else{
				 $username = $this->input->post('pseudo');
				 $password = $this->input->post('mdp');
				$data['role'] = $this->db_model->connect_compte($username,$password);
				$data['prof'] = $this->db_model->get_profil($username);
				$data['roleF']='F';
				$data['roleA']='A';
				if($this->db_model->connect_compte($username,$password)){
					$session_data = array('username' => $username );
					 $this->session->set_userdata($session_data);
					 if($data['prof']->plf_etat=='A'){
						 //si le compte est activé
						 
							if(strcmp($data['role']->plf_role,$data['roleF'])==0){						 
								//si le role est formateur
								 $this->load->view('menu_formateur',$data);
								 $this->load->view('templates/bas');

							}
							else if(strcmp($data['role']->plf_role,$data['roleA'])==0){
								//si role est administrateur
								$this->load->view('menu_administrateur',$data);
								$this->load->view('templates/bas');
							}
					 }
					 else{
						 //si compte désactivé
						$this->load->view('templates/haut');
						 $this->load->view('compte_desactive');
						$this->load->view('compte_connecter');
						$this->load->view('templates/bas');
					 }
				}
				else{
					$this->load->view('templates/haut');
					$this->load->view('erro_compte');
					  $this->load->view('compte_connecter');
					 $this->load->view('templates/bas');
					 
				}
			}
		}
		
	//creer un nouveau compte	
		public function creer()
			 {
					 $this->load->helper('form');
					 $this->load->library('form_validation');
					 $this->form_validation->set_rules('pseudo', 'pseudo', 'required',array('required'=>
'Veuillez saisir new pseudo !'));
					 $this->form_validation->set_rules('mdp', 'mdp', 'required',array('required'=>
'Veuillez saisir mot de passe !'));
					 if ($this->form_validation->run() == FALSE)
					 {
							 $this->load->view('compte_creer');
							 $this->load->view('templates/bas');
					 }
					 else
					 {
							
							 $this->db_model->set_compte();
							 $data['le_compte']=$this->input->post('id');
							$data['le_message']="Nouveau nombre de comptes : ";
							$data['le_nombre']=$this->db_model->get_nb_comptes();
							 $this->load->view('compte_succes',$data);
							 $this->load->view('templates/bas');
					 }
			}
			//afficher des information et button de modifier d'un compte connecté
		public function profil(){
					$username= $this->session->userdata('username');
					
				    $data['prof'] = $this->db_model->get_profil($username);
					$data['roleF']='F';
					$data['roleA']='A';
										 

						$this->load->view('profil',$data);

						 $this->load->view('templates/bas');

					
		}
		//accueil de formateur ou administrateur
		public function accueil(){
					$username= $this->session->userdata('username');
					$data['prof'] = $this->db_model->get_profil($username);
					$data['roleF']='F';
					$data['roleA']='A';
					if(strcmp($data['prof']->plf_role,$data['roleF'])==0){						 
					 
						 $this->load->view('menu_formateur',$data);
						 $this->load->view('templates/bas');

					}
					else {
						if(strcmp($data['prof']->plf_role,$data['roleA'])==0){

						 $this->load->view('menu_administrateur',$data);
						$this->load->view('templates/bas');
						}
					 

					}
			
		}
		//deconnecter un compte
		public function deconnecter(){
					 $this->load->helper('url');
					$this->session->sess_destroy();
					redirect('accueil/afficher');
						 
		}

}
?>