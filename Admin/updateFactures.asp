<%
	If(Len(Session("IdUser")) = 0) Then
		Session("Msg") = "Veuillez vous identifier"
		Response.redirect "../connexion.asp"
	End If 

	Id=Request.QueryString("IdFacture")  

	Set cx=Server.CreateObject("ADODB.Connection")
	cx.Open Application("PC")
	Set Rs = Server.CreateObject("ADODB.RecordSet")

	req="select * from TFACTURES where IdFacture = (" & Id & ")"

	'Response.write req
	'Response.end
	rs.Open req , cx, 3,3
	Set Rs1 = Server.CreateObject("ADODB.RecordSet")
	Set Rs2 = Server.CreateObject("ADODB.RecordSet")
	req1 = "select Nomclient from TCLIENTS where IdClient = " & Rs("IdClient")
    req2 = "select * from Tclients order by  NomClient"

    on error resume next
	Rs1.Open req1, cx, 3,3
	if err.number <> 0 then
		response.write err.description & "<br> req1 : " & req1 
		response.end
	end if
    on error resume next
	Rs2.Open req2, cx, 3,3
	if err.number <> 0 then
		response.write err.description & "<br> req2 : " & req2 
		response.end
	end if

%>
<!DOCTYPE html>
<html>
<head>
	<title>Modifier une facture</title>
	<meta charset="utf-8"> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="styles/style.css">
	<link rel="stylesheet" href="styles/stylemenu.css">
	<script src="JS/com.js"></script>
	<script>
		function envoyer(madate)
		{
			if(!VerifDate(madate))
			{
				alert("Veuillez entrer une date correcte!");
				return;
			}
			document.getElementById("formulaireUpdtae").action = "updateActionFactures.asp";
			document.getElementById("formulaireUpdtae").method = "POST";
			document.getElementById("formulaireUpdtae").submit();
		}
	</script>
</head>
<body>
	<!-- #include virtual | file ="menu.html" -->
	<br>
		<center><h1> Modifier facture </h1></center>
	<div>
		<form id="formulaireUpdtae">
			<label for="Idclient"> Client </label>			
				<select name="Idclient" id="Idclient">
					<% While NOT Rs2.EOF %>
					<option value="<%=Rs2("Idclient")%>"><%=Rs2("NomClient") & " " & Rs2("PrenomClient")%></option>
					<%
						Rs2.movenext
						Wend
					%> 
					<option selected="selected"value="<%=Rs("Idclient")%>"> <%=Rs1("NomClient")%> </option>
				</select><br><br> 

			<label for="DateFacturation">Date Facturation</label>	<input type="text" id="dateFacturation" name="DateFacturation" value="<%=Rs("DateFacturation")%>"><br><br>		
			<center> <input type="button" value="CONFIRMER" onclick="javascript:envoyer(document.getElementById('dateFacturation').value);"> </center>

			<input type="hidden" name="IdFacture"  value="<%=Rs("IdFacture")%>">   
		</form>
   	</div>
</body>
</html>