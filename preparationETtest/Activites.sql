
//ACTIVITE 1
//récupérez, dans une variable, l’identifiant auto-incrémenté de la ligne du profil (/
compte) nouvellement insérée dans la base pour pouvoir le réutiliser pour insérer le
compte d’un administrateur / formateur.
set @nouvelle_id :=(select max(plf_id)  from t_profil_plf);
   select @nouvelle_id;
   
select max(plf_id) into @num_max from t_profil_plf;
   SELECT @num_max;

//activite 2 
//créez une vue contenant uniquement les noms et prénoms du contenu de la table
de gestion des profils.
create view nom_prenom
as select plf_nom,plf_prenom
from t_profil_plf;

//--------------test----
UPDATE nom_prenom set plf_prenom='valentina'
where plf_prenom='hugo' and plf_nom='robert';

//activite 3
//créez une fonction retournant l’âge du titulaire d’un profil d’après sa date de
naissance passée en paramètre (ajoutez, en utilisant la commande ALTER TABLE,
une colonne à votre table de gestion des profils si cela est nécessaire).
DELIMITER //
CREATE FUNCTION age(age_date Date) RETURNS INT
BEGIN  
 	if month(curedate())<month(age_date) THEN
		return year(curedate())-year(age_date)-1;
	else if month(curedate())=month(age_date) THEN
		if date(curedate())<date(age_date) THEN
        RETURN year(curedate())-year(age_date)-1;
		else 
        RETURN year(curedate())-year(age_date);
      END if;
 	ELSE
      return year(curedate())-year(age_date);  
   END if;
END;
//
DELIMITER ;

DELIMITER //
CREATE FUNCTION age(ladate Date) RETURNS INT
BEGIN  
 	declare age int default 0;
	set @age :=year(curedate())-year(ladate);
    
	IF ((month(ladate)>month(curedate())) or (month(ladate)=month(curedate()))and (day(ladate)>day(curedate()))) THEN
		
      RETURN @age-1;
	END IF;
   RETURN @age;
END;
//
DELIMITER ;

//------------------------------------tester
select age('2020-09-13');

select plf_prenom,age(plf_date) as age from t_profil_plf;


//ACTIVITE 4 
//créez une procédure renvoyant l’âge du titulaire d’un profil en sortie à partir de son
identifiant en entrée.
DELIMITER //
CREATE PROCEDURE donne_age(in id_plf, out age_plf int)
BEGIN 
	select timestampdiff(year, plf_date,curdate()) INTO age_plf FROM t_profil_plf where plf_id=id_plf;
END;
 //
DELIMITER ;  
//methode de 2
DELIMITER //
CREATE PROCEDURE donne_age2(in id_plf int, out age_plf int)
BEGIN 
	select ans(plf_date) INTO age_plf FROM t_profil_plf where plf_id=id_plf;
END;
 //
DELIMITER ;
 
//Utilisez la procédure créée pour connaître l’âge du titulaire d’un profil d’identifiant 1
dans la base de données.  
   set @son_age:=0;
   call donne_age(1,son_age);
   select @son_age;

//Puis écrivez une autre procédure utilisant la fonction créée dans l’activité 3 dans le
but d’afficher le message « majeur » si le titulaire d’un profil a plus de 18 ans ou
« mineur » si le titulaire du profil a moins de 18 ans.

DELIMITER //
CREATE PROCEDURE majeur(IN id_pld int, OUT majeur_plf char(30))

BEGIN 
	DECLARE age int DEFAULT 0;
   SELECT donne_age(plf_date_naissance) INTO age FROM t_profil_plf WHERE plf_id=id_plf;
   if age<18 THEN
   	SET majeur_plf := 'mineur';
   ELSE 
   		SET majeur_plf := 'majeur';
   END IF;
END;
//
DELIMITER ;

//------------------
SET @maj = ' ';
call majeur('9', @maj);
	select @maj;

/*Créez une nouvelle vue contenant les noms, prénoms et âges des titulaires des
profils du contenu de la table de gestion des profils*/
creat view 


/*créez une procédure qui renvoie en sortie l’âge moyen des profils dans la base*/
DROP PROCEDURE IF EXISTS donne_age_moyen;
DELIMITER //
CREATE PROCEDURE donne_age_moyen(out age_moyen_plf float)
BEGIN
	SELECT AVG(age) INTO age_moyen_plf FROM vue_age;
END;
//
DELIMITER ;
/*-----------------------------------------test-----------*/
call donne_age_moyen(@am);
select @am;

//activite 5
/*créez un « trigger » qui applique à la date de création du profil la date du jour
d’insertion des données du nouveau profil.*/
create 
DELIMITER //
CREATE TRIGGER date_creation_log BEFORE INSERT
ON t_profil_plf for each ROW
BEGIN
	SET new.plf_date=curdate(); /*avec new on a un accès direct au colone de la ligne concernée.*/
END;
//
DELIMITER ;

/* 列出所有触发器*/
SELECT name FROM sqlite_master
WHERE type = 'trigger';

/*Créez un autre « trigger » qui met à jour la a date associée au profil suite à la mise à
jour d’une ligne de la table de gestion des comptes (ex : mise à jour du mot de
passe).*/
DELIMITER //
CREATE TRIGGER maj_profil3
after UPDATE on t_compte_cpt
FOR EACH ROW
BEGIN
UPDATE t_profil_plf SET plf_date = curdate() WHERE t_profil_plf.plf_id = NEW.plf_id;
END;
//
DELIMITER ;



/*Activez les 2 déclencheurs créés.*/