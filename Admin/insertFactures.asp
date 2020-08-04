<% 
	If(Len(Session("IdUser")) = 0) Then
		Session("Msg") = "Veuillez vous identifier"
		Response.redirect "connexion.asp"
	End If 

	Idclient=Request.Form("Idclient")
	DateFacturation=Request.Form("DateFacturation")
	DateFacturation= day(DateFacturation) & "/" & month(DateFacturation) & "/" & year(DateFacturation)

	Set cx = Server.CreateObject("ADODB.Connection")
	cx.Open Application("PC") 

	req="ReqFactureInsert " & Idclient & ", '" & DateFacturation & "'"

	if(Len(req) >  0) Then
		ON ERROR RESUME NEXT
		cx.execute req

		IF (Err.number <> 0) Then
			Response.write "Erreur : " & Err.Description & "<br>REQ : " & req
			Response.end
		ENd If
		'Response.write "<br>req : " & Req & " <br>le sexe est :" & Request.form("sexe")
		'Response.end
	End If
	Response.redirect "form1Client.asp"
	cx.close()
	Set cx = Nothing 

%>