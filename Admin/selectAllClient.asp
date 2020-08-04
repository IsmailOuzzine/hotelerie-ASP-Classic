<%

Set cx = Server.CreateObject("ADODB.Connection")
cx.Open Application("PC")  
Set Rs = Server.CreateObject("ADODB.RecordSet")
lastname = Request.QueryString("lastname")
j = 0
req = "select top 30 * from TCLIENTS where nomClient > '" & lastname & "' order by nomClient, prenomClient"

Rs.Open req, cx, 3,3
%>
 
<HTML>
	<HEAD>
		<TITLE>Liste des clients </TITLE> 
		<meta charset="utf-8" > 
		<link rel="stylesheet" href="style.css" type="text/css" media="screen" />
		<link rel="stylesheet" href="stylemenu.css">
		<link rel="stylesheet" href="styletable.css">
	
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
				document.location = 'updateClient.asp?IdClient='+x ;
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
		</HEAD>
	<!--style="BACKGROUND-COLOR: #FFCCAA"-->
	<BODY class="CBODY" style="background-color: #ffe6ff;" >
	<header >
		<!-- on va inclure le fichier menu.inc in chaa Allah -->
		<!--#include file="menu.html"-->
	</header><br><br>
		<!--<center><h1>Liste des clients</h1></center><br></center>-->
		<form id="formClients" style="border:1px solid navy">
			<div id="entete">
			<table align="left" border="0" id="tableEntete" cellspacing="1">
				<tr>
					<td align="center" valign="center" style="width:154px"><b>Nom</b></td>
					<td align="center" valign="center" style="width:152px"><b>Prénom</b></td>
					<td align="center" valign="center" style="width:120px"><b>Tél<b></td>
					<td align="center" valign="center" style="width:239px"><b>E-mail</b></td>
					<td align="center" valign="center" style="width:35px">
						<input type="checkbox" name="CBAll" id="CBSAll" onclick="javascript:SelectAll(this, document.getElementsByName('CBID'));">
					</td>
				</tr>
			</table>
			</div>
			<div id="data">
			<table align="left" border="0" cellspacing="1" id="tableData">
				<tr height="1">
					<td align="center" valign="center" style="width:155px"></td>
					<td align="center" valign="center" style="width:155px"></td>
					<td align="center" valign="center" style="width:120px"></td>
					<td align="center" valign="center" style="width:235px"></td>
					<td align="center" valign="center" style="width:35px"></td>
				</tr>
					<%
				i = 0
				'nbe = UBound(Application("TabCol")) + 1
				WHILE NOT Rs.EOF%> 
				<tr ondblclick="javascript:Modifier(<%=Rs("IdClient")%>);" class="line<%=i%>">
					
					<td align="left" valign="center" style="padding-left:3px;"><%=Rs("nomClient")%></td>
					<td align="left" valign="center" style="padding-left:3px;"><%=Rs("PrenomClient")%></td>
					<td align="left" valign="center" style="padding-left:3px;"><%=Rs("TelClient")%></td>
					<td align="left" valign="center" style="padding-left:3px;"><%=Rs("EmailClient")%></td>
					<td align="center" valign="center">
						<input type="checkbox" name="CBID" id="CBID_<%=Rs("IdClient")%>" value="<%=Rs("IdClient")%>" onclick="javascript:SetChange(this, document.getElementById('CBSAll'));">
					</td>
					
				</tr>
				
				<%
					j = j + 1
					'pour récupérer nomClient de la dernière ligne qui sera affichée 
					
						lastname = Rs("nomClient")
					
					'le i change entre 2 valeurs, 0 et 1, pour nous donner les deux class (line0 et line1)
					if(i=0)then
						i=1
					else
						i=0
					end if
					Rs.movenext
				WEND
				%>

			</table>
			</div>
			
	<br>
				<a href="selectAllClient.asp?lastname=<%=lastname%>"> <input type="button" id="toNext" value="LOAD MORE"> </a>
				<input type="button" name="operation" id="BTsupprimer"  value="DELETE"  onclick="javascript:VerifS();">
		</form>
	
	</center>

	</body>
</HTML>