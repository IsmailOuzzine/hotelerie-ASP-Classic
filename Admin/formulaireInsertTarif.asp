<%
    If(Len(Session("IdUser")) = 0) Then
		Session("Msg") = "Veuillez vous identifier"
		Response.redirect "../connexion.asp"
	End If 
    Set cx = Server.CreateObject("ADODB.Connection")
    cx.Open Application("PC")
    '******************TCATEGORIES******************
    Set Rs1 = Server.CreateObject("ADODB.RecordSet")

    req1 = "select * from TCATEGORIES"

    on error resume next
	Rs1.Open req1, cx, 3,3
	if err.number <> 0 then
		response.write err.description & "<br> req1 : " & req1
		response.end
	end if
    '******************TPERIODES******************
    Set Rs2 = Server.CreateObject("ADODB.RecordSet")

    req2 = "select * from TPERIODES"

    on error resume next
	Rs2.Open req2, cx, 3,3
	if err.number <> 0 then
		response.write err.description & "<br> req2 : " & req2
		response.end
	end if 
    '******************THOTELS******************
    Set Rs3 = Server.CreateObject("ADODB.RecordSet")

    req3 = "select IdHotel, DesignationHotel from THOTELS order by DesignationHotel"

    on error resume next
	Rs3.Open req3, cx, 3,3
	if err.number <> 0 then
		response.write err.description & "<br> req3 : " & req3
		response.end
	end if
%>
<!DOCTYPE html>
<html>
<head >

	<title> Ajouter un nouvel tarif</title>
	<meta charset="utf-8"> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" type="text/css" href="styles/style.css">
	<link rel="stylesheet" href="styles/stylemenu.css">
	<script src="JS/com.js"></script>
    <script>
        function responsiveClass()
            {
                var x = document.getElementById("menu");
                if(x.className === "topnav")
                {
                    x.className = "responsive";
                }
                else
                {
                    x.className = "topnav";
                }
            }
    </script>
</head>
<body onload="NavSetActive2(5);">

	<header>
		<!-- on va inclure le fichier menu.inc in chaa Allah -->
		<!--#include file="menu.html"-->
	</header>
	<br><br>

	<center> <h1 id=" titre " > Ajouter un tarif </h1> </center>
	<div>
	<form action="insertTarif.asp" id="formulaire" method="post">	
		<label for="IdHotel">Hôtel:</label>	                                            
                                                    <select name="IdHotel">
                                                        <%WHILE NOT Rs3.EOF%>
                                                        <option value="<%=Rs3("IdHotel")%>"><%=Rs3("DesignationHotel")%></option>
                                                        <%
                                                            Rs3.movenext
                                                            WEND
                                                        %>
                                                    </select>   <br><br>
		<label for="IdPeriode">Période:</label>	
                                                    <select name="IdPeriode">
                                                        <%WHILE NOT Rs2.EOF%>
                                                        <option value="<%=Rs2("IdPeriode")%>"><%=Rs2("DesignationPeriode")%> <span class="lesDates" style="font-style: italic;color: #888;">(<%=Rs2("DateDebutPeriode")%> --> <%=Rs2("DateFinPeriode")%>)</span></option>
                                                        <%
                                                            Rs2.movenext
                                                            WEND
                                                        %>
                                                    </select>   <br><br>
		<label for="IdCategorie">Catégorie:</label>	
                                                    <select name="IdCategorie">
                                                        <%WHILE NOT Rs1.EOF%>
                                                        <option value="<%=Rs1("IdCategorie")%>"><%=Rs1("DesignationCategorie")%></option>
                                                        <%
                                                            Rs1.movenext
                                                            WEND
                                                        %>
                                                    </select>   <br><br>
		<label for="Tarif">Tarif:</label>	        <input type="number" id="Tarif" name="Tarif" required>  <br><br>
		      
		<center> <input type="submit" value="AJOUTER"> </center>   
</form>
</div>

</body>
</html>