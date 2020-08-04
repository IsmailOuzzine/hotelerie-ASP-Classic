<%
    If(Len(Session("IdUser")) = 0) Then
		Session("Msg") = "Veuillez vous identifier"
		Response.redirect "../connexion.asp"
	End If 
%>
<!DOCTYPE html>
<html>
<head >

	<title> Ajouter une nouvelle période</title>
	<meta charset="utf-8"> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" type="text/css" href="styles/style.css">
	<link rel="stylesheet" href="styles/stylemenu.css">
	<script src="JS/com.js"></script>
    <script>
			function verifD(date1, date2) {
			if (date1 > date2) 
			{
				alert("!!! la premiere date est superieur a la deuxieme");
				return;
			}
			document.getElementById("formulaire").submit();
			}
    </script>
</head>
<body onload="NavSetActive2(4);">

	<header>
		<!-- on va inclure le fichier menu.inc in chaa Allah -->
		<!--#include file="menu.html"-->
	</header>
	<br><br>

	<center> <h1 id=" titre " > Ajouter une Période </h1> </center>
	<div>
	<form action="insertPeriode.asp" id="formulaire" method="post">	
		<label for="designation">Désignation</label>	<input type="text" name="DesignationPeriode" id="DesignationPeriode" style="width: 70%; margin-top: 5px;"><br>
		<label for="dateDeDebut">Date de début</label>	<input type="date" name="DateDebutPeriode" id="DateDebutPeriode" style="width: 70%; margin-top: 5px;"><br>
		<label for="DateDeFin">Date de fin</label>		<input type="date" name="DateFinPeriode" id="DateFinPeriode" style="width: 70%; margin-top: 5px;"><br>
      
		<center> <input type="button" value="AJOUTER" onclick="verifD(document.getElementById('DateDebutPeriode').value, document.getElementById('DateFinPeriode').value);"> </center>   
</form>
</div>

</body>
</html>