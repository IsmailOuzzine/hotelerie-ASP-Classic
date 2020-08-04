<%
  	If(Len(Session("IdUser")) = 0) Then
    	Session("Msg") = "Veuillez vous identifier"
    	Response.redirect "../connexion.asp"
	End If 
	
valeur=Request("valeur")
critere=Request("critere")
IdHotel=Request("IdHotel")
'lastname = session("lastname")

'if(len(session("lastname"))=0)then
'	session("valeur") = valeur
'	session("critere") = critere
'elseif((session("valeur")<>valeur) or (session("critere")<>critere))then
'	session("lastname") = ""
'	lastname = ""
'	session("valeur") = valeur
'	session("critere") = critere
'end if
'j = 0

'Set cx = Server.CreateObject("ADODB.Connection")
'cx.Open Application("PC")  
Set Rs = Server.CreateObject("ADODB.RecordSet")
req = ""  
if (critere="Categorie")Then
    req="ReqChambreSelect '" & IdHotel & "', '" & valeur & "', NULL, NULL, NULL"
elseif (critere="Numero")Then
    req="ReqChambreSelect '" & IdHotel & "', NULL, '" & valeur & "', NULL, NULL"
elseif (critere="Orientation")Then
    req="ReqChambreSelect '" & IdHotel & "', NULL, NULL, '" & valeur & "', NULL"
elseif (critere="Etage")Then
    req="ReqChambreSelect '" & IdHotel & "', NULL, NULL, NULL, '" & valeur & "'"
else
	Response.write "valeur: " & valeur & "<br>critere: " & critere & "<br>IdHotel: " & IdHotel
	'Response.end
end if
Response.write req
Response.end
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
			'if (rs.recordcount < 30) then
				'session("lastname")=""
			'end if
			WHILE NOT Rs.EOF%> 
			<tr ondblclick="javascript:Modifier(<%=Rs("IdChambre")%>);">
				
				<td><%=Rs("numChambre")%></td>
				<td><%=Rs("IdCategorie")%></td>
				<td><%=Rs("TelChambre")%></td>
				<td><%=Rs("OrientationChambre")%></td>
                <td><%=Rs("NombrePersonnesMax")%></td>
				<td>
					<input type="checkbox" name="CBID" id="CBID_<%=Rs("IdChambre")%>" value="<%=Rs("IdChambre")%>" onclick="javascript:SetChange(this, document.getElementById('CBSAll'), document.getElementsByName('CBID'));">
				</td>
				
			</tr>
			
			<%
				'j = j + 1
				'session("lastname") = Rs("nomClient")
				Rs.movenext
			WEND
			%>
		</table>
<%
Rs.close()
Set Rs = nothing
cx.close()
Set cx = Nothing
%>