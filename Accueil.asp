<% 
Set cx = Server.CreateObject("ADODB.Connection")
cx.Open Application("PC")  
Set Rs = Server.CreateObject("ADODB.RecordSet")
Set Rs1 = Server.CreateObject("ADODB.RecordSet")
req = "select  * from THOTELS  order by DesignationHotel"
req1 = "select  * from TCATEGORIES  order by DesignationCategorie"
Rs.Open req, cx, 3,3
Rs1.Open req1, cx, 3,3
%>

<!DOCTYPE html>
<html>
<head>
	<title>  Bienvenue</title>
	<link rel="stylesheet" type="text/css" href="style/style.css">
	<meta charset="utf-8">
	<style>
.
.choix {
	position: relative;

    margin: 0 auto;
    display: block;
    text-align: center;
    font-size: 16px;}
 .choix ul li {
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
 

	</style>
	<script type="text/javascript">
		function subReserver(hotel, debut, fin, categ)
		{
			if(hotel.value.length == 0)
			{
				alert("hotel!!!");
				return;
			}
			else if(debut.value.length == 0)
			{
				alert("debut!!!" + debut.value);
				return;
			}
			else if(fin.value.length == 0)
			{
				alert("fin!!!" + fin.value);
				return;
			}
			else if(categ.value.length == 0)
			{
				alert("categ!!!");
				return;
			}			
			document.getElementById("fromReserver").action = "reserverAction.asp";
			document.getElementById("fromReserver").method = "POST";
			document.getElementById("fromReserver").submit();
		}
	</script>
</head>
<body class="backgroundAA">
<%
 If (Len(Session("IdClient")) > 0) Then%>
<!-- #include virtual | file ="menu1.asp" -->
<% else  %>  
<!-- #include virtual | file ="menu.asp" --> 
<% end if %>

</div>
 
<br> <br>
<br> <br> <br><br><br>
<br> <br> <br>
<center>
<form style="width: 90%" class="ReserverForm" id="fromReserver">
	 <div class="choix">
	
	<ul>
		
			<li>  
				<select style="background-color: #CCC" id="hotel" name="IdHotel"> 
						<option>
							sélectionnez un hôtel
						</option>
						 <%WHILE NOT Rs.EOF%>
                         <option value="<%=Rs("IdHotel")%>"><%=Rs("DesignationHotel")%></option>
                             <%
                                 Rs.movenext
                                  WEND
                              %>
				</select> </li>

			
			<li >Date d'entrée <input type="Date" name="DateDeDebut" style="background-color: #CCC" id="debut">  </li>
			<li> Date de sortie <input type="Date" name="DateDeFin"style="background-color: #CCC" id="fin"> </li>
			<li>  <select style="background-color: #CCC" id="categ" name="IdCategorie"> 
						<option>
							Categorie de chambre
						</option>
						<%WHILE NOT Rs1.EOF%>
                         <option value="<%=Rs1("IdCategorie")%>"><%=Rs1("DesignationCategorie")%></option>
                             <%
                                 Rs1.movenext
                                  WEND
                              %>
				</select></li>

		

	</ul>
</div>
 
</form>
 <button onclick="subReserver(document.getElementById('hotel'), document.getElementById('debut'), document.getElementById('fin'), document.getElementById('categ'));"> Reserver</button>
</center>

</body>

</html>