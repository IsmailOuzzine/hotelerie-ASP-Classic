<html>
    <head>
       <meta charset="utf-8">
        
        <link rel="stylesheet" href="Admin/styles/styleform.css" media="screen" type="text/css" />
        <style>
            #container{margin:0 auto;width:900px;border: 0px solid black;}
            #logo{display:block;border: 0px solid black; margin:0 auto}
            #formulaireConn{
                color:darkgreen;
                margin: 20px auto;
                background-color: rgba(255, 255, 255, 1);
                width: 600px;
                height:300px;
                border-radius: 10px;
                padding: 20px;
                border: 0px solid  rgb(53, 53, 53);
                box-shadow: 0 0 10px black
                /*padding:100px;*/
            }
            .labelConn{display:inline-block;width:150px;border: 0px solid black;}
            .text1{width:250px}
        </style>
        <SCRIPT>
            function Verif()
            {
                var login  = document.getElementById('username') ;
                var passwd = document.getElementById('password') ;
                if(login.value.length == 0)
                {
                    alert('Veuillez saisir le login') ;
                    login.focus() ;
                    return ;
                }
                if(passwd.value.length == 0)
                {
                    alert('Veuillez saisir le mot de passe') ;
                    passwd.focus() ;
                    return ;
                }
                document.getElementById('inscription').submit() ; 
            }
        </SCRIPT>
    </head>
    <body>
        <div id="container">
            <img src="Admin/img/CONTACTHotels.jpg" id="logo" width="250px" height="auto">
            <form id="formulaireConn" action="connexionAction.asp"  name="inscription"  method="post">
                <center>
                <h1>Connectez vous</h1>
                
                <label class="labelConn"><b>Nom d'utilisateur</b></label>
                <input type="text" placeholder="Entrer le nom d'utilisateur" name="username" required class="text1" value="<%=Session("Log")%>">
                <br><br>

                <label class="labelConn"><b>Mot de passe</b></label>
                <input type="password" placeholder="Entrer le mot de passe" name="password" required class="text1" value="<%=Session("Pas")%>">
                <br><br>

                <input type="submit" id="submit" value="LOGIN"><br><br>

                <%If (Len(Session("Msg")) > 0) Then%>
                
                    <b><font color="red"><%=Session("Msg")%></font></b>
                    
                <%End If%>
                <center>
            </form>
        </div>
    </body>
</html>
<%
    Session("Msg") = ""
    Session("Log") = ""
    Session("Pas") = "" 
%>