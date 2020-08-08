<%
<%
if(Len(Session("IdClient")) = 0)then
   Session("Msg") = "Veuillez vous identifiez ou vous inscrire"
  Response.redirect "clientformulaire.asp"
  Response.end
end if

Set connection = Server.CreateObject("ADODB.Connection")
Set rS = Server.CreateObject("ADODB.RecordSet")
Set rS2 = Server.CreateObject("ADODB.RecordSet")
connection.Open Application("DB")
rs.CursorLocation = adUseClient
Dim Jpeg, pos_x, pos_y, w, h, r
w = 250
h = 300

r = Request.Form("ratio")
r=Replace(r,".",",")
pos_x = Request.Form("pos_x")
pos_y = Request.Form("pos_y")
crd_x = Request.Form("crd_x")
crd_y = Request.Form("crd_y")
img_x = Request.Form("img_x")
img_y = Request.Form("img_y")

ON ERROR RESUME NEXT
Set fs=Server.CreateObject("Scripting.FileSystemObject")

Set Jpeg = Server.CreateObject("Persits.Jpeg")
Jpeg.Open Server.MapPath("./img/Clients/" & Session("fname"))

If(Err.Number <> 0) Then
	Session("alert") = "Une erreur est survenue !<br>"& Err.Description
	Jpeg.Close
	set fs=nothing
	Response.Redirect "Accueil.asp"
End If

Jpeg.ResolutionX = 72
Jpeg.ResolutionY = 72

' resize by 50%
Jpeg.PreserveAspectRatio = True

Jpeg.Width = Jpeg.OriginalWidth * r

jpeg.Crop pos_x, pos_y, pos_x + w, pos_y + h

' Output as PNG
Jpeg.PNGOutput = True

newImageName = "small_"&Session("Iduser")&".png"
' Save
Jpeg.Save Server.MapPath("./img/Clients/")&"/"&newImageName
Jpeg.Close

' Supprimer le premier fichier telechargé 
if fs.FileExists(Server.MapPath("./img/Clients/" & Session("fname"))) then
	fs.DeleteFile(Server.MapPath("./img/Clients/" & Session("fname")))
end if

query = "UPDATE TCLIENTS SET Avatar = '"&newImageName&"' WHERE IdClient = "&Session("IdUser")
conn.execute query
conn.close
Set connection = Nothing	
Set fs=nothing
Session("fname") = ""
Response.Redirect "MonProfil.asp"
%>