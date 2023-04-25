# **Projet E-Quizine**  
> ## **Auteurs**
>>  Nom Prénom: ZHANG Shufang  
>>  Date: 5/12/2022  
>  ## **Compte de PhPadmin:**
>>  Pseudo: zzhangsh0  
>>  mdp: ********  
> ## **Base de donnée utilisée :**  
>> zal3-zzhangsh0_1  
> ## **Sujet d'application Web:**  
>> Mathématique  
> ## **Template Bootstrap:**  
>> https://bootstrapmade.com/demo/iPortfolio/>  
> ## **URL de la dernière version:**
>> https://obiwan.univbrest.fr/difal3/zzhangsh0/dev/CodeIgniter/index.php/
> ## **Description d'application:**  
>> Une application qui permet de jouer des matches de Mathématique pour savoir son niveau par un joueur, de creer des quiz et des matchs par un formateur, de gérer des comptes et des actualités par administrateur.
> ## **Description des triggers crées:**  
>>* **RAZ:**   
  -- Supprimer tous les joueurs d'un match après on RAZ(mètre la date début lendemin et fin null) ce match.  
>>* **ajout_actu_match:**  
   -- Creer une nouvelle actualité apres choisir la date fini du match(date de fin n'est plus null).  
>>* **annoncer_quiz_modifi:**  
   -- Creer une nouvelle actualité apres une modification des questions de quiz et supprimer tous les actualités rapport à ce match.  
>>* **supprimer_question:**  
--  supprimer tous les questions rapport à un match avant la suppression de ce match.  
>>* **supprimer_reponse:**   
-- supprimer tous les reponses rapport à une question avant la suppression de cette question.  
> ## **Description des vues:**    
>>* **compte_creer:**  
--  la page permet de creer un nouveau compte par l'admi(uniquement pour admin connecté)
>>* **compte_liste:**  
--  lister tous les compte et profil(uniquement pour admin connecté)  
>>* **formateur_match:**   
-- lister tous ses match et quiz du formateur connecté  
>>* **fofrmateur_modifier:**  
--  les champs de mdp de saisi pour modifier le mdp dont le compte  connecté  
>>* **menu_administrateur:**  
--  page accueil de admin  
>>* **menu_formateur:**  
--  page accueil de formateur  
>>* **page_accueil:**  
--  page accueil d'application (les champs saisi de pseudo et code match, tous les actualité, bouton connecter un compte)  
>>* **profil:**  
-- des informations de profil d'un compte  

> ## **Description des fonctions :**    
>> Dans le ficher Formateur.php : fonction ‘modifier’ permet de vérifier le role de compte connecté et vers les différents page accueil(menu_admin ou menu_forma), et modifier le mdp de cpt 
connecté !

> ## **Amélioration à apporter:**   
Eviter d'afficher les pages (de formateur ou d'admi) en entrant l'URL directemen
