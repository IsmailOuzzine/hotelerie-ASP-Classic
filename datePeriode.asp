
<% 
Set cx = Server.CreateObject("ADODB.Connection")
cx.Open Application("PC")  
Set Rs = Server.CreateObject("ADODB.RecordSet")
req = "select * from TPERIODES"  

Rs.Open req, cx, 3,3
%>
 

<!DOCTYPE html>
<html>
<head>
	<title> les dates des periodes </title>
	<meta charset="utf-8">
	<link rel="stylesheet" type="text/css" href="style/style.css">
</head>
<body class="backgroundAA">
	<%
 If (Len(Session("IdClient")) > 0) Then%>
<!-- #include virtual | file ="menu1.asp" -->
<% else  %>  
<!-- #include virtual | file ="menu.asp" --> 
<% end if %>
<br> <br><br> <br><br> <br><br> <br><br> <br>
<center>
<div style="width: 60% ; background-color: #fff; opacity: 60% ; ">
	
	<table style="width: 70%; "  class="TabData">
		<tr style="background-color: #F8072B">
					<td align="center" valign="center" ><b>Désignation</b></td>
					<td align="center" valign="center"><b>Date de début</b></td>
					<td align="center" valign="center"><b>Date de fin</b></td>
					<td align="center" valign="center"><b>prix </b></td>	
					</tr> 
			<tr><%
				dim i 
				i = 0
				
				WHILE NOT Rs.EOF%>		
					
					<td align="center" valign="center"><%=Rs("DesignationPeriode")%></td>
					<td align="center" valign="center"><%=Rs("DateDebutPeriode")%></td>
					<td align="center" valign="center"><%=Rs("DateFinPeriode")%></td>	
					<td align="center" valign="center"><b>  <% response.write(-i*5)  %>%</b> </td>			
			
		</tr>
		<%
					i = i + 1
					Rs.movenext
				WEND
				%>

	
	</table>
</div>
</center>
</body>
</html>
