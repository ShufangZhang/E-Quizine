<DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>E-Quizine</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="<?php echo base_url();?>style/assets/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="<?php echo base_url();?>style/css/styles.css" rel="stylesheet" />
    </head>
    <body id="page-top">
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top" id="mainNav">
            <div class="container">
                <a class="navbar-brand" href="#page-top">E-Quizine</a>
                <button class="navbar-toggler text-uppercase font-weight-bold bg-primary text-white rounded" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    Menu
                    <i class="fas fa-bars"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ms-auto">
						<li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href=<?php  echo base_url(). "index.php/compte/profil"?>>Profil</a></li>
                        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href=<?php  echo base_url(). "index.php/compte/creer"?>>new compte</a></li>
                        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href=<?php  echo base_url(). "index.php/compte/lister"?>>all compte</a></li>
                        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href=<?php  echo base_url(). "index.php/compte/deconnecter"?>>deconnection</a></li>
                        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="#contact">Contact</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- Masthead-->
        <header class="masthead bg-primary text-white text-center">
            <div class="container d-flex align-items-center flex-column">
                <!-- Masthead Avatar Image-->
                <img class="masthead-avatar mb-5" src="<?php echo base_url();?>style/assets/img/avataaars.svg" alt="..." />
                
 <table class="table table-bordered">

<thead>
<tr>
<th>pseudo</th>
<th>nom</th>

<th>prenom</th>
 <th>id</th>
 <th>role</th>
 <th>etat</th>

</tr>
</thead>

<tbody>

<h1><?php echo $titre;?></h1>
<br />
<?php
if($info!=null){ 
foreach($info as $m){
    echo "<tr>";
    echo "<td>";echo $m["cpt_pseudo"];echo "</td>";
    echo "<td>";echo $m["plf_nom"];echo "</td>";

    echo "<td>";echo $m["plf_prenom"];echo "</td>";
    echo "<td>";echo $m["cpt_id"];echo "</td>";
    echo "<td>";echo $m["plf_role"];echo "</td>";
    echo "<td>";echo $m["plf_etat"];echo "</td>";
    
}
}
else {echo "<br />";
echo "Aucun compte !";
}
?>