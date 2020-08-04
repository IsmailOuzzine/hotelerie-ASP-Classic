<%
    if(len(Session("IdUser")) = 0 )then
        Session("MSG") = "Veuiilez vous identifier"
        Response.Redirect "connexion.asp"
    end if

    IdTarif=Request.Form("IdTarif")
    Tarif=Request.Form("Tarif")
    
    Set cx = Server.CreateObject("ADODB.Connection")
    cx.Open Application("PC")

    req = "ReqTarifupdate " & IdTarif & ", " & Tarif 

    'Response.write "REQ: " & req
    'Response.end

    if (len(req) > 0) then
        ON ERROR RESUME NEXT 
        cx.execute req
        if (err.number <> 0) then
            Response.write "error: " & err.description & "<br>req: " & req
            Response.end
        end if
    end if

    'Response.Redirect "updateTarif.asp?IdTarif=" & IdTarif
    Response.Redirect "form1Tarif.asp"
    cx.Close() 
    Set cx = Nothing
%>