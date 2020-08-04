<% 
	If(Len(Session("IdUser")) = 0) Then
		Session("Msg") = "Veuillez vous identifier"
		Response.redirect "connexion.asp"
	End If 

ope = Request.form("ajouter")
DesignationHotel=Request.Form("DesignationHotel")
AdresseHotel=Request.Form("AdresseHotel") 
CodePostalHotel=Request.Form("CodePostalHotel") 
VilleHotel=Request.Form("VilleHotel")
PaysHotel =Request.Form("PaysHotel") 
EmailHotel=Request.form("EmailHotel") 
TelHotel=Request.Form("TelHotel")
SiteWebHotel=Request.Form("SiteWebHotel")



Set cx = Server.CreateObject("ADODB.Connection")
cx.Open Application("PC")

req = "" 

req="ReqHotelInsert '" & DesignationHotel & "','" & AdresseHotel & "','" & CodePostalHotel & "','" & VilleHotel & "','" &PaysHotel &"','" & TelHotel & "','" & EmailHotel & "','" & SiteWebHotel & "'"

'Response.write req
'Response.end

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