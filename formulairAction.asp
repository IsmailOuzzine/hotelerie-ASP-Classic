<% 





ope = Request.form("ajouter")
Idclient=Request.Form("Idclient")
NomClient=Request.Form("nom") 
PrenomClient=Request.Form("prenom") 
NumeroPieceIdentiteClient=Request.Form("CIN")
typePieceIdentiteClient =Request.Form("Typecin") 
SexeClient=Request.form("sexe") 
Datenaissanceclient=Request.Form("date")
Adresseclient=Request.Form("adresse")
codepostalclient=Request.Form("codepostal") 
villeclient=Request.Form("ville") 
paysclient=Request.Form("pays")
telclient=Request.Form("tele")
emailclient=Request.Form("mail") 
MotDePasse =Request.form("MotDePasse")


Set cx = Server.CreateObject("ADODB.Connection")
cx.Open Application("PC")

req = "" 

req="ReqClientsInsert " &Idclient & "'" & NomClient & "','" & prenomclient & "','" & NumeroPieceIdentiteClient & "','" & typePieceIdentiteClient & "','" & SexeClient & "','" & Datenaissanceclient & "','" & Adresseclient & "','" & codepostalclient & "','" & villeclient & "','" & paysclient & "','" & telclient & "','" & emailclient & "','" & MotDePasse &"'"



if(Len(req) >  0) Then
	ON ERROR RESUME NEXT

	cx.execute req

	IF (Err.number <> 0) Then
		Response.write "Erreur : " & Err.Description & "<br>REQ : " & req
		Response.end
	else 
       Response.redirect "Accueil.asp"
	
	ENd If

	'Response.write "<br>req : " & Req
	'Response.end
End If
cx.close()
Set cx = Nothing 

%>
