<%
    If(Len(Session("IdUser")) = 0) Then
		Session("Msg") = "Veuillez vous identifier"
		Response.redirect "../connexion.asp"
	End If 
	session("lastcat") = ""
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulaire de base</title>
    <link rel="stylesheet" href="styles/styleform.css">
    <link rel="stylesheet" href="styles/stylemenu.css">
	<style>
		.TabHead tr td:nth-child(1) {width: 400px;}
		.TabData tr td:nth-child(1) {width: 770px;} 
		.TabHead tr td:nth-child(2) {width: 300px;}
		.TabData tr td:nth-child(2) {width: 30px; text-align:right;}
		.TabHead tr td:nth-child(3) {width:100px; text-align:right;}
		td{border: 0px solid red;}
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
            function GetCategories(valeur, critere)
            {   
                /*alert("debut");*/
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
                xmlhttp.open("GET", "searchCategorie.asp?critere=" + critere + "&valeur="+ valeur, true);
        		xmlhttp.send();
        	}
			function rediriger()
			{
				var sel = document.getElementById("redirection").value;
				if(sel == "add")
					document.location = "formulaireInsertCategorie.asp";
				else if(sel == "del")
					VerifS();
			}
            function Modifier(x)
            {
                document.location = "updateCategorie.asp?idCategorie="+x;
            }
			function VerifS()
			{
				if(nbmc == 0)
				{
					alert("Veuillez selectionner une ou plusieurs Categories") ;
					return ;
				}
				document.getElementById("formCategories").action = 'deleteCategorie.asp' ;
				document.getElementById("formCategories").method = 'POST' ;
				document.getElementById("formCategories").submit() ;
			}
	</script>
</head>

<body onload="NavSetActive2(3);">
	<header >
		<!-- on va inclure le fichier menu.inc in chaa Allah -->
		<!--#include file="menu.html"-->
	</header><br><br>
		<form id="formCategories" class="formPC">
			<div class="DivHead">
				<table class="TabHead">
					<tr>
						<td>Valeur recherchée</td>
						<td>Objet de recherche</td>
						<td rowspan="2">
							<input type="button" name="submitRech" value="rechercher" class="BTR" onclick="javascript:GetCategories(document.getElementById('search').value,document.getElementById('typeRech').value);">
						</td>
					</tr>
					<tr onkeyup="javascript:GetCategories(document.getElementById('search').value,document.getElementById('typeRech').value);">
						<td>
							<input type="text" name="textRech" id="search" placeholder="saisir le nom de recherche ..." >
						</td>
						<td>
							<select name="typeRech" id="typeRech" class="selectForm1">
								<option value="designation">Désignation</option>
								<option value="idCategorie">ID</option>
							</select>							
						</td>
					</tr>
					<tr>
						<td>
							<select class="selectForm1" id="redirection">
								<option value="add">Ajouter</option>
								<option value="del">Supprimer</option>
							</select>
						</td>
						<td><input type="button" value="Effectuer l'opération" class="BTR" onclick="javascript:rediriger();"></td>
						<td><input type="button" value=">" class="BTR" onclick="javascript:GetCategories(document.getElementById('search').value,document.getElementById('typeRech').value);"></td>
					</tr>
					<tr>
						<td colspan="2" style="width:700px;"><b>Désignation</b></td>
						<td style="width:100px; text-align:right;">
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