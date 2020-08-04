
<!DOCTYPE html>
<html>
<head>
	<title></title>

<link href="https://fonts.googleapis.com/css?family=Arvo&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript">
  function myFunction() {
  var x = document.getElementById("myTopnav");
  if (x.className === "primary-navigation") {
    x.className += " responsive";
  } else {
    x.className = "primary-navigation";
  }
}
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
                //document.getElementById('FormLogin').action = 'connexionAction.asp' ;
                document.getElementById('connexion').submit() ; 
            }
    
</script>
<style>
.

  .login {
    -webkit-appearance: none;
    border: 1px solid #ccd0d5;
    border-radius: 0;
    margin: 0;
    padding: 3px;
}

table tr td {
    padding: 0 0 0 14px;
        font-family: Helvetica, Arial, sans-serif;
    font-size: 12px;

}
}

  </style>

  <div ><form action="connexionCLIENT.asp"  name="connexion"  id="connexion"  method="post">
   <img src="img/CONTACTHotels1.jpg" alt="ContactHôtels logo" width="200" height="100"> 


<table cellspacing="0" role="presentation" style="font-size: 12px;  float: right;">
  <tr><td class="html7magic">
  <label for="email">Adresse e-mail </label>
</td>
<td class="html7magic">
  <label for="pass">Mot de passe</label>
</td>
</tr><tr>
  <td>
    <input type="email" class="login" name="username" id="username" value="<%=Session("Log")%>" style="width: 142px;"  >
  </td>
  <td> 

    <input type="password" class="login" name="password" id="password" value="<%=Session("Pas")%>" style="width: 142px;" >
  </td>
  <td>
    
    <button name="BTConnexion" id="BTConnexion" value="Se Connecter" onclick="javascript:Verif();"style="width: 142px;" > connexion </button> 
                 <%If (Len(Session("Msg")) > 0) Then%>
                        
                                <b><font color="red"><%=Session("Msg")%></font></b>
                         
                        <%End If%>
  </form>
</td>
</tr>
   </table>
    
  
   
<nav role="navigation" class="primary-navigation" id="myTopnav">

  	<a href="Accueil.asp">Accueil </a> 
     <a href="nosHotels.asp">Nos Hotels </a>
     <a href="clientformulaire.asp">Inscription </a>
     <a href="nous.asp">Qui Somme nous  </a>
     <a href="dateperiode.asp">Les dates des Periodes </a>
     <a href="javascript:void(0);" class="icon" onclick="myFunction()"> 
    <i class="fa fa-bars"></i> </a>


</nav>
</div>


</head>
<body>

</body>
</html>
<%
    Session("Msg") = ""
    Session("Log") = ""
    Session("Pas") = "" 
%>