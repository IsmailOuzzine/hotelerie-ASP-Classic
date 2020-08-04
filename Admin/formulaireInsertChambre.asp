<%If(Len(Session("IdUser")) = 0) Then
    	Session("Msg") = "Veuillez vous identifier"
    	Response.redirect "../connexion.asp"
	End If

    IdHotel=Request("IdHotel")

    Set cx = Server.CreateObject("ADODB.Connection")
    cx.Open Application("PC")
    Set Rs2 = Server.CreateObject("ADODB.RecordSet")

    req2 = "select * from TCATEGORIES"

    on error resume next
	Rs2.Open req2, cx, 3,3
	if err.number <> 0 then
		response.write err.description & "<br> req2 : " & req2 
		response.end
	end if
%>
<!DOCTYPE html>
<html>
<head >

	<title> Ajouter une Chambre </title>
	<meta charset="utf-8"> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" type="text/css" href="styles/style.css">
	<link rel="stylesheet" href="styles/stylemenu.css">
    <style>
        label{display:inline-block;width:150px;/*border: 1px solid black;*/}
        input[type="radio"]{border: 1px solid red;width: 100px;}
        .iRadio{display:inline;}
        #formulaire{margin-top: 3px;}
    </style>
    <script src="JS/com.js"></script>
</head>
<body onload="NavSetActive2(2);">
    <!--<%=IdHotel%>-->

	<header >
		<!-- on va inclure le fichier menu.inc in chaa Allah -->
		<!--#include file="menu.html"-->
	</header>
	<div>
    <center>
        <h1> Ajouter une chambre </h1>
    </center>
    <form action="insertChambre.asp" id="formulaire" method="post">
        <input type="hidden" name="IdHotel" value="<%=IdHotel%>">
		<label for="IdCategorie"> Catégorie :</label>			
                                                                <select name="IdCategorie" id="IdCategorie">
                                                                    <% While NOT Rs2.EOF %>
                                                                    <option value="<%=Rs2("IdCategorie")%>"><%=Rs2("DesignationCategorie")%></option>
                                                                    <%
                                                                        Rs2.movenext
                                                                        Wend
                                                                    %>
                                                                </select>  <br><br>
        <label for="NumeroChambre"> Numéro chambre :</label>		<input type="number" name="NumeroChambre" id="NumeroChambre"> <br><br>
		<label for="TelChambre"> Téléphone :</label>		    <input type="text" name="TelChambre" id="TelChambre"> <br> <br>
		<label for="OrientationChambre"> Orientation :</label>				
														        <select name="OrientationChambre" id="OrientationChambre">
															        <option value="N">Nord</option>
															        <option value="E">Est</option>
															        <option value="S">Sud</option>
															        <option value="W">West</option>
														        </select>  <br><br>
		<label for="EtageChambre"> Etage :</label>		        <input type="number" name="EtageChambre" id="EtageChambre"> <br><br>
		<label for="NombrePersonnesMax"> Nb personnes :</label>	<input type="number" name="NombrePersonnesMax"> <br><br>
		<label for="NombreLitsEnfant"> Nb lis Enfants :</label>	<input type="number" name="NombreLitsEnfant"> <br><br>
		<label for="DoucheChambre">  Douche  :</label>			
                                                                <div class="iRadio"><input type="radio" name="DoucheChambre" value="true"><label for="true">oui</label></div>  
                                                                <div class="iRadio"><input type="radio" name="DoucheChambre" value="false"><label for="false">non</label></div> <br><br>
		<label for="BaignoireChambre"> Baignoire :</label>			
                                                                <div class="iRadio"><input type="radio" name="BaignoireChambre" value="true"><label for="true">oui</label></div>  
                                                                <div class="iRadio"><input type="radio" name="BaignoireChambre" value="false"><label for="false">non</label></div> <br><br>
        <label for="ToiletteChambre"> Toilette :</label>			
                                                                <div class="iRadio"><input type="radio" name="ToiletteChambre" value="true"><label for="true">oui</label></div>  
                                                                <div class="iRadio"><input type="radio" name="ToiletteChambre" value="false"><label for="false">non</label></div> <br><br>
        <label for="ClimChambre"> Climatiseur :</label>			
                                                                <div class="iRadio"><input type="radio" name="ClimChambre" value="true"><label for="true">oui</label></div>  
                                                                <div class="iRadio"><input type="radio" name="ClimChambre" value="false"><label for="false">non</label></div> <br><br>
        <label for="TVChambre"> Télévision :</label>			
                                                                <div class="iRadio"><input type="radio" name="TVChambre" value="true"><label for="true">oui</label></div>  
                                                                <div class="iRadio"><input type="radio" name="TVChambre" value="false"><label for="false">non</label></div> <br><br>
        <label for="Refrigerateur"> Refrigérateur :</label>			
                                                                <div class="iRadio"><input type="radio" name="Refrigerateur" value="true"><label for="true">oui</label></div>  
                                                                <div class="iRadio"><input type="radio" name="Refrigerateur" value="false"><label for="false">non</label></div> <br><br>
        <label for="BalconChambre"> Balcon :</label>			
                                                                <div class="iRadio"><input type="radio" name="BalconChambre" value="true"><label for="true">oui</label></div>  
                                                                <div class="iRadio"><input type="radio" name="BalconChambre" value="false"><label for="false">non</label></div> <br><br>
        <label for="VuePiscine"> Vue Piscine :</label>			
                                                                <div class="iRadio"><input type="radio" name="VuePiscine" value="true"><label for="true">oui</label></div>  
                                                                <div class="iRadio"><input type="radio" name="VuePiscine" value="false"><label for="false">non</label></div> <br><br>
        <label for="VueJardin">  Vue Jardin  :</label>			
                                                                <div class="iRadio"><input type="radio" name="VueJardin" value="true"><label for="true">oui</label></div>  
                                                                <div class="iRadio"><input type="radio" name="VueJardin" value="false"><label for="false">non</label></div> <br><br>
        
							<center>		<input type="submit" value="AJOUTER" >			</center>
   
</form>
</div>

</body>
</html>
<%
Rs1.close()
Set Rs1 = nothing
Rs2.close()
Set Rs2 = nothing
cx.close()
Set cx = Nothing
%>