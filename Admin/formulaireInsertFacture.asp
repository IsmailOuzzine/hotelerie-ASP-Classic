<% 
	If(Len(Session("IdUser")) = 0) Then
		Session("Msg") = "Veuillez vous identifier"
		Response.redirect "../connexion.asp"
	End If 

	IdClient=Request("CBID")
    Set cx = Server.CreateObject("ADODB.Connection")
    cx.Open Application("PC")
   
    Set Rs2 = Server.CreateObject("ADODB.RecordSet")
    req2 = "select NomClient, PrenomClient from Tclients Where IdClient = " & IdClient

    on error resume next
	Rs2.Open req2, cx, 3,3
	if err.number <> 0 then
		response.write err.description & "<br> req2 : " & req2 
		response.end
	end if

	NomComplet = Rs2("NomClient") & " " & Rs2("PrenomClient")
%>
<!DOCTYPE html>
<html>
<head >
	<title> Ajouter une facture</title>
	<meta charset="utf-8"> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" type="text/css" href="styles/style.css">
	<link rel="stylesheet" href="styles/stylemenu.css">
	<style>
		#titre{display:block;margin:0 auto;}
	</style>
	 <script src="JS/com.js"></script>
</head>
<body onload="NavSetActive2(1);">
	<header >
		<!-- on va inclure le fichier menu.inc in chaa Allah -->
		<!--#include file="menu.html"-->
	</header><br><br><br>
	<h1 id="titre"> Ajouter une facture </h1>
	<div>
	<form action="insertfactures.asp" id="formulaire" method="post">
		<label for="NameClient"> Client </label>					<input type="text" name="NameClient" id="NameClient" value="<%=NomComplet%>">	<br><br> 
		<label for="DateFacturation">Date Facturation</label>	<input type="Date" name="DateFacturation" id="DateFacturation">				<br><br>
		<input type="hidden" name="IdClient" value="<%=IdClient%>">
		<center> <input type="submit" value="AJOUTER"> </center>
	</form>
	</div>
	<script>
		document.getElementById("NameClient").setAttribute("readonly",""); 
		document.getElementById("DateFacturation").setAttribute("required","")
	</script>
</body>
</html>