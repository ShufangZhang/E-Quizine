<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Match extends CI_Controller {
	public function __construct()
	 {
			parent::__construct();
			$this->load->model('db_model');

			$this->load->helper('url_helper');
	 }
	 //afficher les donée d'un match en saisi du code dans l'url
	public function afficher($code =FALSE)
	{
							//Chargement de la view haut.php
						$this->load->view('templates/haut');

			if ($code==FALSE)
						{ $url=base_url(); header("Location:$url");}
			else{
						 $data['match'] = $this->db_model->get_match($code);
						 $data['match_id'] = $this->db_model->get_match_id($code);
						 

						 $this->load->view('match_afficher',$data);
						 

			}
			$this->load->view('templates/bas');

	}
	
	
	
	
	
}
?>