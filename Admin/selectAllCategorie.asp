<%
    If(Len(Session("IdUser")) = 0) Then
		Session("Msg") = "Veuillez vous identifier"
		Response.redirect "connexion.asp"
	End If 
Set cx = Server.CreateObject("ADODB.Connection")
cx.Open Application("PC")  
Set Rs = Server.CreateObject("ADODB.RecordSet")
req = "select * from TCATEGORIES"  

Rs.Open req, cx, 3,3
%>
 
<HTML>
	<HEAD>
		<TITLE>Liste des catégories </TITLE> 
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
			{	document.location = "updateCategorie.asp?IdCategorie="+x;	}
			function VerifS()
			{
				if(nbmc == 0)
				{
					alert("Veuillez selectionner une ou plusieures Categories") ;
					return ;
				}
				document.getElementById("formCategories").action = 'deleteCategorie.asp' ;
				document.getElementById("formCategories").method = 'POST' ;
				document.getElementById("formCategories").submit() ;
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
	</header>
	
	<br><br><br>
	<div id="logo">
        <img src="CONTACTHotels.jpg" alt="ContactHôtels logo">
    </div>
	<div><h1>Liste des catégories</h1></center></div>
		
		<div>
		<form id="formCategories">
			<div id="lesBouttons">
				<input type="button" name="operation" id="BTsupprimer"  value="supprimer" style="width: 120px"  onclick="javascript:VerifS();">
			</div>	
			<table align="center" border="1" style=" width: 100%">
		<tr>
					<td align="center" valign="center" style=" width: 20%"><b>ID</b></td>
					<td align="center" valign="center" style=" width: 70%"><b>Désignation</b></td>
					<td align="center" valign="center" style=" width: 10%">
						<input type="checkbox" name="CBAll" id="CBSAll" onclick="javascript:SelectAll(this, document.getElementsByName('CBID'));">
					</td>
				</tr>
					<%
				i = 0
				'nbe = UBound(Application("TabCol")) + 1
				WHILE NOT Rs.EOF%> 
				<tr ondblclick="javascript:Modifier(<%=Rs("IdCategorie")%>);" class="line<%=i%>">
					<td align="center" valign="center"><%=Rs("IdCategorie")%></td>
					<td align="center" valign="center"><%=Rs("DesignationCategorie")%></td>
					<td align="center" valign="center">
						<input type="checkbox" name="CBID" id="CBID_<%=Rs("IdCategorie")%>" value="<%=Rs("IdCategorie")%>" onclick="javascript:SetChange(this, document.getElementById('CBSAll'));">
					</td>
				</tr>
				<%
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
		</form>
		</div>

	</body>
</HTML>