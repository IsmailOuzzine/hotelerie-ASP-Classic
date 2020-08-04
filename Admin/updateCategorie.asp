<%
    If(Len(Session("IdUser")) = 0) Then
		Session("Msg") = "Veuillez vous identifier"
		Response.redirect "../connexion.asp"
	End If 
	'on doit récupérer idCategorie
	Id=Request.QueryString("IdCategorie")  

	Set cx=Server.CreateObject("ADODB.Connection")
	cx.Open Application("PC")
	Set Rs = Server.CreateObject("ADODB.RecordSet")

	req="select * from TCATEGORIES where IdCategorie = (" & Id & ")"

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
<body onload="NavSetActive2(3);">




	<header>
		<!-- on va inclure le fichier menu.inc in chaa Allah -->
		<!--#include file="menu.html"-->
	</header>
	<br><br>

	<center><h1 id="titre"> Modifier la catégorie </h1></center>
	<div>
	<form action="updateActionCategorie.asp"  name="update"  id="formulaire"  method="post">
	<table>
		<tr>
			<td><label for="ID">ID</label></td>	<td><input type="text" name="IdCategorie" value="<%=Id%>" readonly><br></td>
		</tr>
		<tr>
			<td><label for="designation">Désignation</label></td>	<td><input type="text" name="DesignationCategorie" value="<%=Rs("DesignationCategorie")%>"><br></td>
		</tr>
	</table>
      
      						<center> <input type="submit" value="CONFIRMER" style="width:30%"> </center>

        
   
</form>
   
</div>

</body>
</html>