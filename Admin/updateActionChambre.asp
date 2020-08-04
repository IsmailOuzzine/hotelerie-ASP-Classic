<% 
	If(Len(Session("IdUser")) = 0) Then
    	Session("Msg") = "Veuillez vous identifier"
    	Response.redirect "connexion.asp"
	End If 
ope = Request.form("ajouter")
IdChambre=Request.Form("IdChambre")
IdHotel=Request.Form("IdHotel")
IdCategorie=Request.Form("IdCategorie") 
NumeroChambre=Request.Form("NumeroChambre") 
TelChambre=Request.Form("TelChambre")
OrientationChambre =Request.Form("OrientationChambre") 
EtageChambre=Request.form("EtageChambre") 
NombrePersonnesMax=Request.Form("NombrePersonnesMax")
NombreLitsEnfant=Request.Form("NombreLitsEnfant")
DoucheChambre=Request.Form("DoucheChambre") 
BaignoireChambre=Request.Form("BaignoireChambre") 
ToiletteChambre=Request.Form("ToiletteChambre")
ClimChambre=Request.Form("ClimChambre")
TVChambre=Request.Form("TVChambre") 
Refrigerateur=Request.Form("Refrigerateur") 
BalconChambre=Request.Form("BalconChambre") 
VuePiscine=Request.Form("VuePiscine") 
VueJardin=Request.Form("VueJardin") 


Set cx = Server.CreateObject("ADODB.Connection")
cx.Open Application("PC")

req = "" 

req="ReqChambreUpdate " & IdChambre & ", " & IdHotel & ", " & IdCategorie & ", " & NumeroChambre & ", '" & TelChambre & "', '" & OrientationChambre &"', " & EtageChambre & ", " & NombrePersonnesMax & ", " & NombreLitsEnfant & ", '" & DoucheChambre & "', '" & BaignoireChambre & "', '" & ToiletteChambre & "', '" & ClimChambre & "', '" & TVChambre & "', '" & Refrigerateur & "', '" & BalconChambre & "', '" & VuePiscine & "', '" & VueJardin & "'"


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
Response.redirect "form1Hotel.asp"
cx.close()
Set cx = Nothing 

%>