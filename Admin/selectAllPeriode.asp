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
req = "select top 20 * from TPERIODES where IdPeriode > " & indice & " oprder by IdPeriode"  

Rs.Open req, cx, 3,3
%>
 
<HTML>
	<HEAD>
		<TITLE>Liste des clients </TITLE> 
		<meta charset="utf-8" > 
		<link rel="stylesheet" href="style.css" type="text/css" media="screen" />
		<link rel="stylesheet" href="stylemenu.css">
	
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
			{document.location = "updatePeriode.asp?IdPeriode="+x;}
			function VerifS()
			{
				if(nbmc == 0)
				{
					alert("Veuillez selectionner une ou plusieures periodes") ;
					return ;
				}
				document.getElementById("formPeriodes").action = 'deletePeriode.asp' ;
				document.getElementById("formPeriodes").method = 'POST' ;
				document.getElementById("formPeriodes").submit() ;
			}
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
	</HEAD>
				<!--style="BACKGROUND-COLOR: #FFCCAA"-->
	<BODY class="CBODY" style="background-color: #ffe6ff;">
	<header>
		<!-- on va inclure le fichier menu.inc in chaa Allah -->
		<!--#include file="menu.html"-->
	</header><br><br>
	<div id="logo">
        <img src="CONTACTHotels.jpg" alt="ContactHôtels logo">
    </div>
	<div><h1>Liste des périodes</h1></div>
		
		<div>
		<form id="formPeriodes">
			<div id="lesBouttons">
				<input type="button" name="operation" id="BTsupprimer"  value="supprimer" style="width: 120px"  onclick="javascript:VerifS();">
			</div>
			
			<table align="center" border="1">
		<tr>
					<td align="center" valign="center" width="50%"><b>Désignation</b></td>
					<td align="center" valign="center" width="21%"><b>Date de début</b></td>
					<td align="center" valign="center" width="21%"><b>Date de fin</b></td>
					<td align="center" valign="center" width="7%">
						<input type="checkbox" name="CBAll" id="CBSAll" onclick="javascript:SelectAll(this, document.getElementsByName('CBID'));">
					</td>
				</tr>
					<%
				i = 0
				'nbe = UBound(Application("TabCol")) + 1
				nb = Rs.RecordCount
				WHILE NOT Rs.EOF%> 
				<tr ondblclick="javascript:Modifier(<%=Rs("IdPeriode")%>);" class="line<%=i%>">
					<td align="center" valign="center"><%=Rs("DesignationPeriode")%></td>
					<td align="center" valign="center"><%=Rs("DateDebutPeriode")%></td>
					<td align="center" valign="center"><%=Rs("DateFinPeriode")%></td>
					<td align="center" valign="center">
						<input type="checkbox" name="CBID" id="CBID_<%=Rs("IdPeriode")%>" value="<%=Rs("IdPeriode")%>" onclick="javascript:SetChange(this, document.getElementById('CBSAll'));">
					</td>
				</tr>
				<%
					j=j+1
					if(j=20)then
						indice=Rs("IdPeriode")
						j=0
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
			<a href="selectAllPeriode.asp?indice=<%=indice%>"><input type="button" id="toNext" value="LOAD MORE"></a>	
		</form>
		</div>

	</body>
</HTML>
