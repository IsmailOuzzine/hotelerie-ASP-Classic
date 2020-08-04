<%
	If(Len(Session("IdUser")) = 0) Then
		Session("Msg") = "Veuillez vous identifier"
		Response.redirect "connexion.asp"
	End If 

indice=Request.QueryString("indice")
if(indice="")then
	indice="0"
end if
j=0

Set cx = Server.CreateObject("ADODB.Connection")
cx.Open Application("PC")  
Set Rs = Server.CreateObject("ADODB.RecordSet")
req = "select top 20 * from THOTELS where IdHotel > " & indice & "order by IdHotel"  

Rs.Open req, cx, 3,3
%>
 
<HTML>
	<HEAD>
		<TITLE>Liste des Hotels </TITLE> 
		<meta charset="UTF-8">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 	
		<link rel="stylesheet" href="stylemenu.css">
		<link rel="stylesheet" href="style.css" type="text/css" media="screen" />
	
		<script language="javascript">
			var nbm = <%=Rs.RecordCount%> ;
			var nbmc = 0 ;
			function SelectAll(cbg, VCBM)
			{
				var i, nbm = VCBM.length ;
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
			function SetChange(cbm, cbg)
			{
				if(cbm.checked)
				{
					nbmc++ ;
					if(nbmc == nbm)
					{
						cbg.checked = true ;	
					}
				}
				else
				{
					nbmc-- ;
					cbg.checked = false ;
				}
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
		</HEAD>
	<!--style="BACKGROUND-COLOR: #FFCCAA"-->
	<BODY class="CBODY" style="background-color: #ffe6ff;">
	
	<header>
		<!-- on va inclure le fichier menu.inc in chaa Allah -->
		<!--#include file="menu.html"-->
	</header>
<br><br><br><br>
		<h1>Liste des Hotels</h1>
		<div class="formHotel">
		<form id="formHotels">
			<div id="lesBouttons">
				<input type="button" name="operation" id="BTsupprimer"  value="supprimer" style="width: 120px"  onclick="javascript:VerifS();">
			</div>
			<table align="center" border="1" class="table">
				<tr>
					<td align="center" valign="center" width="15%"><b>Désignation</b></td>
					<td align="center" valign="center" width="15%"><b>Ville</b></td>
					<td align="center" valign="center" width="13%"><b>Pays</b></td>
					<td align="center" valign="center" width="20%"><b>Email</b></td>
					<td align="center" valign="center" width="12%"><b>Tel</b></td>
					<td align="center" valign="center" width="20%"><b>Site</b></td>
					<td align="center" valign="center" width="5%">
						<input type="checkbox" name="CBAll" id="CBSAll" onclick="javascript:SelectAll(this, document.getElementsByName('CBID'));">
					</td>
				</tr>
					<%
				i = 0
				'nbe = UBound(Application("TabCol")) + 1
				WHILE NOT Rs.EOF%> 
				<tr ondblclick="javascript:Modifier(<%=Rs("IdHotel")%>);" class="line<%=i%>">
					<td align="center" valign="center"><%=Rs("DesignationHotel")%></td>
					<td align="center" valign="center"><%=Rs("VilleHotel")%></td>
					<td align="center" valign="center"><%=Rs("PaysHotel")%></td>
					<td align="center" valign="center"><%=Rs("EmailHotel")%></td>
					<td align="center" valign="center"><%=Rs("TelHotel")%></td>
					<td align="center" valign="center"><%=Rs("SiteWebHotel")%></td>
					<td align="center" valign="center">
						<input type="checkbox" name="CBID" id="CBID_<%=Rs("IdHotel")%>" value="<%=Rs("IdHotel")%>" onclick="javascript:SetChange(this, document.getElementById('CBSAll'));">
					</td>
				</tr>
				<%
					j=j+1
					if(j=20)then
						indice=Rs("IdHotel")
					end if
					if(i=0)then
						i=1
					else
						i=0
					end if
					Rs.movenext
				WEND
				%>

			</table>
			
			<br>
			<br>
			<br>
			<a href="selectAllHotel.asp?indice=<%=indice%>"><input type="button" value="LOAD MORE" id="toNext"></a>
		</form>
		</div>

	</body>
</HTML>