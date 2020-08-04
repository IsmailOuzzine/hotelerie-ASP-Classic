<%
	If(Len(Session("IdUser")) = 0) Then
    	Session("Msg") = "Veuillez vous identifier"
    	Response.redirect "../connexion.asp"
	End If 
	'session("lastname") = ""
    IdHotels=Request("IdHotel")
    
    Set cx=Server.CreateObject("ADODB.Connection")
	cx.Open Application("PC")
	Set Rs = Server.CreateObject("ADODB.RecordSet")

	req="select top 30 * from TCHAMBRES, THOTELS, TCATEGORIES where (TCHAMBRES.IdHotel = THOTELS.IdHotel) AND (TCHAMBRES.IdCategorie = TCATEGORIES.IdCategorie) AND (TCHAMBRES.IdHotel in (" & IdHotels & ")) order by THOTELS.DesignationHotel, TCHAMBRES.NumeroChambre, TCATEGORIES.IdCategorie"

	'Response.write req
	'Response.end
	rs.Open req , cx, 3,3
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
		.TabHead tr td:nth-child(1), .TabData tr td:nth-child(1) {width: 200px;max-width: 250px;}
		.TabHead tr td:nth-child(2), .TabData tr td:nth-child(2) {width: 100px;}
		.TabHead tr td:nth-child(3), .TabData tr td:nth-child(3) {width: 220px;}
		.TabHead tr td:nth-child(4), .TabData tr td:nth-child(4) {width: 120px;}
		.TabHead tr td:nth-child(5), .TabData tr td:nth-child(5) {width: 120px;}
		.TabHead tr td:nth-child(6), .TabData tr td:nth-child(6) {width: 30px;}
		.CBID{margin:auto;}
		td{border: 0px solid white;}
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
            /*function GetChambre(valeur, critere)
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
                xmlhttp.open("GET", "searchChambre.asp?critere=" + critere + "&valeur="+ valeur, true);
        		xmlhttp.send();
        	}*/

            function Modifier(x)
            {
                document.location = "updateChambre.asp?IdChambre="+x;
            }
			function VerifS()
			{
				if(nbmc == 0)
				{
					alert("Veuillez selectionner une ou plusieurs chambres") ;
					return ;
				}
				document.getElementById("formChambre").action = 'deleteChambreAction.asp' ;
				document.getElementById("formChambre").method = 'POST' ;
				document.getElementById("formChambre").submit() ;
			}
	</script>
</head>

<body onload="NavSetActive2(2);">
	<header >
		<!-- on va inclure le fichier menu.inc in chaa Allah -->
		<!--#include file="menu.html"-->
	</header><br><br>
		<form id="formChambre" class="formPC">
			<div class="DivHead">
				<table class="TabHead">
					<tr>
						<td colspan="4"><h1>Liste des chambres</h1></td>
						<td colspan="2"><input type="button" class="BTR" id="suprimmer" value="Suprimmer" onclick="VerifS();"></td>
					</tr>
					<tr>
						<td><b>Hôtel</b></td>
						<td><b>Numéro</b></td>
						<td><b>Catégorie<b></td>
						<td><b>Tél</b></td>
                        <td><b>Nb.Personnes</b></td>
						<td>
							<input type="checkbox" name="CBAll" id="CBSAll" onclick="javascript:SelectAll(this, document.getElementsByName('CBID'));">
						</td>
					</tr>
				</table>
			</div>
			
			<div id="data" class="DivData">
				<table class="TabData">
					<% While NOT Rs.EOF%>
					<!--<%=Rs("DesignationHotel")%>-->
					<tr ondblclick="Modifier(<%=Rs("IdChambre")%>);">
						<td><%=Rs("DesignationHotel")%></td>
						<td><%=Rs("NumeroChambre")%></td>
						<td><%=Rs("DesignationCategorie")%></td>
						<td><%=Rs("TelChambre")%></td>
						<td><%=Rs("NombrePersonnesMax")%></td>
						<td>
							<center>
								<input type="checkbox" name="CBID" id="CBID_<%=Rs("IdChambre")%>" value="<%=Rs("IdChambre")%>" onclick="javascript:SetChange(this, document.getElementById('CBSAll'), document.getElementsByName('CBID'));">
							</center>
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
<%
Rs.close()
Set Rs = nothing
cx.close()
Set cx = Nothing
%>