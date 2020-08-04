<% 
	If(Len(Session("IdUser")) = 0) Then
    	Session("Msg") = "Veuillez vous identifier"
    	Response.redirect "connexion.asp"
	End If 
ope = Request.form("ajouter")
Idclient=Request.Form("Idclient")
NomClient=Request.Form("nom") 
PrenomClient=Request.Form("prenom") 
NumeroPieceIdentiteClient=Request.Form("CIN")
typePieceIdentiteClient =Request.Form("Typecin") 
sexe=Request.form("sexe") 
Datenaissanceclient=Request.Form("date")
Datenaissanceclient=day(Datenaissanceclient) & "/" & month(Datenaissanceclient) & "/" & year(Datenaissanceclient)
Adresseclient=Request.Form("adresse")
codepostalclient=Request.Form("codepostal") 
villeclient=Request.Form("ville") 
paysclient=Request.Form("pays")
telclient=Request.Form("tele")
emailclient=Request.Form("mail") 





Set cx = Server.CreateObject("ADODB.Connection")
cx.Open Application("PC")

req = "" 

req="ReqClientInsert '" & NomClient & "','" & prenomclient & "','" & NumeroPieceIdentiteClient & "','" & typePieceIdentiteClient & "','" &sexe &"','" & Datenaissanceclient & "','" & Adresseclient & "','" & codepostalclient & "','" & villeclient & "','" & paysclient & "','" & telclient & "','" & emailclient & "'"



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