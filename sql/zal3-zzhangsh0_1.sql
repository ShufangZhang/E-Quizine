-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- 主机： localhost
-- 生成日期： 2023-04-25 14:03:17
-- 服务器版本： 10.5.12-MariaDB-0+deb11u1
-- PHP 版本： 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `zal3-zzhangsh0_1`
--

DELIMITER $$
--
-- 存储过程
--
CREATE DEFINER=`zzhangsh0`@`%` PROCEDURE `annoncer_match_fini` (IN `id_match` INT)   BEGIN
    
	DECLARE liste_joueur VARCHAR(500);
	DECLARE texte_actu VARCHAR(500);
	DECLARE date_fin,date_debut datetime;

	SELECT liste_joueur_match(id_match) INTO liste_joueur;
	SELECT mth_date_debut,mth_date_fin INTO date_debut, date_fin FROM t_match_mth WHERE mth_id=id_match;
	
	IF(date_fin IS NOT NULL AND date_fin > date_debut) THEN
		SELECT concat_ws('-->', mth_intitule,mth_date_debut,mth_date_fin,liste_joueur) INTO texte_actu FROM t_match_mth WHERE mth_id=id_match;
		insert into t_actualite_actu VALUES (NULL, 'nouveau match fini!',texte_actu,now(),1);
	end if;
	
END$$

CREATE DEFINER=`zzhangsh0`@`%` PROCEDURE `annoncer_quiz_modifi` (IN `ID_quiz` INT)   BEGIN
	DECLARE NB_QUES INT;
	DECLARE TITLE_ACTU VARCHAR(250);
	DECLARE TEXTE_ACTU VARCHAR(500);
	
	SELECT concat_ws('-->',"Modification du quiz",ID_quiz) INTO TITLE_ACTU;
	select COUNT(ques_id) INTO NB_QUES FROM t_question_ques where qz_id=ID_quiz;
	
	if(NB_QUES=1) THEN
		SET TEXTE_ACTU :="ATTENTION, plus qu'une question!";
		INSERT INTO t_actualite_actu VALUES(NULL,TITLE_ACTU,TEXTE_ACTU,NOW(),1);
   end IF;
	IF(NB_QUES=0) THEN
		SET TEXTE_ACTU :="QUIZ VIDE!";
		INSERT INTO t_actualite_actu VALUES(NULL,TITLE_ACTU,TEXTE_ACTU,NOW(),1);
   
	ELSE
		SELECT concat_ws("Suppression une question,",NB_QUES,"question restant") INTO TEXTE_ACTU;
		INSERT INTO t_actualite_actu VALUES(NULL,TITLE_ACTU,TEXTE_ACTU,NOW(),1);
	end if;
END$$

CREATE DEFINER=`zzhangsh0`@`%` PROCEDURE `nb_match` (OUT `nb_fini` INT, OUT `nb_encour` INT, OUT `nb_venir` INT)   BEGIN
	select COUNT(mth_id) into nb_fini from t_match_mth where mth_date_fin IS not NULL AND mth_date_fin> mth_date_debut;
	select count(mth_id) into nb_venir from t_match_mth where mth_date_debut>NOW() AND mth_date_fin is null;
	select count(mth_id) into nb_encour FROM t_match_mth where mth_date_debut<now() AND mth_date_fin IS NULL ;
END$$

CREATE DEFINER=`zzhangsh0`@`%` PROCEDURE `supprime_joueurs` (IN `ID_mth` INT)   BEGIN
	UPDATE t_joueurs_jrs SET mth_id= NULL WHERE mth_id =ID_mth;
END$$

--
-- 函数
--
CREATE DEFINER=`zzhangsh0`@`%` FUNCTION `liste_joueur_match` (`id_match` INT) RETURNS VARCHAR(500) CHARSET utf8mb4  BEGIN
	
	return( select GROUP_CONCAT(jrs_pseudo) 
			FROM t_joueures_jrs 
			WHERE mth_id=id_match);  
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- 替换视图以便查看 `table_ques_rep`
-- （参见下面的实际视图）
--
CREATE TABLE `table_ques_rep` (
`ques_id` int(10) unsigned
,`rep_id` int(10) unsigned
);

-- --------------------------------------------------------

--
-- 表的结构 `t_actualite_actu`
--

CREATE TABLE `t_actualite_actu` (
  `actu_id` int(10) UNSIGNED NOT NULL,
  `actu_intitule` varchar(250) DEFAULT NULL,
  `actu_texte` varchar(500) NOT NULL,
  `actu_date` datetime NOT NULL,
  `cpt_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `t_actualite_actu`
--

INSERT INTO `t_actualite_actu` (`actu_id`, `actu_intitule`, `actu_texte`, `actu_date`, `cpt_id`) VALUES
(1, 'la fête des pairs !', 'Puisque j’ai commis un impair et loupé la fête des pères, je me rattrape en vous proposant aujourd’hui de célébrer la fête des pairs !\r\nPartons donc à la découverte de ces fameux nombres pairs. Et comme les chiens ne font pas de chats, sachez que les nombres pairs ne font pas d’impairs !', '2017-06-19 17:02:02', 5),
(2, 'Tore Thor', 'Par Odin, par Toutatis, par Tore Thor ! Mais qu’est-ce que c’est que ce mot ? Cette question est bien légitime, vous n’avez pas tore tort. Mais vous êtes maintenant habitués, souvent, c’est ici qu’on se tore tord les méninges (bon, je crois que je les ai toutes faites). ', '2016-04-27 10:20:02', 7),
(3, ' Lemniscate.', 'Allez, pour ce mercredi je vous narre un mot qui reste relativement connu mais que certain(e)s ignorent peut-être encore : Lemniscate. Ce mot féminin ne fait pas référence à un lemming qui aurait copulé avec un suricate. Non, la lemniscate, c’est le nom d’un symbole très connu pour peu qu’on ait fait un peu de mathématiques dans …', '2015-06-03 19:07:45', 3);

-- --------------------------------------------------------

--
-- 表的结构 `t_compte_cpt`
--

CREATE TABLE `t_compte_cpt` (
  `cpt_id` int(10) UNSIGNED NOT NULL,
  `cpt_mdp` char(64) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `cpt_pseudo` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `t_compte_cpt`
--

INSERT INTO `t_compte_cpt` (`cpt_id`, `cpt_mdp`, `cpt_pseudo`) VALUES
(1, 'respon_quiz', 'responsable'),
(2, 'ec1c61e27ebc9117488cbfd5e92636dc95142a01', 'pohom'),
(3, 'naname', 'nanama'),
(4, 'c0f65e24f9a2bd487af0a93f9e15456e6aca8f6e', 'jadore'),
(5, 'fox888', 'lulumen'),
(6, 'hugogekkk', 'hugoge'),
(7, '7284e3da8c83ad935d089e8fbd8327d992eaa7de', 'enzobon'),
(8, 'c52071294f899907b3e2ccea671dcef0a2c0f88cb7eca55825df66dab9a26a80', 'administrateur1'),
(9, 'mimamima', 'testeur'),
(12, 'testeur2', 'testeur2'),
(13, 'testeur3mima', 'testeur3');

-- --------------------------------------------------------

--
-- 表的结构 `t_joueures_jrs`
--

CREATE TABLE `t_joueures_jrs` (
  `jrs_id` int(10) UNSIGNED NOT NULL,
  `jrs_pseudo` varchar(20) NOT NULL,
  `jrs_score` double DEFAULT NULL,
  `mth_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `t_joueures_jrs`
--

INSERT INTO `t_joueures_jrs` (`jrs_id`, `jrs_pseudo`, `jrs_score`, `mth_id`) VALUES
(1, 'alia', 0, 1),
(2, 'sand', 0, 1),
(3, 'Tom', 0, 2),
(4, 'jack', 0, 3),
(5, 'bob', 0, 4),
(6, 'stend', 0, 2),
(57, 'testa', 0, 11),
(58, 'zdqzd', 0, 11);

-- --------------------------------------------------------

--
-- 表的结构 `t_match_mth`
--

CREATE TABLE `t_match_mth` (
  `mth_code` char(8) NOT NULL,
  `mth_intitule` varchar(200) NOT NULL,
  `mth_etat` char(1) NOT NULL,
  `qz_id` int(10) UNSIGNED NOT NULL,
  `mth_id` int(10) UNSIGNED NOT NULL,
  `mth_date_debut` date NOT NULL,
  `mth_date_fin` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `t_match_mth`
--

INSERT INTO `t_match_mth` (`mth_code`, `mth_intitule`, `mth_etat`, `qz_id`, `mth_id`, `mth_date_debut`, `mth_date_fin`) VALUES
('Orthog22', 'Match sur l\'orthogonalité débutant', 'A', 3, 1, '2022-12-08', NULL),
('OtgAnc22', 'Match sur l\'orthogonalité avancée', 'D', 4, 2, '2022-12-06', NULL),
('Vecteu22', 'match sur vecteur', 'A', 3, 3, '2022-10-31', '2022-12-02'),
('Varial22', 'match sur les variables aléatoires', 'A', 1, 4, '2022-10-28', '2022-11-07'),
('TEST1', 'Match TEST1', 'A', 6, 10, '2022-12-08', NULL),
('TEST2', 'Match TEST2', 'A', 6, 11, '2022-12-08', NULL),
('TEST3', 'Match TEST3', 'D', 6, 12, '2022-12-11', NULL),
('TEST4', 'Match TEST4', 'A', 6, 13, '2022-12-08', NULL);

--
-- 触发器 `t_match_mth`
--
DELIMITER $$
CREATE TRIGGER `RAZ` AFTER UPDATE ON `t_match_mth` FOR EACH ROW BEGIN
	IF OLD.mth_date_debut!=NEW.mth_date_debut AND NEW.mth_date_debut = now() AND NEW.mth_date_fin IS NULL THEN
		DELETE FROM t_joueures_jrs WHERE mth_id=NEW.mth_id;
	end if;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `ajout_actu_match` AFTER UPDATE ON `t_match_mth` FOR EACH ROW BEGIN
	IF(OLD.mth_date_fin IS NULL AND NEW.mth_date_fin IS NOT NULL) THEN
		
		call  annoncer_match_fini(NEW.mth_id);
	end IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- 表的结构 `t_profil_plf`
--

CREATE TABLE `t_profil_plf` (
  `plf_nom` varchar(60) NOT NULL,
  `plf_prenom` varchar(60) NOT NULL,
  `plf_role` char(1) NOT NULL,
  `plf_date` datetime NOT NULL,
  `plf_mail` varchar(60) NOT NULL,
  `plf_etat` char(1) NOT NULL,
  `plf_id` int(10) UNSIGNED NOT NULL,
  `cpt_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `t_profil_plf`
--

INSERT INTO `t_profil_plf` (`plf_nom`, `plf_prenom`, `plf_role`, `plf_date`, `plf_mail`, `plf_etat`, `plf_id`, `cpt_id`) VALUES
('Valeri', 'Marc', 'A', '2012-10-09 15:50:18', 'responsable_quiz@qzmail.com', 'A', 1, 1),
('MEDAL', 'John', 'A', '2012-09-03 04:50:59', 'administrateur1_quiz@qzmail.com', 'A', 2, 8),
('MARTIN', 'liam', 'F', '2017-10-10 07:51:28', 'liam_martin@quizmail.com', 'A', 3, 2),
('BERNARD', 'Emma', 'F', '2016-08-17 21:51:46', 'emme_ber@qzmail.com', 'A', 4, 3),
('PETIE', 'jade', 'F', '2014-07-08 11:08:34', 'jadore_pt@qzmail.com', 'A', 5, 4),
('RICHARD', 'lulu', 'F', '2022-10-10 11:52:38', 'luulu_rich@qzmail.com', 'A', 6, 5),
('ROBERT', 'Hugo', 'F', '2022-01-08 03:41:50', 'hugo_rb@qzmail.com', 'A', 7, 6),
('MOREL', 'enzo', 'F', '2022-04-20 07:17:35', 'enzo_morel@qzmqil.com', 'A', 8, 7);

-- --------------------------------------------------------

--
-- 表的结构 `t_question_ques`
--

CREATE TABLE `t_question_ques` (
  `ques_id` int(10) UNSIGNED NOT NULL,
  `ques_etat` char(1) NOT NULL,
  `ques_texte` varchar(500) NOT NULL,
  `cpt_id` int(10) UNSIGNED NOT NULL,
  `qz_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `t_question_ques`
--

INSERT INTO `t_question_ques` (`ques_id`, `ques_etat`, `ques_texte`, `cpt_id`, `qz_id`) VALUES
(1, 'A', 'Si on répète n fois une épreuve, ces épreuves seront indépendantes si :', 2, 1),
(2, 'A', 'Quand les différentes issues d\'une épreuve ont la même probabilité, on dit qu\'elles sont...', 2, 1),
(3, 'A', 'Une épreuve de Bernouilli admet :', 2, 1),
(4, 'A', 'Pour une variable aléatoire suivant une loi de Bernouilli, avec X = 1 de probabilité p et X = 0 autrement, E(X) vaut :', 2, 1),
(5, 'A', 'L\'espérance d\'une somme de variable aléatoires E(aX) peut s\'écrire :', 3, 2),
(6, 'A', 'L\'espérance d\'une variable aléatoire est une fonction...', 3, 2),
(7, 'A', 'L\'espérance d\'une variable aléatoire X suivant une loi binomiale de paramètre (n ; p) peut s\'écrire :', 3, 2),
(8, 'A', 'Si une droite et un plan sont sécants, cette droite et ce plan n’ont qu’un seul point d’intersection.', 4, 3),
(9, 'A', 'Lequel de ces termes détermine la « taille » d’un vecteur →AB ?', 4, 3),
(10, 'A', 'A quoi est égal le produit scalaire de deux vecteurs u et v ?', 5, 4),
(11, 'A', 'Deux vecteurs u et v sont orthogonaux si et seulement si...', 5, 4),
(12, 'A', 'La variable aléatoire X suit une loi binomiale B(50 ; 0,2). L\'espérance mathématique E(X) vaut :', 2, 1),
(13, 'A', 'On lance 100 fois une pièce. La variable X correspondant au nombre de fois où on obtient « face »...', 3, 2),
(14, 'A', 'On lance un dé à 6 faces. X étant la variable aléatoire égale au chiffre obtenu, que vaut P(X < 3) = ?', 3, 2),
(15, 'A', 'Que forme l’intersection de deux plans sécants ?', 4, 3),
(16, 'A', 'On dit parfois d’un plan qu’il est le plan médiateur d’un segment. Que cela veut-il dire ?', 4, 3),
(17, 'A', 'Pour prouver que des points A, B et C sont alignés à l’aide de vecteurs, que suffit-il de montrer ?', 4, 3),
(18, 'A', 'Deux vecteurs u et v sont orthogonaux si et seulement si...', 5, 4),
(19, 'A', 'L’intersection de deux droites orthogonales...', 5, 4),
(20, 'A', 'Quand peut-on dire qu’une base (i ; j ; k) est orthonormée dans l’espace ?', 5, 4),
(21, 'A', 'question test', 6, 6);

--
-- 触发器 `t_question_ques`
--
DELIMITER $$
CREATE TRIGGER `annoncer_quiz_modifi` AFTER DELETE ON `t_question_ques` FOR EACH ROW BEGIN
	DECLARE NB_QUES INT;
	DECLARE TITLE_ACTU VARCHAR(250);
	DECLARE TEXTE_ACTU VARCHAR(500);
	
	SELECT concat_ws('-->','Modification du quiz',OLD.qz_id) INTO TITLE_ACTU;
	select COUNT(ques_id) INTO NB_QUES FROM t_question_ques where qz_id=OLD.qz_id;
		delete from t_actualite_actu where actu_intitule=(select concat_ws('-->',"modification du quiz",old.qz_id));

	if(NB_QUES=1) THEN
		SET TEXTE_ACTU :="ATTENTION, plus qu'une question";
		INSERT INTO t_actualite_actu VALUES(NULL,TITLE_ACTU,TEXTE_ACTU,NOW(),1);	
	end if;
	IF(NB_QUES=0) THEN
		SET TEXTE_ACTU :="QUIZ VIDE!";
		INSERT INTO t_actualite_actu VALUES(NULL,TITLE_ACTU,TEXTE_ACTU,NOW(),1);
        END IF;
	IF (NB_QUES >=2) THEN
		SELECT concat("Suppression dune question, il rest :",NB_QUES,"question") INTO TEXTE_ACTU;
		INSERT INTO t_actualite_actu VALUES(NULL,TITLE_ACTU,TEXTE_ACTU,NOW(),1);
	end if;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- 表的结构 `t_quiz_qz`
--

CREATE TABLE `t_quiz_qz` (
  `qz_id` int(10) UNSIGNED NOT NULL,
  `qz_image` varchar(200) NOT NULL,
  `qz_intitule` varchar(200) NOT NULL,
  `cpt_id` int(10) UNSIGNED NOT NULL,
  `qz_etat` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `t_quiz_qz`
--

INSERT INTO `t_quiz_qz` (`qz_id`, `qz_image`, `qz_intitule`, `cpt_id`, `qz_etat`) VALUES
(1, 'quiz1.png', 'Les variables aléatoires', 2, 'A'),
(2, 'D:\\L3\\image\\quiz3', 'La somme des variables aléatoires', 3, 'A'),
(3, 'D:\\L3\\image\\quiz4', 'Les vecteurs de l\'espace', 4, 'A'),
(4, 'D:\\L3\\image\\quiz5', 'Orthogonalité et distances dans l’espace', 5, 'A'),
(6, 'image', 'quiz_test', 6, 'A');

-- --------------------------------------------------------

--
-- 表的结构 `t_reponse_rep`
--

CREATE TABLE `t_reponse_rep` (
  `rep_id` int(10) UNSIGNED NOT NULL,
  `rep_texte` varchar(500) NOT NULL,
  `rep_etat` char(1) NOT NULL,
  `ques_id` int(10) UNSIGNED NOT NULL,
  `rep_bon` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `t_reponse_rep`
--

INSERT INTO `t_reponse_rep` (`rep_id`, `rep_texte`, `rep_etat`, `ques_id`, `rep_bon`) VALUES
(1, 'L\'issue d\'une épreuve ne dépend pas des autres.', 'A', 1, 'B'),
(2, 'L\'issue d\'une épreuve est identique à chaque répétition.', 'A', 1, 'N'),
(3, 'L\'issue d\'une épreuve exclut une autre.', 'A', 1, 'N'),
(4, 'équiprobables\r\n', 'A', 2, 'B'),
(5, 'coprobables\r\n', 'A', 2, 'N'),
(6, 'équivalentes', 'A', 2, 'N'),
(7, 'infinité d issues\n', 'A', 3, 'N'),
(8, 'au moins deux issues\r\n', 'A', 3, 'N'),
(9, 'exactement deux issues\n', 'A', 3, 'B'),
(10, 'p/2\r\n', 'A', 4, 'N'),
(11, 'p\r\n', 'A', 4, 'B'),
(12, '1-p', 'A', 4, 'N'),
(13, 'E(aX) = a + E(X)\n', 'A', 5, 'N'),
(14, 'E(aX) = E(X2\n', 'A', 5, 'N'),
(15, 'E(aX) = aE(X)', 'A', 5, 'B'),
(16, '\r\ncontinue\n', 'A', 6, 'N'),
(17, 'linéaire\n', 'A', 6, 'B'),
(18, 'non-linéaire', 'A', 6, 'N'),
(19, '\r\nE(X) = n/p\n', 'A', 7, 'N'),
(20, 'E(X) = p/n\n', 'A', 7, 'N'),
(21, 'E(X) = np', 'A', 7, 'B'),
(22, '\r\nVrai\n', 'A', 8, 'B'),
(23, 'Faux\n', 'A', 8, 'N'),
(24, '\r\nle sens\n', 'A', 9, 'N'),
(25, 'la direction\n', 'A', 9, 'N'),
(26, 'la norme\n', 'A', 9, 'B'),
(27, 'sens de u x sens de v x sin (u;v)\n', 'A', 10, 'N'),
(28, 'direction de u x direction de v x tan (u;v)\n', 'A', 10, 'N'),
(29, 'norme de u x norme de v x cos (u;v)\n', 'A', 10, 'B'),
(30, 'ils sont égaux.\r\n', 'A', 11, 'N'),
(31, '\r\nils sont perpendiculaires.\r\n', 'A', 11, 'N'),
(32, '\r\nleur produit scalaire est nul.', 'A', 11, 'B'),
(33, '50', 'A', 12, 'N'),
(34, '20', 'A', 12, 'N'),
(35, '10', 'A', 12, 'B'),
(36, '\r\n1/6', 'A', 14, 'N'),
(37, '1/2', 'A', 14, 'N'),
(38, '1/3', 'A', 14, 'B'),
(39, 'Suit une loi binomiale.\r\n', 'A', 13, 'B'),
(40, 'Ne suit pas une loi binomiale.\r\n', 'A', 13, 'N'),
(41, 'Est toujours égal à 50.', 'A', 13, 'N'),
(42, 'une droite\r\n', 'A', 15, 'B'),
(43, 'un plan\r\n', 'A', 15, 'N'),
(44, 'un point', 'A', 15, 'N'),
(45, 'C’est un plan ne passant pas par le segment.\r\n', 'A', 16, 'N'),
(46, 'C’est un plan passant par l’extrémité du segment et parallèle à ce segment.\r\n', 'A', 16, 'N'),
(47, '\r\n\r\nC’est un plan passant par le milieu du segment et orthogonal à ce segment. ', 'A', 16, 'B'),
(48, 'Les vecteurs AB et AC sont colinéaires.', 'A', 17, 'B'),
(49, 'Les points A, B et C sont équidistants.\r\n', 'A', 17, 'N'),
(50, 'AB = AC', 'A', 17, 'N'),
(51, 'leur produit scalaire est nul.  \r\n', 'A', 18, 'B'),
(52, 'ils sont égaux.\r\n', 'A', 18, 'N'),
(53, 'ils sont perpendiculaires.', 'A', 18, 'N'),
(54, 'ne peut être que vide.\r\n', 'A', 19, 'N'),
(55, '\r\npeut être vide, ou un point. \r\n', 'A', 19, 'B'),
(56, 'ne peut être qu’un point.', 'A', 19, 'N'),
(57, 'Lorsque ses vecteurs de base ont une norme = 1 et sont parallèles deux à deux.\r\n', 'A', 20, 'N'),
(58, 'Lorsque ses vecteurs de base ont une norme = 0 et sont parallèles deux à deux.\r\n', 'A', 20, 'N'),
(59, 'Lorsque ses vecteurs de base ont une norme = 1 et sont orthogonaux deux à deux.', 'A', 20, 'B'),
(60, 'reponse_test1', 'A', 21, 'B'),
(61, 'response_test2', 'A', 21, 'N');

-- --------------------------------------------------------

--
-- 视图结构 `table_ques_rep`
--
DROP TABLE IF EXISTS `table_ques_rep`;

CREATE ALGORITHM=UNDEFINED DEFINER=`zzhangsh0`@`%` SQL SECURITY DEFINER VIEW `table_ques_rep`  AS SELECT `t_question_ques`.`ques_id` AS `ques_id`, `t_reponse_rep`.`rep_id` AS `rep_id` FROM (`t_question_ques` join `t_reponse_rep` on(`t_question_ques`.`ques_id` = `t_reponse_rep`.`ques_id`)) GROUP BY `t_question_ques`.`ques_id``ques_id`  ;

--
-- 转储表的索引
--

--
-- 表的索引 `t_actualite_actu`
--
ALTER TABLE `t_actualite_actu`
  ADD PRIMARY KEY (`actu_id`),
  ADD KEY `cpt_id` (`cpt_id`);

--
-- 表的索引 `t_compte_cpt`
--
ALTER TABLE `t_compte_cpt`
  ADD PRIMARY KEY (`cpt_id`);

--
-- 表的索引 `t_joueures_jrs`
--
ALTER TABLE `t_joueures_jrs`
  ADD PRIMARY KEY (`jrs_id`),
  ADD KEY `FK_mth_id` (`mth_id`);

--
-- 表的索引 `t_match_mth`
--
ALTER TABLE `t_match_mth`
  ADD PRIMARY KEY (`mth_id`),
  ADD KEY `quiz_id` (`qz_id`);

--
-- 表的索引 `t_profil_plf`
--
ALTER TABLE `t_profil_plf`
  ADD PRIMARY KEY (`plf_id`),
  ADD UNIQUE KEY `FK_cpt_id` (`cpt_id`) USING BTREE;

--
-- 表的索引 `t_question_ques`
--
ALTER TABLE `t_question_ques`
  ADD PRIMARY KEY (`ques_id`),
  ADD KEY `FK_id_cpt` (`cpt_id`),
  ADD KEY `FK_id_quiz` (`qz_id`);

--
-- 表的索引 `t_quiz_qz`
--
ALTER TABLE `t_quiz_qz`
  ADD PRIMARY KEY (`qz_id`),
  ADD KEY `FK_id` (`cpt_id`);

--
-- 表的索引 `t_reponse_rep`
--
ALTER TABLE `t_reponse_rep`
  ADD PRIMARY KEY (`rep_id`),
  ADD KEY `ques_id` (`ques_id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `t_actualite_actu`
--
ALTER TABLE `t_actualite_actu`
  MODIFY `actu_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- 使用表AUTO_INCREMENT `t_compte_cpt`
--
ALTER TABLE `t_compte_cpt`
  MODIFY `cpt_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- 使用表AUTO_INCREMENT `t_joueures_jrs`
--
ALTER TABLE `t_joueures_jrs`
  MODIFY `jrs_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- 使用表AUTO_INCREMENT `t_match_mth`
--
ALTER TABLE `t_match_mth`
  MODIFY `mth_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- 使用表AUTO_INCREMENT `t_profil_plf`
--
ALTER TABLE `t_profil_plf`
  MODIFY `plf_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- 使用表AUTO_INCREMENT `t_question_ques`
--
ALTER TABLE `t_question_ques`
  MODIFY `ques_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- 使用表AUTO_INCREMENT `t_quiz_qz`
--
ALTER TABLE `t_quiz_qz`
  MODIFY `qz_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- 使用表AUTO_INCREMENT `t_reponse_rep`
--
ALTER TABLE `t_reponse_rep`
  MODIFY `rep_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- 限制导出的表
--

--
-- 限制表 `t_actualite_actu`
--
ALTER TABLE `t_actualite_actu`
  ADD CONSTRAINT `cpt_id` FOREIGN KEY (`cpt_id`) REFERENCES `t_compte_cpt` (`cpt_id`);

--
-- 限制表 `t_joueures_jrs`
--
ALTER TABLE `t_joueures_jrs`
  ADD CONSTRAINT `FK_mth_id` FOREIGN KEY (`mth_id`) REFERENCES `t_match_mth` (`mth_id`);

--
-- 限制表 `t_match_mth`
--
ALTER TABLE `t_match_mth`
  ADD CONSTRAINT `quiz_id` FOREIGN KEY (`qz_id`) REFERENCES `t_quiz_qz` (`qz_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- 限制表 `t_profil_plf`
--
ALTER TABLE `t_profil_plf`
  ADD CONSTRAINT `fk_cpt_id` FOREIGN KEY (`cpt_id`) REFERENCES `t_compte_cpt` (`cpt_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- 限制表 `t_question_ques`
--
ALTER TABLE `t_question_ques`
  ADD CONSTRAINT `FK_id_cpt` FOREIGN KEY (`cpt_id`) REFERENCES `t_compte_cpt` (`cpt_id`),
  ADD CONSTRAINT `FK_id_quiz` FOREIGN KEY (`qz_id`) REFERENCES `t_quiz_qz` (`qz_id`);

--
-- 限制表 `t_quiz_qz`
--
ALTER TABLE `t_quiz_qz`
  ADD CONSTRAINT `FK_id` FOREIGN KEY (`cpt_id`) REFERENCES `t_compte_cpt` (`cpt_id`);

--
-- 限制表 `t_reponse_rep`
--
ALTER TABLE `t_reponse_rep`
  ADD CONSTRAINT `ques_id` FOREIGN KEY (`ques_id`) REFERENCES `t_question_ques` (`ques_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
