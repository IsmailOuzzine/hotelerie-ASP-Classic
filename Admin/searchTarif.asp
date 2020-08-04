<%
    If(Len(Session("IdUser")) = 0) Then
		Session("Msg") = "Veuillez vous identifier"
		Response.redirect "../connexion.asp"
	End If 
Hotel=Request("Hotel")
Categorie=Request("Categorie")
Periode = Request("Periode")

'j = 0

Set cx = Server.CreateObject("ADODB.Connection")
cx.Open Application("PC")  
Set Rs = Server.CreateObject("ADODB.RecordSet")
req = "ReqTarifSelect '" & Hotel & "', " & Categorie & ", " & Periode  

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
			WHILE NOT Rs.EOF%> 
			<tr ondblclick="javascript:Modifier(<%=Rs("IdTarif")%>);">
				
				<td><%=Rs("DesignationHotel")%></td>
                <td><%=Rs("DesignationCategorie")%></td>
                <td><%=Rs("DesignationPeriode")%></td>
                <td><%=Rs("Tarif")%></td>
				<td>
					<input type="checkbox" name="CBID" id="CBID_<%=Rs("IdTarif")%>" value="<%=Rs("IdTarif")%>" onclick="javascript:SetChange(this, document.getElementById('CBSAll'), document.getElementsByName('CBID'));">
				</td>
				
			</tr>
			
			<%
				'j = j + 1
				Rs.movenext
			    WEND
			%>
		</table>