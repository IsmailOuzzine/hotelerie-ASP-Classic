<%
    If(Len(Session("IdUser")) = 0) Then
		Session("Msg") = "Veuillez vous identifier"
		Response.redirect "../connexion.asp"
	End If 
valeur=Request("valeur")
critere=Request("critere")
lastcat = session("lastcat")

if(len(session("lastcat"))=0)then
	session("valeur") = valeur
	session("critere") = critere
elseif((session("valeur")<>valeur) or (session("critere")<>critere))then
	session("lastcat") = ""
	lastcat = ""
	session("valeur") = valeur
	session("critere") = critere
end if
'j = 0

Set cx = Server.CreateObject("ADODB.Connection")
cx.Open Application("PC")  
Set Rs = Server.CreateObject("ADODB.RecordSet")
req = ""  
if (critere="designation")Then
    req="ReqCategorieSelect '" & lastcat & "', '" & valeur & "', NULL"
elseif (critere="idCategorie")Then
    req="ReqCategorieSelect '" & lastcat & "', NULL, '" & valeur & "'"

else
	Response.write "valeur: " & valeur & "<br>critere: " & critere & "<br>lastcat: " & lastcat
	'Response.end
end if
'Response.write req
'Response.end
on error resume next
	Rs.Open req, cx, 3,3
	if err.number <> 0 then
		response.write err.description & "<br> req : " & req 
		response.end
	end if

%>
		<table class="TabData">
			<%
			'nbe = UBound(Application("TabCol")) + 1
			if (rs.recordcount < 30) then
				session("lastname")=""
			end if
			WHILE NOT Rs.EOF%> 
			<tr ondblclick="javascript:Modifier(<%=Rs("idCategorie")%>);">
				
				<td><%=Rs("DesignationCategorie")%></td>
				<td>
					<input type="checkbox" name="CBID" id="CBID_<%=Rs("idCategorie")%>" value="<%=Rs("idCategorie")%>" onclick="javascript:SetChange(this, document.getElementById('CBSAll'), document.getElementsByName('CBID'));">
				</td>
				
			</tr>
			
			<%
				'j = j + 1
				session("lastcat") = Rs("DesignationCategorie")
				Rs.movenext
			WEND
			%>
		</table>