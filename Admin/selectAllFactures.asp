<%
	If(Len(Session("IdUser")) = 0) Then
		Session("Msg") = "Veuillez vous identifier"
		Response.redirect "../connexion.asp"
	End If 

	ListID=Request.form("CBID")

	Set cx = Server.CreateObject("ADODB.Connection")
	cx.Open Application("PC")  
	Set Rs = Server.CreateObject("ADODB.RecordSet")

	req = "select TFACTURES.*, NomClient, PrenomClient from TFACTURES, TCLIENTS where (TFACTURES.IdClient = TCLIENTS.IdClient) and TCLIENTS.IdClient IN (" & ListID & ") ORDER BY NomClient"
	'response.write req
	'response.End
	Rs.Open req, cx, 3,3
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HOTELS GROUPE - Factures</title>
    <link rel="stylesheet" href="styles/styleform.css">
    <link rel="stylesheet" href="styles/stylemenu.css">
	<style>
		.TabHead tr td:nth-child(1), .TabData tr td:nth-child(1) {width: 160px;}
		.TabHead tr td:nth-child(2), .TabData tr td:nth-child(2) {width: 160px;}
		.TabHead tr td:nth-child(3), .TabData tr td:nth-child(3) {width: 150px;}
		.TabHead tr td:nth-child(4), .TabData tr td:nth-child(4) {width: 300px;}
		.TabHead tr td:nth-child(5), .TabData tr td:nth-child(5) {width: 30px; text-align:center;}
		td{border: 0px solid lightgreen;}
	</style> 
	<script src="JS/com.js"></script>
    <script language="javascript">
			var nbm = 0 ;
			var nbmc = 0 ;
            function SelectAll(cbg, VCBM)
			{
				var i;
				nbm = VCBM.length ;
				for(i = 0 ; i < nbm ; i++)
				{
					VCBM[i].checked = cbg.checked ;
				}
				if(cbg.checked)
				{
					nbmc = nbm ;
				}
				else
				{
					nbmc = 0 ;
				}
			}
			function SetChange(cbm, cbg, VCBM)
			{
				nbm = VCBM.length ;
				if(cbm.checked)
				{
					nbmc++ ;
					if(nbmc == nbm)
					{
						cbg.checked = true ;
						/*alert("nombre de checkbox cochees: "+nbmc+" nbm: "+nbm);*/	
					}
				}
				else
				{
					nbmc-- ;
					cbg.checked = false ;
					/*alert("nombre de checkbox cochees: "+nbmc+" nbm: "+nbm);*/					
				}
			}
            function Modifier(x)
			{      
				document.location = "updateFactures.asp?IdFacture="+x ;
			}
			function VerifS()
			{
				if(nbmc == 0)
				{
					alert("Veuillez selectionner une ou plusieures factures") ;
					return ;
				}
				document.getElementById("formFactures").action = 'deleteFactures.asp' ;
				document.getElementById("formFactures").method = 'POST' ;
				document.getElementById("formFactures").submit() ;
			}
		</script>
</head>

<body onload="NavSetActive2(1);">
	<header >
		<!-- on va inclure le fichier menu.inc in chaa Allah -->
		<!--#include file="menu.html"-->
	</header><br><br>
		<form id="formFactures" class="formPC">
			<div class="DivHead">
				<table class="TabHead">					
					<tr>
						<td colspan="3"><h1>Liste des factures</h1></td>
						<td clospan="2"><input type="button" value="Suprimmer facture(s)" class="BTR" onclick="javascript:VerifS()"></td>						
					</tr>
					<tr>
						<td><b>ID Facture</b></td>
						<td><b>ID client</b></td>
						<td><b>Nom & Prenom</b></td>
						<td><b>Date de Facturation</b></td>						
						<td style="width:30px;">
							<input type="checkbox" name="CBAll" id="CBSAll" onclick="javascript:SelectAll(this, document.getElementsByName('CBID'));">
						</td>
					</tr>
				</table>
			</div>
			
			<div id="data" class="DivData">
				<table class="TabData">
					<% WHILE NOT Rs.EOF %> 
					<tr ondblclick="javascript:Modifier(<%=Rs("IdFacture")%>);">
						<td><%=Rs("IdFacture")%></td>
						<td><%=Rs("IdClient")%></td>
						<td><%=Rs("NomClient") & " " & Rs("PrenomClient")%></td>
						<td><%=Rs("DateFacturation")%></td>						
						<td>
							<input type="checkbox" name="CBID" id="CBID_<%=Rs("IdFacture")%>" value="<%=Rs("IdFacture")%>" onclick="javascript:SetChange(this, document.getElementById('CBSAll'), document.getElementsByName('CBID'));">
						</td>
					</tr>
					<%
						Rs.movenext
						WEND
					%>
				</table>			
			</div>
		</form>
	</body>
</html>