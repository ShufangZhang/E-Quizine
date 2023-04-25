# **"e-quizine" - AGILE - Backlog produit -**   Liste des "User Stories" 
 
> ## **Auteurs**
>>  **Nom Prénom:** ZHANG Shufang  
>>  **Date:** 5/12/2022  

> ## **ID #1**
>> ### 1. **Template:**  
 **En tant que** visiteur/internaute, **je veux pouvoir** afficher la page d'accueil de l'application **afin de** connaître toutes les actualités sur les quiz et accéder au champ de saisie du code d'un match et au bouton de connexion.  
>> ### 2. **Description:** 
>>>    1. **Scénario nominal :**  
>>>> * l'affichage de la page d'accueil se fait grâce à l'URL du site Web (saisie manuelle dans un navigateur Web).  
>>>> * La page d'accueil affiche dans un tableau les actualités, le champ de saisie du code d'un match et un bouton (ou hyperlien) de connexion.

>>>    2. **Scénario non nominal :**  
>>>> * un visiteur n'est pas encore un joueur, il peut essayer de deviner le code du match qu'il ne connaît pas. Suite à la saisie et la validation d'un code erroné, un message d'erreur "code de match inexistant, veuillez saisir le code fourni par votre formateur !" s'affiche.  
>>>> *  S'il n'y a pas d'actualité, un message "Aucune actualité pour l'instant !" sera affiché sur la page d'accueil.
>>>> * S'il n'y a aucun match dans la base de données, un message "Aucun match pour l'instant !" sera affiché sur la page d'accueil.

>> ### 3. **Requête(s) SQL MariaDB à préparer :**  
>>> 1. requête qui récupère toutes les données des (5 dernières) actualités de la table des actualités, de l'actualité la plus récente à l'actualité la plus ancienne.
>>> 2. Requête qui vérifie l'existence de matchs dans la base de données de matchs et plus spécifiquement du match dont le code a été  saisi. 


> ## **ID #2**
>> ### 1. **Template:**  
 **En tant que** joueur, **je veux pouvoir** saisir un code de 8 caractères et un pseudo **afin de**participer à un match.  
>> ### 2. **Description:** 
>>>  1. **Scénario nominal :**
 Le joueur saisit, dans le champ du formulaire sur la page d'accueil, le code du match que le formateur lui a donné. Ensuite le joueur choisit un pseudo qui doit être unique dans la base. Après avoir fait cela, le joueur peut voir les informations concernant le match et l'ensemble des questions et des propositions de réponse du quiz correspondant.

>>>  2. **Scénario non nominal :**  
>>>> * si le joueur ne saisit pas de code de match dans le champ du formulaire affiché sur la page d'accueil, alors un message d'erreur est affiché "Veuillez saisir un code de match !", et la page d'accueil est rechargée (cf #1),  
>>>> * si le joueur saisit un code de match invalide (non existant), alors un message d'erreur est affiché "code de match non existant" et la page d'accueil est rechargée (cf #1),  
>>>> * si le joueur saisit un code de match correspondant à un quiz désactivé, alors un message d'erreur est affiché "Quiz du match désactivé" et la page d'accueil est rechargée (cf #1),  
>>>> * si le joueur saisit un code de match correspondant à un match désactivé / non démarré, alors un message d'erreur est affiché "Match désactivé ou non démarré" et la page d'accueil est rechargée (cf #1),  
>>>> * si le code est valide le joueur peut saisir un pseudo.  
>>>>> * Si le pseudo inventé par le joueur existe déjà pour le match (--> requête d'insertion impossible / ou requête de recherche du pseudo dans la base indique l'existence du pseudo dans la table), un message d'erreur ("pseudo déjà utilisé") s'affiche et on demande au joueur d'en choisir un autre, ou bien  
>>>>> * si le pseudo n'est pas bien formé (par exemple, il contient des caractères spéciaux non autorisés), un message d'erreur ("le pseudo contient des caractères non autorisés") s'affiche. Dans tous les cas le joueur peut quitter l'application Web à n'importe quel moment.

>> ### 3. **Requête(s) SQL MariaDB à préparer** :  
>>> 1. Requête vérifiant l’existence (ou non) du code d’un match  
>>> 2. Requête d’ajout du pseudo d’un joueur pour un match particulier dont l’ID est connu  
>>> 3. Requête vérifiant l’existence (ou non) d’un pseudo pour un match particulier
>>> 4. 1 SEULE requête permettant de récupérer toutes les données (questions, choix possibles) d’un questionnaire associé à un match dont on connaît le code
 
 > ## **ID #3**
>> ### 1. **Template:**  
 **En tant que** joueur, **je veux pouvoir** répondre aux questions du match **afin d’**obtenir mon score final (mon pourcentage (%) de bonnes réponses).
>> ### 2. **Description:** 
>>>    1. **Scénario nominal :**  
>>>> * Le joueur a saisi au préalable le code du match et inventé son pseudo pour participer au match.
>>>> * Le joueur accède à une page affichant pour le match choisi, dans l'ordre, les questions du quiz correspondant présentes dans la base de données et pour chaque question, les choix de réponses possibles.
(3 degrés de difficulté au choix :  
>>>>> 1) affichage du questionnaire complet -  
>>>>> 2) affichage des questions une par une -  
>>>>> 3) affichage des questions une par une avec gestion du temps pour donner la réponse). A noter : seul le degré de difficulté 1) est demandé !
>>>> * Le joueur doit répondre à ces questions en choisissant le numéro des choix ou en cliquant sur les propositions afin de les valider. Une fois le quiz terminé, on calcule le résultat du joueur sur ce match, c'est à dire le nombre de réponses correctes données par le joueur par rapport au nombre de bonnes réponses présentes dans la base de données pour le quiz correspondant au match (à donner en %). Enfin, le score du joueur est ensuite affiché.  


>>>    2. **Scénario non nominal :**  
>>>> * Si le joueur ne répond pas à une question, cette dernière est comptée comme fausse.

>>>> *  Si le joueur quitte le quiz avant la validation de ses réponses, les questions sont comptées comme fausses également. 


>> ### 3. **Requête(s) SQL MariaDB à préparer :**  
>>> 1. Requête qui récupère la réponse correcte d'une question particulière du quiz associé au match joué.
>>> 2. Requête qui comptabilise le nombre de questions d'un quiz associé au match.
>>> 3. Requête qui met à jour le score du joueur dont connaît le pseudo (et le code du match joué).

> ## **ID #4**
>> ### 1. **Template:**  
 **En tant que** joueur, **je veux pouvoir** (si le formateur l’a autorisé) visualiser le corrigé **afin
de** vérifier mes propres réponses. 
>> ### 2. **Description:** 
>>>    1. Le joueur participe au match qui s'affiche après saisie de son code et choix d'un pseudo en répondant aux questions du quiz. Après validation de ses choix, il obtient son score pour le match.

>>>    2. **2 degrés de difficulté :**  
>>>> * 1) Puis, si le formateur l'a autorisé, un bouton "Voir les bonnes réponses" est proposé au joueur après son score pour afficher un récapitulatif du questionnaire avec les bonnes réponses.
>>>> *  2) Si les questions sont affichées une par une, la réponse correcte à la question s'affiche dès que le joueur a validé sa réponse à la question.
>>>> * A noter : seul le degré de difficulté 1) est demandé ! 

>>>    3. Si le formateur n'a pas autorisé l'affichage du corrigé, rien n'est affiché à part le score obtenu.

>> ### 3. **Requête(s) SQL MariaDB à préparer :**  
>>> 1. Requête qui vérifie si le corrigé est autorisé pour le match (ou le quiz) joué
>>> 2. Requête qui récupère la réponse correcte d'une question particulière du quiz associé au match joué.
>>> 3. Requête permettant de récupérer toutes les données (questions, choix possibles) d’un questionnaire associé à un match dont on connaît le code


> ## **ID #5**
>> ### 1. **Template:**  
 **En tant qu'**administrateur, **je veux pouvoir** saisir mes identifiants personnels **afin d’**accéder à l’espace privé (back office) des administrateurs.  
>> ### 2. **Description:** 
>>>    1. **Scénario nominal :**  
>>>> * A partir de la page d'accueil de l'application Web, un bouton de connexion est affiché en haut de la page à droite, celui-ci renvoie vers une page de connexion.
>>>> * Sur la page de connexion, il y a un formulaire avec 2 champs de saisie, un pour l'identifiant, le second pour le mot de passe.
>>>> * On peut valider la saisie avec un bouton de validation. Si la saisie est correcte et correspond bien à un couple identifiant/mot de passe d'un administrateur dont le compte est activé et est présent dans la base, une session utilisateur est créée et l'administrateur est redirigé vers la page d'accueil de l'espace privé des administrateurs. Dans cet espace, l'administrateur dispose d'un menu lui permettant d'accéder à tous les outils disponibles pour les administrateurs. 


>>>    2. **Scénario non nominal :**  
>>>> * L'administrateur saisit de mauvais identifiants.
Un message d'erreur s'affiche : "Identifiants erronés ou inexistants !" puis la page de connexion est ré-affichée pour permettre une nouvelle saisie.
>>>> * L'administrateur ne remplit pas les 2 champs.
Un message d'erreur s'affiche : "Veuillez remplir tous les champs" puis la page de connexion est ré-affichée pour permettre une nouvelle saisie.
>>>> * Si un visiteur essaie d'accéder directement à la page d'accueil de l'espace administrateur (en saisissant l'URL de la page Web dans son navigateur Web) sans être connecté ; il est redirigé vers la page d’accueil (ou page de connexion).



>> ### 3. **Requête(s) SQL MariaDB à préparer :**  
>>> 1. Requête vérifiant l'existence ou non du couple pseudo/mot de passe (avec sel + sha256) saisi par l'utilisateur.



> ## **ID #6**
>> ### 1. **Template:**  
 **En tant qu'**administrateur, **je veux pouvoir** accéder à la page de mon profil afin de visualiser et modifier mes données personnelles.
>> ### 2. **Description:** 
>>>    1. **Scénario nominal :**  
>>>> * Une fois l'administrateur connecté, il a accès à l'espace de l'administrateur. Dans l'espace de l'administrateur, il a accès à une rubrique "profil" du menu. En cliquant sur cette rubrique du menu, il est redirigé vers une page qui lui permet de visualiser son profil (pseudo, ((nom, prénom)) ).

>>>> * A noter : pour le sprint 1, seul le mot de passe peut être modifié !

>>>> * Sur cette page, un bouton modifier (ou hyperlien) lui est proposé. En cliquant sur celui-ci, il est redirigé vers une troisième page avec des champs de saisie (("Nom", "Prénom")), "Mot de passe" et "Confirmation du mot de passe". ((Ces champs de saisie sont pré-remplis avec les informations de l'administrateur,)) le champ de saisie du mot de passe n'est pas pré-rempli et lors de la saisie du nouveau mot de passe, celui-ci sera caché ! Sur la page figurent également deux boutons ("Valider" et "Annuler"). Cliquer sur "Annuler" annule la procédure et redirige l'administrateur vers la page d'accueil de son espace. Cliquer sur le bouton "Valider" modifie les informations de l'administrateur.


>>>    2. **Scénario non nominal :**  
>>>> *  Si les informations saisies dans les champs "Mot de passe" et "Confirmation mot de passe" sont différents, le message "Confirmation du mot de passe erronée, veuillez réessayer !".


>>>> *  Si un des champs de saisie n'est pas rempli, le message "Champs de saisie vides !" apparaît. Puis, l'administrateur est redirigé vers la page de modification de son profil.  
**Attention, l'administrateur ne peut pas modifier son pseudo.**

>>>> *  Si un visiteur essaie d'accéder directement à la page (en saisissant son URL dans son navigateur Web) sans être connecté ; il est redirigé vers la page d’accueil (ou page de connexion) du site Web.

>> ### 3. **Requête(s) SQL MariaDB à préparer :**  
>>> 1. Requête récupérant les données de l'administrateur connecté.
>>> 2. Requête mettant à jour les données modifiées (uniquement le mot de passe pour le sprint 1) par l'administrateur dans son profil.


> ## **ID #7**
>> ### 1. **Template:**  
 **En tant qu'**administrateur, **je veux pouvoir** cliquer sur le bouton « déconnexion » afin de me déconnecter de l’espace privé des administrateurs.
>> ### 2. **Description:** 
>>>    1. **Scénario nominal :**  
>>>> * Lorsque l'administrateur est connecté, le menu comporte notamment un bouton « Déconnexion » qui permet à l’utilisateur de fermer sa session.


>>>    2. **Scénario non nominal :**  
>>>> *  Si l'administrateur ne se déconnecte pas mais ferme juste la fenêtre -> il est déconnecté au bout d'un certain temps.

>> ### 3. **Requête(s) SQL MariaDB à préparer :**  
>>> 1. **AUCUNE !**  
Il faut détruire la session PHP (session_destroy() ou $this->session->sess_destroy() dans le contrôleur) si elle existe.


> ## **ID #8**
>> ### 1. **Template:**  
 **En tant que** formateur, **je veux pouvoir** saisir mes identifiants personnels **afin d’**accéder à l’espace privé (back office) des formateurs.
>> ### 2. **Description:** 
>>>    1. **Scénario nominal :**  
>>>> * A partir de la page d'accueil de l'application Web, un bouton de connexion est affiché en haut de la page à droite, celui-ci renvoie vers une page de connexion.
>>>> * Sur la page de connexion, il y a un formulaire avec 2 champs de saisie, un pour l'identifiant, le second pour le mot de passe.
>>>> * On peut valider la saisie avec un bouton de validation. Si la saisie est correcte et correspond bien à un couple identifiant/mot de passe d'un administrateur dont le compte est activé et est présent dans la base, une session utilisateur est créée et le formateur est redirigé vers la page d'accueil de l'espace privé des formateurs. Dans cet espace, le formateur  dispose d'un menu lui permettant d'accéder à tous les outils disponibles pour les formateurs.

>>>    2. **Scénario non nominal :**  
>>>> * Le formateur saisit de mauvais identifiants.  
Un message d'erreur s'affiche : "Identifiants erronés ou inexistants !" puis la page de connexion est ré-affichée pour permettre une nouvelle saisie.
>>>> * Le formateur ne remplit pas les 2 champs.  
Un message d'erreur s'affiche : "Veuillez remplir tous les champs" puis la page de connexion est ré-affichée pour permettre une nouvelle saisie.
>>>> * Si un visiteur essaie d'accéder directement à la page d'accueil de l'espace formateur (en saisissant l'URL de la page Web dans son navigateur Web) sans être connecté ; il est redirigé vers la page d’accueil (ou page de connexion).

>> ### 3. **Requête(s) SQL MariaDB à préparer :**  
>>> 1. Requête vérifiant l'existence ou non du couple pseudo/mot de passe (avec sel + sha256) saisi par l'utilisateur. 


> ## **ID #9**
>> ### 1. **Template:**  
 **En tant que** formateur, **je veux pouvoir** accéder à la page de mon profil **afin de** visualiser et modifier mes données personnelles.
>> ### 2. **Description:** 
>>>    1. **Scénario nominal :**  
>>>> * Une fois le formateur connecté, il a accès à l'espace formateur. Dans cet espace, il a accès à une rubrique "profil" du menu. En cliquant sur cette rubrique du menu, il est redirigé vers une page qui lui permet de visualiser son profil (pseudo, ((nom, prénom)) ).

>>>> * A noter : pour le sprint 1, seul le mot de passe peut être modifié !

>>>> * Sur cette page, un bouton modifier (ou hyperlien) lui est proposé. En cliquant sur celui-ci, il est redirigé vers une troisième page avec des champs de saisie (("Nom", "Prénom")), "Mot de passe" et "Confirmation du mot de passe". ((Ces champs de saisie sont pré-remplis avec les informations de l'administrateur,)) le champ de saisie du mot de passe n'est pas pré-rempli et lors de la saisie du nouveau mot de passe, celui-ci sera caché ! 
>>>> * Sur la page figurent également deux boutons ("Valider" et "Annuler"). Cliquer sur "Annuler" annule la procédure et redirige l'administrateur vers la page d'accueil de son espace. Cliquer sur le bouton "Valider" modifie les informations de l'administrateur.

>>>    2. **Scénario non nominal :**  
>>>> * Si les informations saisies dans les champs "Mot de passe" et "Confirmation mot de passe" sont différents, le message "Confirmation du mot de passe erronée, veuillez réessayer !".

>>>> * Si un des champs de saisie n'est pas rempli, le message "Champs de saisie vides !" apparaît.  
Puis, le formateur est redirigé vers la page de modification de son profil.

>>>> * Attention, le formateur ne peut pas modifier son pseudo.

 >>>> * Si un visiteur essaie d'accéder directement à la page (en saisissant son URL dans son navigateur Web) sans être connecté ; il est redirigé vers la page d’accueil (ou page de connexion) du site Web.

>> ### 3. **Requête(s) SQL MariaDB à préparer :**  
>>> 1. Requête récupérant les données du formateur connecté.

>>> 2. Requête mettant à jour les données modifiées (uniquement le mot de passe pour le sprint 1) par le formateur dans son profil.


> ## **ID #10**
>> ### 1. **Template:**  
 **En tant que** formateur, **je veux pouvoir** cliquer sur le bouton « déconnexion » afin de me déconnecter de l’espace privé des formateurs.
>> ### 2. **Description:** 
>>>    1. **Scénario nominal :**  
>>>> * Lorsque le formateur est connecté, le menu comporte notamment un bouton « Déconnexion » qui permet à l’utilisateur de fermer sa session.

>>>    2. **Scénario non nominal :**  
>>>> * Si le formateur ne se déconnecte pas mais ferme juste la fenêtre -> il est déconnecté au bout d'un certain temp

>> ### 3. **Requête(s) SQL MariaDB à préparer :**  
>>> 1. **AUCUNE !**  
Il faut détruire la session PHP (session_destroy() ou $this->session->sess_destroy() dans le contrôleur) si elle existe.

> ## **ID #11**
>> ### 1. **Template:**  
 **En tant que** formateur, **je veux pouvoir** choisir un quiz parmi tous les quiz existants afin de créer un match (dont le code sera généré).
>> ### 2. **Description:** 
>>>    1. **Scénario nominal :**  
>>>> *  Une fois que le formateur est connecté à son espace privé, il a accès à une rubrique "Matchs" dans le menu des formateurs.
>>>> * Une fois dans la rubrique de gestion des matchs, le formateur peut alors visualiser sous forme d'un tableau tous les quiz actifs (titre/description/auteur) et les matchs correspondants (titre, dates, auteur), s'il y en a.

>>>> * Le formateur peut ensuite cliquer sur un bouton "ccéer un match" puis compléter et valider le formulaire d'ajout des informations du nouveau match associé à un quiz choisi. Un code de match de 8 caractères est généré par l'application.

>>>    2. **Scénario non nominal :**  
>>>> * Si le formateur ne se déconnecte pas mais ferme juste la fenêtre -> il est déconnecté au bout d'un certain temp
>>>> * Si le quiz choisi pour le match est incomplet (aucune question dans ce quiz ==> à faire pour le sprint 2, des questions sans réponse (gestion dans le sprint 3, cf A noter 2), ...), un message d'erreur "Quiz incomplet !" s'affiche, le match n'est pas créé et le formateur est renvoyé vers la page de gestion des matchs.

>>>> * **A noter 1 :** on peut choisir d'indiquer dans le tableau les quiz incomplets pour lesquels on ne peut pas créer de match.

>>>> * **A noter 2 :** on pourra prévoir dans le sprint 3 l'impossibilité de créer une question sans propositions de réponses associées !

>>>> * Des messages d'erreurs sont à prévoir si un champ de saisie pour l'ajout du match est : vide / erroné / non conforme aux attentes.
>>>> * Si un visiteur essaie d'accéder directement à la page (en saisissant son URL dans son navigateur Web) sans être connecté ; il est redirigé vers la page
d’accueil.
>> ### 3. **Requête(s) SQL MariaDB à préparer :**  
>>> 1. Requête listant tous les quiz (intitulé et auteur) et les matchs associés (intitulé,  auteur et dates)
>>> 1. Requête qui vérifie si un quiz a des questions (ou non)
>>> 1. Requête qui insère un nouveau match associé au quiz choisi avec comme auteur le formateur connecté.



> ## **ID #12**
>> ### 1. **Template:**  
 **En tant que** formateur, **je veux pouvoir** sélectionner un match (un des miens) afin de le désactiver/activer, le supprimer, le remettre à zéro (R.A.Z.), le modifier.
>> ### 2. **Description:** 
>>>    1. **Scénario nominal :**  
>>>> *  Une fois que le formateur est connecté à son espace privé, il a accès à une rubrique "Matchs" dans le menu des formateurs.
>>>> * Une fois dans la rubrique de gestion des matchs, le formateur peut alors visualiser sous forme d'un tableau tous les quiz actifs (titre/description/auteur) et les matchs correspondants (titre, dates, auteur), s'il y en a.

>>>> * Dans le tableau, les matchs actifs du formateur connecté présentent les possibilités suivantes sur chaque ligne : modifier (pas demandé pour le sprint 2), supprimer, activer/désactiver, remettre à zéro, afficher le match (cf #21).
>>>> *Un formateur ne peut pas activer un match auparavant désactivé par un administrateur (pas demandé pour le sprint 2).

>>>> * La suppression d'un match sélectionné supprimera le match et l'ensemble des données associées au match, comme les participants au match et leur score.
>>>> * La remise à zéro d'un match sélectionné, c'est à dire la modification de la date de début (date à venir) et la remise à NULL de la date de fin supprimera les participants au match et leur score..

>>>    2. **Scénario non nominal :**  
>>>> * Des messages d'erreurs sont à prévoir si un champ de saisie pour la modification (RAZ) du match est : vide / erroné / non conforme aux attentes.
>>>> * Si un visiteur essaie d'accéder directement à la page (en saisissant son URL dans son navigateur Web) sans être connecté ; il est redirigé vers la page d’accueil.
>> ### 3. **Requête(s) SQL MariaDB à préparer :**  
>>> 1. Requête listant tous les quiz (intitulé et auteur) et les matchs associés (intitulé, auteur, dates)
>>> 1. Requête(s) permettant de supprimer complètement le match choisi
>>> 1. Requête permettant d'activer / désactiver un match
>>> 1. Requête (+ code SQL/PSM !) permettant de remettre à zéro le match choisi

> ## **ID #13**
>> ### 1. **Template:**  
 **En tant que** formateur, **je veux pouvoir** hoisir un match **afin de** visualiser / projeter son code et ses questions (+ choix de réponse).
>> ### 2. **Description:** 
>>>    1. **Scénario nominal :**  
>>>> *  l'ensemble des joueurs étant prêts, le formateur connecté choisit le match concerné (activé avec la date de début correcte) depuis la rubrique "Matchs" de son espace privé. Les informations du match (code du match, intitulé,...) et les questions activées sont affichées sur l'écran du formateur et peuvent être vidéo-projetées sur l'écran de vidéo-projection (cf #3, comme pour chaque joueur, toutes les questions sont affichées en une fois, [ou une par une]) avec leurs propositions de réponses possibles.
>>>> * Une fois la session finie par tous les joueurs, le formateur clique sur un bouton "Terminer le match" pour afficher (et vidéo-projeter) les résultats.
>>>    2. **Scénario non nominal :**  
>>>> * Si un visiteur essaie d'accéder directement à la page Web (en saisissant son URL dans son navigateur Web) sans être connecté ; il est redirigé vers la page d’accueil.

>> ### 3. **Requête(s) SQL MariaDB à préparer :**  
>>> 1. 1 SEULE requête permettant de récupérer toutes les données (questions, choix
possibles) d’un questionnaire associé à un match dont on connaît le code
>>> 1. Requête de modification d’un match (==> mise à jour de la date du fin du match à maintenant)
>>> 1. Requête listant les scores finaux et les pseudos des joueurs d’un match particulier
>>> 1. Requête donnant le nombre de joueurs d’un match particulier
>>> 1. Requête permettant de donner le score final d’un match particulier