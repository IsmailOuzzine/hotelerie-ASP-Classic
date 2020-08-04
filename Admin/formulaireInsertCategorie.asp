<%
    If(Len(Session("IdUser")) = 0) Then
		Session("Msg") = "Veuillez vous identifier"
		Response.redirect "../connexion.asp"
	End If 
%>
<!DOCTYPE html>
<html>
<head >

	<title> Ajouter une nouvelle Catégorie</title>
	<meta charset="utf-8"> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" type="text/css" href="styles/style.css">
	<link rel="stylesheet" href="styles/stylemenu.css">
	<style> #formulaire{height:100px;}</style>
	<script src="JS/com.js"></script>
    <script>
        function responsiveClass()
			{
				var x = document.getElementById("menu");
				if(x.className === "topnav")
				{
					x.className = "responsive";
				}
				else
				{
					x.className = "topnav";
				}
			}
    </script>
</head>
<body onload="NavSetActive2(3);">

	<header>
		<!-- on va inclure le fichier menu.inc in chaa Allah -->
		<!--#include file="menu.html"-->
	</header>
	<br><br><br>
	<center> <h1 id=" titre " > Ajouter une Catégorie </h1> </center>
	<div>
	<form action="insertCategorie.asp"  name="inscription"  id="formulaire"  method="post" style="padding-bottom:0;">	
		<label for="designation">Désignation</label>	<input type="text" name="DesignationCategorie" placeholder="écrire la désignation..." style="width: 70%;"> <br>
      
		<center> <input type="submit" value="AJOUTER"> </center>   
	</form>
	</div>

</body>
</html>