<%
    If(Len(Session("IdUser")) = 0) Then
		Session("Msg") = "Veuillez vous identifier"
		Response.redirect "../connexion.asp"
	End If 
	'on doit récupérer idclient
	Id=Request.QueryString("IdPeriode")  

	Set cx=Server.CreateObject("ADODB.Connection")
	cx.Open Application("PC")
	Set Rs = Server.CreateObject("ADODB.RecordSet")

	req="select * from TPERIODES where IdPeriode = (" & Id & ")"

	'Response.write req
	'Response.end
	rs.Open req , cx, 3,3

%>
<!DOCTYPE html>
<html>
<head >

	<title> formulaire de modification </title>
	<meta charset="utf-8"> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" type="text/css" href="styles/style.css">
	<link rel="stylesheet" href="styles/stylemenu.css">
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
<body onload="NavSetActive2(4);">
	<header>
		<!-- on va inclure le fichier menu.inc in chaa Allah -->
		<!--#include file="menu.html"-->
	</header>
	<br><br>

	<center> <h1 id=" titre " > Modifier une Période </h1> </center>
	<div>
	<form action="updateActionPeriode.asp"  name="update"  id="formulaire"  method="post" width="100%">
		<label for="ID">ID</label>						<input type="text" name="IdPeriode" value="<%=Id%>" readonly><br><br>
		<label for="designation">Désignation</label>	<input type="text" name="DesignationPeriode" value="<%=Rs("DesignationPeriode")%>"><br><br>
		<label for="dateDeDebut">Date de début</label>	<input type="date" name="DateDebutPeriode" value="<%=Rs("DateDebutPeriode")%>"><br><br>
		<label for="DateDeFin">Date de fin</label>		<input type="date" name="DateFinPeriode" value="<%=Rs("DateFinPeriode")%>"><br><br>
      
      						<center> <input type="submit" value="CONFIRMER" style="width:30%"> </center>

        
   
	</form>
	</div>

</body>
</html>