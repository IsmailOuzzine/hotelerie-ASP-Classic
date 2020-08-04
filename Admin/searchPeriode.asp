<%
    If(Len(Session("IdUser")) = 0) Then
		Session("Msg") = "Veuillez vous identifier"
		Response.redirect "../connexion.asp"
	End If 
search1=Request("search1")
search2=Request("search2")
typeRech=Request("typeRech")

Set cx = Server.CreateObject("ADODB.Connection")
cx.Open Application("PC")  
Set Rs = Server.CreateObject("ADODB.RecordSet")
req = ""  
if (typeRech="designation")Then
    req="ReqPeriodeSelect '" & search1 & "', NULL"
elseif (typeRech="idperiode")Then
    req="ReqPeriodeSelect NULL, '" & search1 & "'"
elseif (typeRech="periode")Then
	req="ReqPeriodeSelect2 '" & search1 & "', '" & search2 & "'"
else
	Response.write "search1: " & search1 & "<br>search2: " & search2 & "<br>typeRech: " & typeRech
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
				session("lastperiode")=""
			end if
			WHILE NOT Rs.EOF%> 
				<tr ondblclick="javascript:Modifier(<%=Rs("IdPeriode")%>);">
					<td><%=Rs("DesignationPeriode")%></td>
					<td><%=Rs("DateDebutPeriode")%></td>
					<td><%=Rs("DateFinPeriode")%></td>
					<td>
						<input type="checkbox" name="CBID" id="CBID_<%=Rs("IdPeriode")%>" value="<%=Rs("IdPeriode")%>" onclick="javascript:SetChange(this, document.getElementById('CBSAll'), document.getElementsByName('CBID'));">
					</td>
				</tr>
			
			<%
				'j = j + 1
				session("lastperiode") = Rs("DesignationPeriode")
				Rs.movenext
			WEND
			%>
		</table>