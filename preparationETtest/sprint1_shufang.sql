//Actualités:
//1:
select * FROM t_actualite_actu ;
//2:
select * FROM t_actualite_actu where actu_id=1;
//3:
select * from t_actualite_actu ORDER BY actu_id DESC LIMIT 5;
//4:
SELECT * FROM t_actualite_actu where actu_texte like '%math%';
//5:
SELECT * FROM t_actualite_actu WHERE date(actu_date) = '2017-06-19'
//Matchs:
//1:
SELECT mth_id FROM t_match_mth WHERE mth_code='1234';
//2:
INSERT into t_joueures_jrs VALUE ( NULL,'PSEUDO',NULL,1);
//3:
SELECT jrs_pseudo FROM t_joueures_jrs WHERE jrs_pseudo='PSEUDO' AND mth_id=1;
//4:
SELECT * FROM t_question_ques Q,t_reponse_rep R where Q.mth_id=1 AND R.ques_id=Q.ques_id ;
//profils
//1:
SELECT * FROM t_profil_plf 
//2:
SELECT * FROM t_profil_plf where plf_role='F';
//3:
SELECT cpt_id FROM t_compte_cpt WHERE cpt_pseudo='PSEUDO' AND cpt_mdp=' ';
//4:
SELECT * FROM t_profil_plf WHERE cpt_id=1;
//5:
SELECT plf_id,plf_nom,plf_prenom,plf_etat FROM t_profil_plf;
//quiz:
//1:
select * FROM t_quiz_qz where quiz_intitule like '%somme%';
//2:
select * from t_question_ques where qz_id=1;

//matchs:
//1:
SELECT * FROM t_question_ques join t_match_mth USING(mth_id) where mth_code='';
//2:
SELECT COUNT(jrs_id) FROM t_joueures_jrs join t_match_mth USING(mth_id) where mth_intitule='';
//3:

//4:
select jrs_score, jrs_pseudo FROM t_joueures_jrs join t_match_mth USING(mth_id) WHERE  mth_intitule='';
//5:
SELECT mth_id,mth_intitule FROM t_match_mth join t_quiz_qz USING(qz_id) where cpt_id=2;
//6:
SELECT mth_id,mth_intitule FROM t_match_mth where qz_id=3;


