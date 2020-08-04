<%
    If(Len(Session("IdUser")) = 0) Then
		Session("Msg") = "Veuillez vous identifier"
		Response.redirect "../connexion.asp"
	End If 

    IdTarif=Request("IdTarif")

    Set cx = Server.CreateObject("ADODB.Connection")
    cx.Open Application("PC")

    Set Rs = Server.CreateObject("ADODB.RecordSet")

    req = "select TTARIFS.*, THOTELS.DesignationHotel, TCATEGORIES.DesignationCategorie,TPERIODES.DesignationPeriode, TPERIODES.DateDebutPeriode, TPERIODES.DateFinPeriode from (((TTARIFS inner join THOTELS on (TTARIFS.IdHotel = THOTELS.IdHotel)) inner join TCATEGORIES on (TTARIFS.IdCategorie = TCATEGORIES.IdCategorie)) inner join TPERIODES on (TTARIFS.IdPeriode = TPERIODES.IdPeriode)) where IdTarif =" & IdTarif

    'Response.write "REQ: " & req
    'Response.end

    on error resume next
	Rs.Open req, cx, 3,3
	if err.number <> 0 then
		response.write err.description & "<br> req : " & req
		response.end
	end if
%>
<!DOCTYPE html>
<html>
<head >

	<title> Modifier un tarif</title>
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

	<center> <h1 id=" titre " > Modifier un tarif </h1> </center>
	<div>
	<form action="updateActionTarif.asp" id="formulaire" method="post">
		<label for="IdTarif">ID:</label>	            
                                                    <input type="text" name="IdTarif" value="<%=Rs("IdTarif")%>" readonly>    <br><br>        
		<label for="IdHotel">Hôtel:</label>	            
                                                    <input type="hidden" name="IdHotel" value="<%=Rs("IdHotel")%>">     
                                                    <input type="text" name="DesignationHotel" value="<%=Rs("DesignationHotel")%>" readonly>    <br><br>
		<label for="IdPeriode">Période:</label>	        
                                                    <input type="hidden" name="IdPeriode" value="<%=Rs("IdPeriode")%>"> 
                                                    <input type="text" name="DesignationPeriode" value="<%=Rs("DesignationPeriode")%>       (<%=Rs("DateDebutPeriode")%> --> <%=Rs("DateFinPeriode")%>)" readonly><br><br>
		<label for="IdCategorie">Catégorie:</label>	    
                                                    <input type="hidden" name="IdCategorie" value="<%=Rs("IdCategorie")%>">
                                                    <input type="text" name="DesignationCategorie" value="<%=Rs("DesignationCategorie")%>" readonly>    <br><br>
		
        <label for="Tarif">Tarif:</label>	        <input type="number" name="Tarif" value="<%=Rs("Tarif")%>" required>    <br><br>
		      
		<center> <input type="submit" value="CONFIRMER"> </center>   
</form>
</div>

</body>
</html>