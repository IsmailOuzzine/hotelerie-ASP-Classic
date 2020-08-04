<%
if(Len(Session("IdClient")) = 0)then
   Session("Msg") = "Veuillez vous identifiez ou vous inscrire"
  Response.redirect "clientformulaire.asp"
  Response.end
end if

IdChambre = Request("IdChambre")
debut = Request("DateDeDebut")
debut = day(debut) & "/" & month(debut) & "/" & year(debut)
fin = Request("DateDeFin")
fin = day(fin) & "/" & month(fin) & "/" & year(fin)
IdClient = Session("IdClient")
IdHotel = Request("IdHotel")
IdCategorie = Request("IdCategorie")

Set cx = Server.CreateObject("ADODB.Connection")
cx.Open Application("PC")
Set Rsclient = Server.CreateObject("ADODB.RecordSet")
Set RsHotel = Server.CreateObject("ADODB.RecordSet")
Set RsCategorie = Server.CreateObject("ADODB.RecordSet")

req="effectuerReservation " & IdClient & ", " & IdChambre & ", '" & debut & "', '" & fin & "'" 
'Response.write req
'Response.end

if(Len(req) >  0) Then
	ON ERROR RESUME NEXT

	cx.execute req

	IF (Err.number <> 0) Then
		Response.write "Erreur : " & Err.Description & "<br>REQ : " & req
		Response.end
	
	ENd If

	'Response.write "<br>req : " & Req
	'Response.end
End If

reqClient = "select * from TCLIENTS where IdClient = " & IdClient
Rsclient.Open reqClient, cx, 3,3

reqHotel="select * from THOTELS where IdHotel = " & IdHotel
RsHotel.Open reqHotel, cx, 3,3

reqCategorie="select * from TCATEGORIES where IdCategorie = " & IdCategorie
RsCategorie.Open reqCategorie, cx, 3,3

'Response.write "reqclient: " & reqClient & "<br>reqHotel: " & reqHotel & "<br>reqCategorie : " & reqCategorie & "<br> IdChambre: " & IdChambre & " debut: " & debut & " fin: " & fin 
'Response.end
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Votre facture</title>
    <!--<link rel="stylesheet" href="style/style.css">-->
    <style>
    body{
        background-color: #7aa3b1;
        margin:0;
        padding:0;
    }
    .corp{
        font-family: arial;
        width: 600px;
        margin: 0 auto;
    }
    h3.felicitation{
        color: black;
        font-size: 22px;
    }
    .facture{
        width: 350px;
        margin: 0 auto;
        background-color: #e0e0e0;
        border: 1px black solid;
        border-radius: 4px;
        box-shadow: 0 0 6px black;
        border-collapse: separate;
        border-spacing: 20px;
    }
    .facture div{
        border-radius: 4px;
        border: #5c5c5c 1px solid;
        background-color: white;
        padding: 10px;
        text-align: center;
    }
    .DesignationHotel{
        color: #7aa3b1;
        font-size: 22px;
        font-family: 'Times New Roman', Times, serif;
    }
    .detail p{
        margin:5px;
        border-bottom: 1px solid #5c5c5c;
    }
    .total{
        text-align: center;
        font-size: 22px;
        border-radius: 4px;
        background-color: #999;
        display: block;
        width: 250px;
        height: 30px;
        margin:0 auto;
    }
    .primary-navigation {
        position: relative;
        bottom:50px;
        margin: 0 auto;
        display: block;
        text-align: center;
        font-size: 16px;
    }
        a {
        list-style: none;
        margin: 0 auto;
        border-left: 2px solid #3ca0e7;
        display: inline-block;
        padding: 0 30px;
        position: relative;
        text-decoration: none;
        text-align: center;
        font-family: arvo;
        color: black;
    }

        a:hover {
        color: #e8139b;
    }
        .primary-navigation a.active {
        background-color: #4caf50;
        color: white;
    }

        .primary-navigation .icon {
        display: none;
    }
    .navbar{
        background-color: #fff;
        width:100%;
        box-shadow:0 0 5px black;
    }
    button {
        background-color: #004b8d;
        color: #ffe6ff;
        padding: 14px 20px;
        margin: 7px 0;
        border: none;
        cursor: pointer;
        width: 250px;
        border-radius: 20px;
        font-size: 20px;
    }
        button:hover {
        background-color: white;
        color: #262626;
        border: 1px solid #262626;
    }
    </style>
</head>
<body>
    <div class="navbar">
    <%
    If (Len(Session("IdClient")) > 0) Then%>
        <!-- #include virtual | file ="menu1.asp" -->
    <% else  %>  
        <!-- #include virtual | file ="menu.asp" --> 
    <% end if %>
    </div>
    <br>
    <div class="corp">
        <center><h3 class="felicitation"> Félicitation !! la chambre est réservée pour vous.</h3></center>

        <center>Votre facture</center><br>
        <table class="facture">
            <tr>
                <td>
                    <div class="entete">
                        <h3 class="DesignationHotel"><%=RsHotel("DesignationHotel")%></h3>
                        <%=RsHotel("VilleHotel")%><br>
                        <%=RsHotel("AdresseHotel")%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="detail">
                        <%
                            if Rsclient("SexeClient") = "m" then
                                civilite = "Mr."
                            else
                                civilite = "Mme."
                            end if
                        %>
                        <h3 style="text-align:center;font-size:22px;">Détail</h3>
                        <p><%=civilite & " " & Rsclient("NomClient") & " " & Rsclient("PrenomClient") %></p><br>
                        <p><span style="text-align:left;">Catégorie</span> <span style="text-align:center;">:</span> <span style="text-align:right;"><%=RsCategorie("DesignationCategorie")%></span></p><br>
                        <p><span style="text-align:left;">Entrée</span> <span style="text-align:center;">:</span> <span style="text-align:right;"><%=debut%></span></p><br>
                        <p><span style="text-align:left;">Sorie</span> <span style="text-align:center;">:</span> <span style="text-align:right;"><%=fin%></span></p><br>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <p class="total">TOTAL : 500 MAD </p>
                </td>
            </tr>
        </table>
    </div>
</body>
</html>
<%

cx.close()
Set cx = Nothing
%>