<%
dim login, passwd

	login  = Request("username")
	passwd = Request("password")


	Set cx = Server.CreateObject("ADODB.Connection")
	'Response.write Application("pc") 
	'Response.end
	cx.Open Application("PC")


	Set Rs = Server.CreateObject("ADODB.RecordSet")
	req = "ReqclientVerif '" & login & "','" & passwd & "'"


	rs.Open req, cx, 3,3
	If(Rs.RecordCount = 1) Then
		Session("IdClient") = rs("IdClient")
		Response.redirect "accueil.asp"
	Else
		Session("IdClient") = ""
		Session("Log") = login
		Session("Pas") = passwd
		Session("Msg") = "Login et/ou mot de passe incorrect"
		Response.redirect "accueil.asp"
	End If
	rs.close()
	Set rs = nothing
	cx.close()
	Set cx = Nothing
%>