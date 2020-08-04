<%
    If(Len(Session("IdUser")) = 0) Then
		Session("Msg") = "Veuillez vous identifier"
		Response.redirect "../connexion.asp"
	End If
	'session("lastTarif") = ""

	Set cx = Server.CreateObject("ADODB.Connection")
	cx.Open Application("PC")
	Set RsCateg = Server.CreateObject("ADODB.RecordSet")

	ReqCateg = "select * from TCATEGORIES"

    'Response.write "ReqCateg: " & ReqCateg
    'Response.end

    on error resume next
	RsCateg.Open ReqCateg, cx, 3,3
	if err.number <> 0 then
		response.write err.description & "<br> ReqCateg: " & ReqCateg
		response.end
	end if

	Set RsPer = Server.CreateObject("ADODB.RecordSet")

	ReqPer = "select * from TPERIODES"

    'Response.write "ReqPer: " & ReqPer
    'Response.end

    on error resume next
	RsPer.Open ReqPer, cx, 3,3
	if err.number <> 0 then
		response.write err.description & "<br> ReqPer: " & ReqPer
		response.end
	end if
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TARIFS</title>
    <link rel="stylesheet" href="styles/styleform.css">
    <link rel="stylesheet" href="styles/stylemenu.css">
	<style>
        .TabHead tr td:nth-child(1), .TabData tr td:nth-child(1) {width: 210px;}
		.TabHead tr td:nth-child(2), .TabData tr td:nth-child(2) {width: 201px;}
		.TabHead tr td:nth-child(3), .TabData tr td:nth-child(3) {width: 201px;}
        .TabHead tr td:nth-child(4), .TabData tr td:nth-child(4) {width: 120px;}
		.TabHead tr td:nth-child(5), .TabData tr td:nth-child(5) {width: 50px; text-align:center;}
        td{border: 0px solid yellow;}
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
            function GetTarifs(H, C, P)
            {   
                //alert("debut");
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
                xmlhttp.open("GET", "searchTarif.asp?Hotel=" + H + "&Categorie="+ C +"&Periode="+ P, true);
        		xmlhttp.send();
        	}

			function Rediriger()
			{
				var x = document.getElementById("Redirection").value;
				if(x == "add")
					document.location = "formulaireInsertTarif.asp";
				else if (x == "del")
						VerifS();
			}
            function Modifier(x)
            {
                document.location = "updateTarif.asp?idTarif="+x;
            }
			function VerifS()
			{
				if(nbmc == 0)
				{
					alert("Veuillez selectionner une ou plusieurs Tarifs") ;
					return ;
				}
				document.getElementById("formTarifs").action = 'deleteTarif.asp' ;
				document.getElementById("formTarifs").method = 'POST';
				document.getElementById("formTarifs").submit() ;
			}
			function changeDisabled(identifiant)
			{
				document.getElementById(identifiant).removeAttribute('disabled');
			}
		</script>
</head>

<body onload="NavSetActive2(5);">
	<header >
		<!-- on va inclure le fichier menu.inc in chaa Allah -->
		<!--#include file="menu.html"-->
	</header><br><br>
		<form id="formTarifs" class="formPC">
			<div class="DivHead">
				<table class="TabHead">
                    <tr>
						<td colspan="2">
							<label>Hôtel</label>
						</td>	
						<td>
							<label>Catégorie</label>
						</td>
						<td colspan="2">
							<label>Période</label>
						</td>						
					</tr>
					<tr>
						<td colspan="2">
							<input type="text" name="Hotel" id="Hotel" placeholder="saisir l'hôtel concerné ..." onkeyup="changeDisabled('Categorie');">
						</td>
						<td>
							<select name="Categorie" id="Categorie" class="selectForm1" onchange="javascript:changeDisabled('Periode');" disabled>
								<%while not RsCateg.EOF%>
									<option value="<%=RsCateg("IdCategorie")%>"><%=RsCateg("DesignationCategorie")%></option>
								<%
									RsCateg.movenext
									wend
								%>
							</select>
						</td>	
						<td colspan="2">
							<select name="Periode" id="Periode" class="selectForm1" onchange="changeDisabled('next');" disabled><!--GetTarifs(document.getElementById('Hotel').value,document.getElementById('Categorie').value, this.value);changeDisabled('next');-->
								<%while not RsPer.EOF%>
									<option value="<%=RsPer("IdPeriode")%>"><%=RsPer("DesignationPeriode")%></option>
								<%
									RsPer.movenext
									wend
								%>
							</select>
						</td>				
					</tr>
					<tr>
						<td colspan="2">
							<select class="selectForm1" id="Redirection">
								<option value="add">Ajouter</option>
								<option value="del">Supprimer</option>
							</select>
						</td>
						<td colspan="2" ><input type="button" value="Valider l'operation" class="BTR" onclick="javascript:Rediriger();"></td>
						<td style="width:50px;">
							<input type="button" id="next" value=">" class="BTR" onclick="javascript:GetTarifs(document.getElementById('Hotel').value,document.getElementById('Categorie').value, document.getElementById('Periode').value);" disabled>
						</td>
					</tr>
					<tr>
						<td><b>Hôtel</b></td>
                        <td><b>Catégorie</b></td>
                        <td><b>Période</b></td>
						<td><b>Tarif</b></td>
						<td style="width:50px;">
							<input type="checkbox" name="CBAll" id="CBSAll" style="width:50px;" onclick="javascript:SelectAll(this, document.getElementsByName('CBID'));">
						</td>
					</tr>
				</table>
			</div>
			<div id="data" class="DivData">
			
			</div>
		</form>
	</body>
</html>