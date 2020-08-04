<%
	If(Len(Session("IdUser")) = 0) Then
		Session("Msg") = "Veuillez vous identifier"
		Response.redirect "../connexion.asp"
	End If 

	'on doit récupérer idclient
	Id=Request.QueryString("IdChambre")  

	Set cx=Server.CreateObject("ADODB.Connection")
	cx.Open Application("PC")
	Set Rs = Server.CreateObject("ADODB.RecordSet")
    Set Rs2 = Server.CreateObject("ADODB.RecordSet")

	req="select * from TCHAMBRES, THOTELS, TCATEGORIES where (TCHAMBRES.IdHotel = THOTELS.IdHotel) AND (TCHAMBRES.IdCategorie = TCATEGORIES.IdCategorie) AND (IdChambre = " & Id & ")"

	'Response.write req
	'Response.end
	rs.Open req , cx, 3,3

    Orientation = ""
    if Rs("OrientationChambre") = "N" Then
        Orientation = "Nord"
    elseif Rs("OrientationChambre") = "E" Then
        Orientation = "Est"
    elseif Rs("OrientationChambre") = "S" Then
        Orientation = "Sud"
    elseif Rs("OrientationChambre") = "W" Then
        Orientation = "West"
    end if

    req2="select * from TCATEGORIES"
	'Response.write req2
	'Response.end

    rs2.Open req2, cx, 3,3
%>
<!DOCTYPE html>
<html>
<head>

	<title> formulaire de modification </title>
	<meta charset="utf-8"> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="styles/stylemenu.css">
	<link rel="stylesheet" type="text/css" href="styles/style.css">
    <style>
        label{display:inline-block;width:150px;/*border: 1px solid black;*/}
        input[type="radio"]{border: 1px solid red;width: 100px;}
        .iRadio{display:inline;}
        #formulaire{margin-top: 2px}
    </style>
	<script src="JS/com.js"></script>
</head>
<body onload="NavSetActive2(2);">

	<header>
		<!-- on va inclure le fichier menu.inc in chaa Allah -->
		<!--#include file="menu.html"-->
	</header>
	<br>
	<center> <h1 id="titre"> Modifier la chambre </h1> </center>
	<div>
<form action="updateActionChambre.asp" id="formulaire" method="post">
    <input type="hidden" name="IdChambre" value="<%=Rs("IdChambre")%>">
    <input type="hidden" name="IdHotel" value="<%=Rs("IdHotel")%>">
    <label for="DesignationHotel">Hôtel :</label>     <input type="text" name="DesignationHotel" value="<%=Rs("DesignationHotel")%>" readonly><br><br>
    <label for="IdCategorie"> Catégorie :</label>			
                                                            <select name="IdCategorie" id="IdCategorie">
                                                                <option value="<%=Rs("IdCategorie")%>" selected="selected"><%=Rs("DesignationCategorie")%></option>
                                                                <% While NOT Rs2.EOF %>
                                                                <option value="<%=Rs2("IdCategorie")%>"><%=Rs2("DesignationCategorie")%></option>
                                                                <%
                                                                    Rs2.movenext
                                                                    Wend
                                                                %>
                                                            </select>  <br><br>
    <label for="NumeroChambre"> Numéro chambre :</label>	<input type="number" name="NumeroChambre" id="NumeroChambre" value="<%=Rs("NumeroChambre")%>"> <br><br>
    <label for="TelChambre"> Téléphone :</label>		    <input type="text" name="TelChambre" id="TelChambre" value="<%=Rs("TelChambre")%>"> <br> <br>
    <label for="OrientationChambre"> Orientation :</label>				
                                                            <select name="OrientationChambre" id="OrientationChambre">
                                                                <option value="<%=Rs("OrientationChambre")%>" selected="selected"><%=Orientation%></option>
                                                                <option value="N">Nord</option>
                                                                <option value="E">Est</option>
                                                                <option value="S">Sud</option>
                                                                <option value="W">West</option>
                                                            </select>  <br><br>
    <label for="EtageChambre"> Etage :</label>		        <input type="number" name="EtageChambre" id="EtageChambre" value="<%=Rs("EtageChambre")%>"> <br><br>
    <label for="NombrePersonnesMax"> Nb personnes :</label>	<input type="number" name="NombrePersonnesMax" value="<%=Rs("NombrePersonnesMax")%>"> <br><br>
    <label for="NombreLitsEnfant"> Nb lis Enfants :</label>	<input type="number" name="NombreLitsEnfant" value="<%=Rs("NombreLitsEnfant")%>"> <br><br>
    <label for="DoucheChambre">  Douche  :</label>			
                                                            <div class="iRadio"><input type="radio" class="radioo" name="DoucheChambre" value="true"   <%if Rs("DoucheChambre") = true then%> checked <%end if%> ><label for="true">oui</label></div>  
                                                            <div class="iRadio"><input type="radio" class="radioo" name="DoucheChambre" value="false"  <%if Rs("DoucheChambre") = false then%> checked <%end if%> ><label for="false">non</label></div> <br><br>
    <label for="BaignoireChambre"> Baignoire :</label>			
                                                            <div class="iRadio"><input type="radio" class="radioo" name="BaignoireChambre" value="true"  <%if Rs("BaignoireChambre") = true then%> checked <%end if%> ><label for="true">oui</label></div>  
                                                            <div class="iRadio"><input type="radio" class="radioo" name="BaignoireChambre" value="false"  <%if Rs("BaignoireChambre") = false then%> checked <%end if%> ><label for="false">non</label></div> <br><br>
    <label for="ToiletteChambre"> Toilette :</label>			
                                                            <div class="iRadio"><input type="radio" class="radioo" name="ToiletteChambre" value="true"    <%if Rs("ToiletteChambre") = true then%> checked <%end if%> ><label for="true">oui</label></div>  
                                                            <div class="iRadio"><input type="radio" class="radioo" name="ToiletteChambre" value="false"  <%if Rs("ToiletteChambre") = false then%> checked <%end if%> ><label for="false">non</label></div> <br><br>
    <label for="ClimChambre"> Climatiseur :</label>			
                                                            <div class="iRadio"><input type="radio" class="radioo" name="ClimChambre" value="true"  <%if Rs("ClimChambre") = true then%> checked <%end if%> ><label for="true">oui</label></div>  
                                                            <div class="iRadio"><input type="radio" class="radioo" name="ClimChambre" value="false"  <%if Rs("ClimChambre") = false then%> checked <%end if%> ><label for="false">non</label></div> <br><br>
    <label for="TVChambre"> Télévision :</label>			
                                                            <div class="iRadio"><input type="radio" class="radioo" name="TVChambre" value="true"   <%if Rs("TVChambre") = true then%> checked <%end if%> ><label for="true">oui</label></div>  
                                                            <div class="iRadio"><input type="radio" class="radioo" name="TVChambre" value="false"  <%if Rs("TVChambre") = false then%> checked <%end if%> ><label for="false">non</label></div> <br><br>
    <label for="Refrigerateur"> Refrigérateur :</label>			
                                                            <div class="iRadio"><input type="radio" class="radioo" name="Refrigerateur" value="true"  <%if Rs("Refrigerateur") = true then%> checked <%end if%>   ><label for="true">oui</label></div>  
                                                            <div class="iRadio"><input type="radio" class="radioo" name="Refrigerateur" value="false"  <%if Rs("Refrigerateur") = false then%> checked <%end if%> ><label for="false">non</label></div> <br><br>
    <label for="BalconChambre"> Balcon :</label>			
                                                            <div class="iRadio"><input type="radio" class="radioo" name="BalconChambre" value="true"    <%if Rs("BalconChambre") = true then%> checked <%end if%> ><label for="true">oui</label></div>  
                                                            <div class="iRadio"><input type="radio" class="radioo" name="BalconChambre" value="false"  <%if Rs("BalconChambre") = false then%> checked <%end if%> ><label for="false">non</label></div> <br><br>
    <label for="VuePiscine"> Vue Piscine :</label>			
                                                            <div class="iRadio"><input type="radio" class="radioo" name="VuePiscine" value="true"  <%if Rs("VuePiscine") = true then%> checked <%end if%> ><label for="true">oui</label></div>  
                                                            <div class="iRadio"><input type="radio" class="radioo" name="VuePiscine" value="false"  <%if Rs("VuePiscine") = false then%> checked <%end if%> ><label for="false">non</label></div> <br><br>
    <label for="VueJardin">  Vue Jardin  :</label>			
                                                            <div class="iRadio"><input type="radio" class="radioo" name="VueJardin" value="true"  <%if Rs("VueJardin") = true then%> checked <%end if%> ><label for="true">oui</label></div>  
                                                            <div class="iRadio"><input type="radio" class="radioo" name="VueJardin" value="false"  <%if Rs("VueJardin") = false then%> checked <%end if%> ><label for="false">non</label></div> <br><br>
    <!--
    <label> douche: </label>            <input type="text" value="<%=Rs("DoucheChambre")%>">           <br><br>
    <label> Baignoire: </label>         <input type="text" value="<%=Rs("BaignoireChambre")%>">     <br><br>
    <label> Toilette: </label>          <input type="text" value="<%=Rs("ToiletteChambre")%>">       <br><br>
    <label> Climatiseur: </label>       <input type="text" value="<%=Rs("ClimChambre")%>">        <br><br>
    <label> Télévision: </label>        <input type="text" value="<%=Rs("TVChambre")%>">           <br><br>
    <label> Refrigérateur: </label>     <input type="text" value="<%=Rs("Refrigerateur")%>">    <br><br>
    <label> Balcon: </label>            <input type="text" value="<%=Rs("BalconChambre")%>">           <br><br>
    <label> VuePiscine: </label>        <input type="text" value="<%=Rs("VuePiscine")%>">          <br><br>
    <label> VueJardin: </label>         <input type="text" value="<%=Rs("VueJardin")%>">            <br><br>
    -->
    <center>
        <input type="submit" value="CONFIRMER">
    </center>	
</form>
	</div>

</body>
</html>
<%
Rs.close()
Set Rs = nothing
cx.close()
Set cx = Nothing
%>