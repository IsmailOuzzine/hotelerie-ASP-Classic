<% 
	If(Len(Session("IdUser")) = 0) Then
		Session("Msg") = "Veuillez vous identifier"
		Response.redirect "connexion.asp"
	End If 

ope = Request.form("modifier")
IdHotel=Request.form("IdHotel")
DesignationHotel=Request.Form("DesignationHotel")
AdresseHotel=Request.Form("AdresseHotel") 
CodePostalHotel=Request.Form("CodePostalHotel") 
VilleHotel=Request.Form("VilleHotel")
PaysHotel =Request.Form("PaysHotel") 
TelHotel=Request.Form("TelHotel")
EmailHotel=Request.form("EmailHotel") 
SiteWebHotel=Request.Form("SiteWebHotel")



Set cx = Server.CreateObject("ADODB.Connection")
cx.Open Application("PC")

req = "" 

req="ReqHotelUpdate " & IdHotel & ", '" & DesignationHotel & "','" & AdresseHotel & "','" & CodePostalHotel & "','" & VilleHotel & "','" &PaysHotel &"','" & TelHotel & "','" & EmailHotel & "','" & SiteWebHotel & "'"

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