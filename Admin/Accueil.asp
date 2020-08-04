<%
    If(Len(Session("IdUser")) = 0) Then
		Session("Msg") = "Veuillez vous identifier"
		Response.redirect "../connexion.asp"
	End If 
%>
<!DOCTYPE html>
<html>
<head >

	<title> Welcome </title>
	<meta charset="utf-8"> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" type="text/css" href="styles/style.css">
	<link rel="stylesheet" href="styles/stylemenu.css">
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
<body>

<header >
    <!-- on va inclure le fichier menu.inc in chaa Allah -->
    <!--#include file="menu.html"-->
</header>
<br><br><br><br>

    <center><img src="img/CONTACTHotels.jpg" width="600px" height="auto"></center>
</body>
</html>
	