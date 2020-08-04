<% 
	dim login, passwd

	login  = Request("username")
	passwd = Request("password")


	Set cx = Server.CreateObject("ADODB.Connection")
	'Response.write Application("pc") 
	'Response.end
	cx.Open Application("PC")


	Set Rs = Server.CreateObject("ADODB.RecordSet")
	req = "ReqUserVerif '" & login & "','" & passwd & "'"


	rs.Open req, cx, 3,3
	'Response.write rs.RecordCount
	'Response.end
	
	If(rs.RecordCount = 1) Then
		Session("IdUser") = rs("IdUser")
		Response.redirect "Admin/Accueil.asp"
	Else
		Session("IdUser") = ""
		Session("Log") = login
		Session("Pas") = passwd
		Session("Msg") = "Login et/ou mot de passe incorrect"
		Response.redirect "connexion.asp"
	End If
	rs.close()
	Set rs = nothing
	cx.close()
	Set cx = Nothing
%>