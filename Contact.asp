<!DOCTYPE html>
<html>

<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
  <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
  <title>Contact</title>
  <link rel="stylesheet" href="Style/style_contact.css" type="text/css" media="screen" />
</head>

<body>
   
<div class="container">
    <form name="FormContact" id="FormContact" action="ContactAction.asp" method="post">
      <h3 id="header">Contactez nous</h3>
      <input type="text" name="TNom" id="TNom" placeholder="Nom" required value="<%=Session("Nom")%>">
      <input type="text" name="TPrenom" id="TPrenom" placeholder="Prenom" value="<%=Session("Prenom")%>">
      <input type="number" name="TGSM" id="TGSM" placeholder="N°GSM" value="<%=Session("GSM")%>">
      <input type="email" name="TEmail" id="TEmail" placeholder="Email" value="<%=Session("Email")%>">
      <textarea name="TMessage" id="Message" cols="30" rows="10" placeholder="Saisir votre message ..." value="<%=Session("Message")%>"></textarea>
      <button type="button" name="BTEnvoi" id="BTConnexion" onclick="verifContact()">Envoyer</button>
    </form>
  </div>
  <script>
    function verifContact() {
      var inputs = document.getElementsByTagName('input');
      for (var e of inputs) {
        if (e.value === '') {
          alert('le ' + e.placeholder + ' est obligatoire !');
          e.focus();
          return;
        }
      }
      document.getElementById('FormContact').submit();
    }
  </script>
</body>

</html>
<%
	Session("Msg") = ""
	Session("Log") = ""
	Session("Pas") = ""
%>