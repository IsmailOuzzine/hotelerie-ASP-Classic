<%
	If(Len(Session("IdUser")) = 0) Then
		Session("Msg") = "Veuillez vous identifier"
		Response.redirect "../connexion.asp"
	End If 

valeur=Request("valeur")
critere=Request("critere")
lasthotel = session("lasthotel")
if(len(session("lasthotel"))=0)then
	session("valeur") = valeur
	session("critere") = critere
elseif((session("valeur")<>valeur) or (session("critere")<>critere))then
	session("lasthotel") = ""
	lasthotel = ""
	session("valeur") = valeur
	session("critere") = critere
end if
'j=0

Set cx = Server.CreateObject("ADODB.Connection")
cx.Open Application("PC")  
Set Rs = Server.CreateObject("ADODB.RecordSet")
req = ""  
if (critere="DesignationHotel")Then
    req="ReqHotelSelect '" & lasthotel & "', '" & valeur & "', NULL, NULL"
elseif (critere="mail")Then
    req="ReqHotelSelect '" & lasthotel & "', NULL, '" & valeur & "', NULL"
elseif (critere="ville")Then
    req="ReqHotelSelect '" & lasthotel & "', NULL, NULL, '" & valeur & "'"
else
	Response.write "valeur: " & valeur & "<br>critere: " & critere & "<br>lasthotel: " & lasthotel & "<br>req: " & req 
	Response.end
end if
Rs.Open req, cx, 3,3
%>
	<table class="TabData">
		<%
			i = 0
			'nbe = UBound(Application("TabCol")) + 1
			WHILE NOT Rs.EOF
		%> 
		<tr ondblclick="javascript:Modifier(<%=Rs("IdHotel")%>);">
			<td><%=Rs("DesignationHotel")%></td>
			<td><%=Rs("VilleHotel")%></td>
			<td><%=Rs("PaysHotel")%></td>
			<td><%=Rs("TelHotel")%></td>
			<td><%=Rs("SiteWebHotel")%></td>
			<td>
				<input type="checkbox" name="IdHotel" id="CBID_<%=Rs("IdHotel")%>" value="<%=Rs("IdHotel")%>" onclick="javascript:SetChange(this, document.getElementById('CBSAll'), document.getElementsByName('IdHotel'));">
			</td>
		</tr>
		<%
			'j=j+1
			session("lasthotel")=Rs("DesignationHotel")
			Rs.movenext
			WEND
		%>

	</table>