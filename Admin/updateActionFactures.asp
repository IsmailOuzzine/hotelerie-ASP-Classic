<% 
	If(Len(Session("IdUser")) = 0) Then
		Session("Msg") = "Veuillez vous identifier"
		Response.redirect "connexion.asp"
	End If 

IdFacture=Request.Form("IdFacture")
IdClient=Request.Form("IdClient")
DateFacturation=Request.Form("DateFacturation")
DateFacturation= day(DateFacturation) & "/" & month(DateFacturation) & "/" & year(DateFacturation)

Set cx = Server.CreateObject("ADODB.Connection")
cx.Open Application("PC")

req="ReqFactutresUpdate " & IdFacture & ", " & IdClient & ", '" & DateFacturation & "'"

if(Len(req) >  0) Then
	ON ERROR RESUME NEXT
	cx.execute req

	IF (Err.number <> 0) Then
		Response.write "Erreur : " & Err.Description & "<br>REQ : " & req
		Response.end	
	End If
	'Response.write "<br>req : " & Req & " <br>le sexe est :" & Request.form("sexe")
	'Response.end
End If
'Response.redirect "selectAllFactures.asp"
%>
	<body onload="document.getElementById('ceForm').submit();">
		<form id="ceForm" action="selectAllFactures.asp" method="POST">
			<input type="hidden" name="CBID" value="<%=IdClient%>">
		</form>
	</body>
<%
cx.close()
Set cx = Nothing 
%>