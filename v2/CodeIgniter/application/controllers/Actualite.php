<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Actualite extends CI_Controller {

		 public function __construct()
		 {
				 parent::__construct();
				 $this->load->model('db_model');
				$this->load->helper('url_helper');
		 }
		 public function afficher($numero =FALSE)
		 {
				 $this->load->view('templates/haut');

				 if ($numero==FALSE)
						{ $url=base_url(); header("Location:$url");}
				 else{
						 $data['titre'] = 'Actualité :';
						 $data['actu'] = $this->db_model->get_actualite($numero);
						$data['nb'] = $this->de_model->get_nb_actualite();
						$data[le_message]="'Aucune actualité pour l'instant !'";
						 $this->load->view('actualite_afficher',$data);
						
						else
							
						
				 }
		 }
}
?>

 
	