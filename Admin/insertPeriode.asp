<% 
    If(Len(Session("IdUser")) = 0) Then
		Session("Msg") = "Veuillez vous identifier"
		Response.redirect "connexion.asp"
	End If 
DesignationPeriode=Request.Form("DesignationPeriode")
DateDebutPeriode=Request.Form("DateDebutPeriode")
DateDebutPeriode= day(DateDebutPeriode) & "/" & month(DateDebutPeriode) & "/" & year(DateDebutPeriode)
DateFinPeriode=Request.form("DateFinPeriode")
DateFinPeriode= day(DateFinPeriode) & "/" & month(DateFinPeriode) & "/" & year(DateFinPeriode)




Set cx = Server.CreateObject("ADODB.Connection")
cx.Open Application("PC")

req = "" 

req="ReqPeriodeInsert '" & DesignationPeriode & "','" & DateDebutPeriode & "','" & DateFinPeriode & "'"


if(Len(req) >  0) Then
	ON ERROR RESUME NEXT

	cx.execute req

	IF (Err.number <> 0) Then
		Response.write "Erreur : " & Err.Description & "<br>REQ : " & req
		Response.end
	
	ENd If

	'Response.write "<br>req : " & Req
	'Response.end
End If
Response.redirect "form1Periode.asp"
cx.close()
Set cx = Nothing 

%>