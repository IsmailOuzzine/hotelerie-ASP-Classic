<%
if(Len(Session("IdClient")) = 0)then
    Session("Msg") = "Veuillez vous identifiez ou vous inscrire"
  Response.redirect "clientformulaire.asp"
  Response.end
end if

IdHotel = Request("IdHotel")
IdCategorie = Request("IdCategorie")
debut = Request("DateDeDebut")

fin = Request("DateDeFin")

IdClient = Session("IdClient")

Set cx = Server.CreateObject("ADODB.Connection")
cx.Open Application("PC")
Set Rs = Server.CreateObject("ADODB.RecordSet")

req="reqChambreReturn " & IdHotel & ", " & IdCategorie & ", '" & debut & "', '" & fin & "'" 
'Response.write req
'Response.end
Rs.Open req, cx, 3, 3
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reserver</title>
    <link rel="stylesheet" href="style/style.css">
    <style>
      body {
        background-image: url("img/bgismail2.jpg");
        background-size: cover;

        font-family: Arial;
        margin: 0px;
        padding: 0px;
      }
      div {
        border: 0px solid red;
      }
      td {
        border: 0px solid #00ffd9;
      }
      .header {
        width: 100%;
        background-color: white;
        margin: 0px;
        box-shadow: 0 0 10px black;
        position: fixed;
        display: flex;
      }
      .menu {
        width: 800px;
        overflow: hidden;
        margin: 30px auto 0 auto;
        padding: 0;
        border: black 0px solid;
      }
      .menu a {
        width: 150px;
        text-decoration: none;
        float: left;
        display: block;
        border-left: 1px solid rgb(66, 66, 218);
        color: rgb(19, 19, 95);
        text-align: center;
      }
      .menu a:hover {
        color: rgb(101, 183, 255);
      }
      .connexion {
        position: relative;
        right: 20px;
      }
      #mondiv{
        width: 502px;
        height: 500px;
        margin: 0 auto;
        box-shadow:0 0 10px 0 rgba(0,0,0,0.7);
        background-color: rgba(255, 255, 255, 0.7);
      }
      .content {
        margin: 0 auto;
        width: 502px;
        height: 50px;
        border-bottom: 1px dotted black;
      }/*
      .lines {
        border: 0px double blue;
        width: 200px;
        height: 200px;
      }
      .lines img{
        width: 100%;
        height: 100%;
      }*/
      .flip-card {
        background-color: transparent;
        width: 200px;
        height: 200px;
        perspective: 1000px;
      }

      .flip-card-inner {
        position: relative;
        width: 100%;
        height: 100%;
        text-align: center;
        transition: transform 0.6s;
        transform-style: preserve-3d;
        box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
      }

      .flip-card:hover .flip-card-inner {
        transform: rotateY(180deg);
      }

      .flip-card-front, .flip-card-back {
        position: absolute;
        width: 100%;
        height: 100%;
        -webkit-backface-visibility: hidden;
        backface-visibility: hidden;
      }

      .flip-card-front {
        background-color: #bbb;
        color: black;
      }

      .flip-card-back {
        background-color: #2980b9;
        color: white;
        padding: 10px;
        transform: rotateY(180deg);
      }
      .MyWindow{
        width: 500px;
        height: 400px;
        margin: 0 auto;
        overflow: auto;
      }
      .selected, .noSelected{
        width: 200px;
        height: 200px;
        margin: 10px auto;
      }
      .selected img, .noSelected img{
        width: 200px;
        height: 200px;
        margin: 0;
      }
      .noSelected:hover{
        box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
      }
      .selected{
        border: 2px solid black;
        box-shadow:  0 4px 16px 0 rgba(0,0,0,0.2);
      }
      .donnees {
        width: 400px;
        height: 100%;
        padding: 2px;
        text-align: center;
        position: relative;
        bottom: 210px;
        left: 200px;
        border: 1px red solid;
        background-color: rgba(255,255,255,0.6);
      }
      .donnees,
      .donnees h3 {
        font-size: 20px;
      }
      .desole{
        width:600px;
        height:100px;
        margin:200px auto;
        background-color:rgba(96, 113, 223, 0.5) ;
        color: red;
        font-size: 22px;
        border-radius: 4px;
        border: rgb(19, 19, 95) solid 1px;
        padding:7px;
        text-align:center;
      }
      @media screen and (max-width: 1000px){
        .mondiv{
          width: 100%;
        }
        
      }
    </style>
    <script>
      function cocher(there)
      {
        if(document.getElementsByClassName("selected").length > 0)
          document.getElementsByClassName("selected")[0].setAttribute("class", "flip-card noSelected");
        there.setAttribute("class", "flip-card selected");
        there.getElementsByTagName("input")[0].setAttribute("name", "IdChambre");
        //' alert(there + " selected");
      }
      function Reserver()
      {
        if(document.getElementsByClassName("selected").length == 0)
        {
          alert("Choisissez une chambre !");
          return;
        }
        document.getElementById("lesChambres").action = "reserveEffectuee.asp";
        document.getElementById("lesChambres").method = "POST";
        document.getElementById("lesChambres").submit();
      }
    </script>
</head>
<body>

    <% If (Len(Session("IdClient")) > 0) Then%>
    <!-- #include virtual | file ="menu1.asp" -->
    <% else  %>  
    <!-- #include virtual | file ="menu.asp" --> 
    <% end if %>

    <%if Rs.RecordCount = 0 then%>
    <div class="desole">
      <p> Désolé, les chambres tels que vous avez demandé sont déja réservés </p>
    </div>
    <%else%>
    <div id="mondiv">
      <table class="content">
        <tr>
          <td><center>Le tarif est 500 MAD <br> <button onclick="Reserver();">Réserver</button></center></td>
        </tr>
      </table>
      <div class="MyWindow">
        <form id="lesChambres">
          <% i = 0 
          while not Rs.EOF
          if i=2 then
            i=0
          end if  
          'if ((i mod 2) = 0) then
          %>
          <div class="flip-card noSelected" onclick="cocher(this);" >
          <div class="flip-card-inner">
            <div class="flip-card-front">
              <img alt="<%=Rs("DesignationCategorie")%>" src="Img/chambre<%=i+1%>.jpg">
            </div>
            <div class="flip-card-back">
              <h3><%=Rs("DesignationCategorie")%></h3>
              <%=Rs("IdChambre")%><br>
              à partir de: 500 MAD
              <input type="hidden" name="ChambreId" value="<%=Rs("IdChambre")%>">
            </div>
          </div>
        </div>
          <%
            i=i+1
            Rs.movenext
            wend
          %>
          <input type="hidden" name="DateDeDebut" value="<%=debut%>">
          <input type="hidden" name="DateDeFin" value="<%=fin%>">
          <input type="hidden" name="IdHotel" value="<%=IdHotel%>">
          <input type="hidden" name="IdCategorie" value="<%=IdCategorie%>">
        </form>
      </div>
    </div>  
    <%end if%>
</body>
</html>
<%
Rs.close()
Set Rs = Nothing
cx.close()
Set cx = Nothing
%>