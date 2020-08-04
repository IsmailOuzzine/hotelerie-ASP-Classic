<%
	If(Len(Session("IdUser")) = 0) Then
		Session("Msg") = "Veuillez vous identifier"
		Response.redirect "../connexion.asp"
	End If 

    session("lasthotel") = ""
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
		.TabHead tr td:nth-child(1), .TabData tr td:nth-child(1) {width: 160px;overflow: hidden;}
		.TabHead tr td:nth-child(2), .TabData tr td:nth-child(2) {width: 160px;overflow: hidden;}
		.TabHead tr td:nth-child(3), .TabData tr td:nth-child(3) {width: 160px;overflow: hidden;}
		.TabHead tr td:nth-child(4), .TabData tr td:nth-child(4) {width: 160px;overflow: hidden;}
        .TabHead tr td:nth-child(5), .TabData tr td:nth-child(5) {width: 190px;max-width:190px;overflow: hidden;white-space:nowrap;}
		.TabHead tr td:nth-child(6), .TabData tr td:nth-child(6) {width: 30px;overflow: hidden;}
		td{border: 0px solid #fff;}
	</style> 
	<script src="JS/com.js"></script>
    <script language="javascript">
			var nbm = 0;
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
			function rediriger()
			{
				var i, x = document.getElementById("redirection").value;
				if(x == "add")
					document.location = "formulaireInsertHotel.asp";
				else if(x == "del")
					VerifS();
				else if(x == "addChambre")
				{
					if(nbmc != 1)
					{
						alert("Veuillez selectionner un et un seul hotel") ;
						return ;
					}
					/*for(i=0;i<listCB.length;i++)
					{
						if(listCB[i].checked)
							var idhotel = listCB[i].value;
					} 
					document.location = "formulaireInsertChambre.asp?IdHotel=" + idhotel;*/
					document.getElementById("formHotels").action = 'formulaireInsertChambre.asp' ;
					document.getElementById("formHotels").method = 'POST' ;
					document.getElementById("formHotels").submit() ;
				}
				else if(x == "selectChambre")
				{
					if(nbmc == 0)
					{
						alert("Veuillez selectionner un ou plusieurs Hotels") ;
						return ;
					}
					document.getElementById("formHotels").action = 'form1Chambre.asp' ;
					document.getElementById("formHotels").method = 'POST' ;
					document.getElementById("formHotels").submit() ;
				}
			}
            function GetHotels(valeur, critere)
            {   
                /*alert("en execution... valeur= "+valeur+" - critere= "+critere);*/
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
                xmlhttp.open("GET", "searchHotel.asp?critere=" + critere + "&valeur="+ valeur, true);
        		xmlhttp.send();
				/*alert("fin de l'execution!");*/
        	}
            function Modifier(x)
			{      
				document.location = 'updateHotel.asp?IdHotel='+x ;
			}
			function VerifS()
			{
				if(nbmc == 0)
				{
					alert("Veuillez selectionner un ou plusieurs Hotels") ;
					return ;
				}
				document.getElementById("formHotels").action = 'deleteHotel.asp' ;
				document.getElementById("formHotels").method = 'POST' ;
				document.getElementById("formHotels").submit() ;
			}
    </script>
</head>
<body onload="NavSetActive2(2);">

    <header>
		<!-- on va inclure le fichier menu.inc in chaa Allah -->
		<!--#include file="menu.html"-->
	</header><br><br>
		<form id="formHotels" class="formPC">
			<div class="DivHead">
				<table class="TabHead">
					<tr>
						<td colspan="3">Valeur recherchée</td>
						<td colspan="2">Objet de recherche</td>
						<!--<td rowspan="2" colspan="2"> 
							<input type="button" name="submitRech" value="rechercher" class="BTR" onclick="javascript:GetHotels(document.getElementById('search').value,document.getElementById('typeRech').value);">
						</td>-->
					</tr>
					<tr onkeyup="javascript:GetHotels(document.getElementById('search').value,document.getElementById('typeRech').value);">
						<td colspan="3">
							<input type="text" name="textRech" style="width:100%;" id="search" placeholder="saisir le text de recherche ..." >
						</td>
						<td colspan="2">
							<select class="selectForm1" name="typeRech" id="typeRech">
								<option value="DesignationHotel">Désignation</option>
								<option value="mail">e-mail</option>
								<option value="ville">Ville</option>
							</select>
						</td>
					</tr>
                	<tr>
						<td colspan="2">
						<select class="selectForm1" id="redirection">
							<option value="add">Ajouter un hôtel</option>
							<option value="del">Supprimer</option>
							<option value="addChambre">Ajouter une chambre</option>
							<option value="selectChambre">Voir les chambre</option>
						</select>
						</td>
						<td colspan="2">
							<input type="button" value="Effectuer l'opération" class="BTR"  name="operations" onclick="javascript:rediriger()">
						</td>
						<td></td>
						<td style="width:30px;">
							<input type="button" value=">" class="BTR" onclick="javascript:GetHotels(document.getElementById('search').value,document.getElementById('typeRech').value);">
						</td>
					</tr>
					<tr>	
						<td><b>Désignation</b></td>
						<td><b>Ville</b></td>
						<td><b>Pays</b></td>
						<td><b>Tel</b></td>
						<td><b>Site</b></td>
						<td><input type="checkbox" name="CBAll" id="CBSAll" onclick="javascript:SelectAll(this, document.getElementsByName('IdHotel'));"></td>
					</tr>
				</table>
        </div>
        <div id="data" class="DivData">
			
        </div>
    </form>
</body>
</html>