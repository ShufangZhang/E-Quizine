# Matchs:
# 5)
SELECT _ques.ques_id, _ques.ques_texte, _rep.rep_id, _rep.rep_texte
FROM T_match_mth
JOIN T_quiz_qz USING(qz_id)
JOIN T_question_ques AS _ques USING(qz_id)
JOIN T_reponse_rep AS _rep USING(ques_id)
WHERE mth_id = 2 && rep_etat = 1;

# 6)
SELECT rep_etat 
FROM T_reponse_rep
WHERE rep_id = 1;

# 7)
UPDATE t_joueures_jrs
SET jrs_score = jrs_score + 1
WHERE jrs_pseudo = 'Shufang Z.' && mth_id = 2;

# 8)
SELECT jrs_score
FROM t_joueures_jrs
WHERE jrs_pseudo = 'Shufang Z.' && match_id = 2;


# Quiz:
# 3)
SELECT * FROM t_quiz_qz;

# 4)
SELECT
	_quiz.qz_intitule,
    _quiz_man.compte_pseudo AS quiz_author,
    _match.mth_intitule,
    _match_man.compte_pseudo AS match_author
FROM t_quiz_qz AS _quiz
JOIN t_compte_cpt AS _quiz_man ON _quiz.cpt_id = _quiz_man.cpt_id
LEFT OUTER JOIN t_match_mth AS _match ON _match.cpt_id = _quiz.cpt_id
LEFT OUTER JOIN t_compte_cpt AS _match_man ON _match_man.cpt_id = _match.cpt_id;

# 5)
SELECT * FROM t_quiz_qz WHERE cpt_id = 3;

# 6)
# SELECT t_quiz_qz.* FROM t_quiz_qz
 JOIN t_compte_cpt USING(cpt_id) 
 join t_profil_plf using (cpt_id)
 WHERE plf_role != 'F';
SELECT * FROM t_quiz_qz WHERE cpt_id = 1;

# 7)
SELECT _quiz.*, _match.*
FROM t_compte_cpt
JOIN t_quiz_qz AS _quiz USING(cpt_id)
LEFT OUTER JOIN t_match_mth AS _match USING(qz_id)
WHERE cpt_pseudo = 'remyo' && cpt_mdp = 'a625af4612f08fee465e3b5976567fe6fa0151bd8167c55641cbaf7314fa12de20cad6f6c330345b6ea3f302fe6cab9c1e19c675f0bec7b2f20e04b4844ff172';


# Matchs:

# 8)
UPDATE t_match_mth
SET match_date_fin= CURDATE()
WHERE match_id = 1;

# 9)
DELETE FROM t_joueures_jrs WHERE mth_id = 7;
DELETE FROM t_match_mth WHERE mth_id = 7;

# 10)
UPDATE t_match_mth
SET mth_etat = 'D'
WHERE match_id = 1;

# 11)
DELETE FROM t_joueures_jrs WHERE mth_id = 1;

UPDATE t_match_mth
SET
	mth_date_debut = NULL,
	mth_date_fin = NULL
WHERE mth_id = 1;