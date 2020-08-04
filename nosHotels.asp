<%
  Set cx=Server.CreateObject("ADODB.Connection")
	cx.Open Application("PC")
	Set Rs = Server.CreateObject("ADODB.RecordSet")
  req="select top 4 * from THOTELS order by IdHotel desc"
  Rs.open req, cx, 3,3 
%>
<!DOCTYPE html>
<html lang="fr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" type="text/css" href="style/style.css">
    <title>Nos hôtels</title>
    <style>
      body {
        background-color: #346347;
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
      .content {
        margin: 0 auto;
        width: 700px;
        background-color: rgba(255, 255, 255, 0.4);
        border-collapse: separate;
        border-spacing: 20px;
      }
      .lines {
        border: 0px double blue;
        width: 300px;
        height: 300px;
      }
      .lines img{
        width: 100%;
        height: 100%;
      }
      .lines .donnees {
        width: 50%;
        height: 50%;
        padding: 2px;
        text-align: center;
        position: relative;
        bottom: 75%;
        left: 25%;
        border: 1px red solid;
      }
      .donnees,
      .donnees h1 {
        font-size: 20px;
      }
      @media screen and (max-width: 1000px){
        .content{
          width: 100%;
        }
        
      }
    </style>
  </head>
      <%
 If (Len(Session("IdClient")) > 0) Then%>
<!-- #include virtual | file ="menu1.asp" -->
<% else  %>  
<!-- #include virtual | file ="menu.asp" --> 
<% end if %>
  <body class="backgroundAA" >

<br> <br>
      
    <br><br><br><br> 
    <table class="content">
      <% i = 0 
      while not Rs.EOF 
      if i = 4 then 
        i=0 
      end if 
      if ((i mod 2) = 0) then
      %>
      <tr>
        <td>
          <div class="lines" title="Cliquer pour réserver">
            <img alt="<%=Rs("DesignationHotel")%>"
            src="img/img<%=i+1%>.jpg"/>
            <div class="donnees" style="background-color : #ffe6ff; opacity: 60%;">
              <h4><%=Rs("DesignationHotel")%></h4>
              <%=Rs("VilleHotel")%><br />
              à partir de: 500 MAD
            </div>
          </div>
        </td>
        <% else %>
        <td>
          <div class="lines" title="Cliquer pour réserver">
            <img alt="<%=Rs("DesignationHotel")%>"
            src="img/img<%=i+1%>.jpg"/>
            <div class="donnees"  style="background-color : #ffe6ff; opacity: 60%;">
              <h4><%=Rs("DesignationHotel")%></h4>
              <%=Rs("VilleHotel")%><br />
              à partir de: 500 MAD
            </div>
          </div>
        </td>
      </tr>
      <%
        end if
        i=i+1
        Rs.movenext
        wend
      %>
    </table>
  </body>
</html>

<%
  Rs.close()
  set Rs=Nothing
  cx.close()
  Set cx=Nothing
%>
