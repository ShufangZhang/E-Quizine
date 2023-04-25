<?php
class Db_model extends CI_Model {
	 public function __construct()
	 {
			$this->load->database(); 
	 }

	 //afficher tous les compte
	 public function get_all_compte()
	{
			$query = $this->db->query("SELECT cpt_pseudo FROM t_compte_cpt;");
			return $query->result_array();
	}
	
	//afficher une actualité dont on connait l'id
	public function get_actualite($numero)
	{
			$query = $this->db->query("SELECT actu_intitule,actu_texte, actu_date, cpt_pseudo
										from t_actualite_actu join 											t_compte_cpt using(cpt_id)
										WHERE actu_id=".$numero.";");
			return $query->row();
	}
	//afficher tous les actualités dans l'acceuil
	public function get_all_actualite()
	{
			$query = $this->db->query("SELECT actu_intitule, actu_texte,actu_date, cpt_pseudo
										from t_actualite_actu join t_compte_cpt using(cpt_id);"
										);
			return $query->result_array();
	}
	//récupérer le nombre des actu actuellement
	public function get_nb_actualite()
	{
			$query = $this->db->query("SELECT count(*) as nombre
										from t_actualite_actu ;"
										);
			return $query->row();
	}
	//afficher un match dont on connait le code du match
	public function get_match($code)
	{
			$query = $this->db->query("select mth_etat,mth_id,mth_intitule,mth_code,mth_date_debut,mth_date_fin,qz_id,ques_texte,ques_id,rep_texte
					from t_match_mth
					join t_quiz_qz USING(qz_id)
					join t_question_ques USING(qz_id)
					join t_reponse_rep USING(ques_id)
					where mth_code = '".$code."';");
			return $query->result_array();
	}
	//récupérer l'intitule et l'état de quiz d'un match et l'etat d'un match
	public function get_match_id($code){
			$query = $this->db->query("select qz_intitule, qz_etat, mth_etat
					from t_match_mth
					join t_quiz_qz USING(qz_id)
					join t_question_ques USING(qz_id)
					join t_reponse_rep USING(ques_id)
					where mth_code = '".$code."';");
			return $query->row();
	}
	//verifier l'etat d'un match
	public function match_etat($code)
	{
	$query =$this->db->query("select *
						from t_match_mth
						
						where mth_code = '".$code."' and mth_etat= 'A';");
	 if($query->num_rows() > 0){ return true;}
	 else{return false;}
	}
	//verifier l'etat d'un quiz
	public function quiz_etat($code)
	{
	$query =$this->db->query("select qz_id
						from t_match_mth
						join t_quiz_qz using(qz_id)
						where mth_code = '".$code."' and qz_etat= 'A';");
	 if($query->num_rows() > 0){ return true;}
	 else{return false;}
	}
	//vérifier si le code match entrée existe
	public function joueur_connect($codematch,$userpseudo)
	{
	$query =$this->db->query("select mth_intitule,mth_code,mth_date_debut,mth_date_fin,qz_id,ques_texte,ques_id,rep_texte
						from t_match_mth
						join t_quiz_qz USING(qz_id)
						join t_question_ques USING(qz_id)
						join t_reponse_rep USING(ques_id)
						where mth_code = '".$codematch."';");
	 if($query->num_rows() > 0){ return true;}
	 else{return false;}
	}
	
	
	
	
	//vérifier un compte connecte
	public function connect_compte($username, $password)
	{
	$query =$this->db->query("SELECT cpt_pseudo,cpt_mdp,plf_role
						FROM t_compte_cpt
						join t_profil_plf using(cpt_id)
						WHERE cpt_pseudo='".$username."'
						AND cpt_mdp='".$password."';");
	 return $query->row();
	 if($query->num_rows() > 0){return true;}
	 else{return false;}
	 
	}
		//vérifier le code saisi d'un match 
		public function join_match($code)
	{
		
	$query =$this->db->query("SELECT mth_code
						FROM t_match_mth
						WHERE mth_code='".$code."';");
	 return $query->row();
	 if($query->num_rows() > 0){return true;}
	 else{return false;}
	}
	
	//ajouter un nouveau joueur dont le pseudo saisi
	public function ajout_joueur($pseudo,$code)
			{
			
			 
			 
			 //trouver l'id de match 
			 $match_data="select mth_id from t_match_mth where mth_code='".$code."' ;";
			 $query1 = $this->db->query($match_data);
			 $result=$query1->row();
			 $id=$result->mth_id;
			 
			$req="INSERT INTO t_joueures_jrs VALUES (null,'".$pseudo."',0,".$id.");";
			$query = $this->db->query($req);
			return ($query);
			
			
			}
	
	//compter le nombre de compte 
	   public function get_nb_comptes()
		{// Fonction créée et testée dans le précédent tutoriel
					 $query=$this->db->query("SELECT COUNT(*) as nb FROM t_compte_cpt;");
					return $query->row();
		}
	//requete pour ajouer un nouveau compte
		public function set_compte()
		{
			 $this->load->helper('url');
			 $pseudo=$this->input->post('pseudo');
			$mdp=$this->input->post('mdp');
			$req="INSERT INTO t_compte_cpt VALUES ('','".$mdp."','".$pseudo."');";
			$query = $this->db->query($req);
			return ($query);
		}
	
	//récupérer les informations d'un profil dont 
	public function get_profil($pseudo)
			{
			$query = $this->db->query("select *
						from t_profil_plf
						join t_compte_cpt using(cpt_id)
						
						where cpt_pseudo = '".$pseudo."';");
			return $query->row();
			
			}
	//verifier si il y déja ce pseudo saisi
	public function verif_pseudo($pseudo,$code){
		
			$pseudo_data="select count(*) as nb 
			from t_joueures_jrs 
			join t_match_mth using(mth_id)
			where jrs_pseudo ='".$pseudo."' and mth_code='".$code."' ; ";
			$query = $this->db->query($pseudo_data);

			return $query->row();
					
	}
	//modifier le mdp dont un compte connecté
	public function modifier_mdp_formateur($pseudo,$new_mdp){
		
		$new_mdp=$this->input->post('mdp');
		$query=$this->db->query("update t_compte_cpt 
									
									set cpt_mdp='".$new_mdp."' where cpt_pseudo = '".$pseudo."'; ");
		return ($query);
	}
}
?>

