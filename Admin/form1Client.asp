<%
	If(Len(Session("IdUser")) = 0) Then
    	Session("Msg") = "Veuillez vous identifier"
    	Response.redirect "../connexion.asp"
	End If 
	session("lastname") = ""
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HOTELS GROUPE - Clients</title>
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
            function GetClients(valeur, critere)
            {   
                
        		if (window.XMLHttpRequest) {// code pour IE7+, Firefox, Chrome, Opera, Safari
        		    xmlhttp = new XMLHttpRequest();
        		}
        		else {// code pour IE6, IE5
        		    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        		}
        		xmlhttp.onreadystatechange = function () {
        		    if ((xmlhttp.readyState == 4) && (xmlhttp.status == 200)) {
        		        document.getElementById('data').innerHTML = xmlhttp.responseText;
                        
        		    }
        		}
                xmlhttp.open("GET", "searchClient.asp?critere=" + critere + "&valeur="+ valeur, true);
        		xmlhttp.send();
        	}
			function rediriger()
			{
				var sel = document.getElementById("redirection").value;
				if(sel == "add")
					document.location = "clientformulaire.asp";
				else if(sel == "del")
					VerifS();
				else if(sel == "addFacture")
				{
					if(nbmc != 1)
					{
						alert("Veuillez selectionner un seul client!");
						return;
					}
					document.getElementById("formClients").action = 'formulaireInsertFacture.asp';
					document.getElementById("formClients").method = 'POST';
					document.getElementById("formClients").submit();
				}
				else if(sel == "selectFacture")
				{
					if(nbmc == 0)
					{
						alert("Veuillez selectionner un ou plusieurs clients!");
						return;
					}
					document.getElementById("formClients").action = 'selectAllFactures.asp';
					document.getElementById("formClients").method = 'POST';
					document.getElementById("formClients").submit();
				}
			}
            function Modifier(x)
            {
                document.location = "updateClient.asp?idClient="+x;
            }
			function VerifS()
			{
				if(nbmc == 0)
				{
					alert("Veuillez selectionner un ou plusieurs clients") ;
					return ;
				}
				document.getElementById("formClients").action = 'deleteClient.asp' ;
				document.getElementById("formClients").method = 'POST' ;
				document.getElementById("formClients").submit() ;
			}
		</script>
</head>

<body onload="NavSetActive2(1);">
	<header >
		<!-- on va inclure le fichier menu.inc in chaa Allah -->
		<!--#include file="menu.html"-->
	</header><br><br>
		<form id="formClients" class="formPC">
			<div class="DivHead">
				<table class="TabHead">
					<tr>
						<td colspan="3">Valeur recherhée</td>
						<td colspan="2">Objet de recherche</td>
						<!--<td rowspan="2">
							<input type="button" name="submitRech" value="rechercher" class="BTR" onclick="javascript:GetClients(document.getElementById('search').value,document.getElementById('typeRech').value);">
						</td>-->
					</tr>
					<tr onkeyup="javascript:GetClients(document.getElementById('search').value,document.getElementById('typeRech').value);">
						<td colspan="3">
							<input type="text" name="textRech" id="search" placeholder="saisir le text de recherche ...">
						</td>
						<td colspan="2">
							<select name="typeRech" id="typeRech" class="selectForm1" onchange="javascript:GetClients(document.getElementById('search').value,document.getElementById('typeRech').value);">
								<option value="nom">Nom</option>
								<option value="mail">e-mail</option>
								<option value="ville">Ville</option>
							</select>
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<select id="redirection" class="selectForm1">
								<option value="add">Ajouter</option>
								<option value="del">Supprimer</option>
								<option value="addFacture">Ajouter facture</option>
								<option value="selectFacture">Voir les factures</option>
							</select>
						</td>
						<td><input type="button" value="Effectuer l'opération" class="BTR" onclick="javascript:rediriger()"></td>
						<td style="width:30px;">
							<input type="button" value=">" class="BTR" onclick="javascript:GetClients(document.getElementById('search').value,document.getElementById('typeRech').value);">
						</td>
					</tr>
					<tr>
						<td><b>Nom</b></td>
						<td><b>Prénom</b></td>
						<td><b>Tél<b></td>
						<td><b>E-mail</b></td>
						<td style="width:30px;">
							<input type="checkbox" name="CBAll" id="CBSAll" onclick="javascript:SelectAll(this, document.getElementsByName('CBID'));">
						</td>
					</tr>
				</table>
			</div>
			
			<div id="data" class="DivData">
			
			</div>
		</form>
	</body>
</html>