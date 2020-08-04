<% 
	If(Len(Session("IdUser")) = 0) Then 
		Session("Msg") = "Veuillez vous identifier" 
		Response.redirect "../connexion.asp" 
	End If 
	session("lastperiode") ="" 
%>
<!DOCTYPE html>
<html lang="fr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Formulaire de base</title>
    <link rel="stylesheet" href="styles/styleform.css" />
    <link rel="stylesheet" href="styles/stylemenu.css" />
    <style>
      .TabHead tr td:nth-child(1),
      .TabData tr td:nth-child(1) {
        width: 400px;
      }
      .TabHead tr td:nth-child(2),
      .TabData tr td:nth-child(2) {
        width: 180px;
      }
      .TabHead tr td:nth-child(3),
      .TabData tr td:nth-child(3) {
        width: 180px;
      }
      .TabHead tr td:nth-child(4),
      .TabData tr td:nth-child(4) {
        width: 40px;
        text-align: center;
      }
      td {
        border: 0px solid yellow;
      }
    </style>
    <script src="JS/com.js"></script>
    <script language="javascript">
      var nbm = 0;
      var nbmc = 0;
      function SelectAll(cbg, VCBM) {
        var i;
        nbm = VCBM.length;
        for (i = 0; i < nbm; i++) {
          VCBM[i].checked = cbg.checked;
        }
        if (cbg.checked) {
          nbmc = nbm;
        } else {
          nbmc = 0;
        }
      }
      function SetChange(cbm, cbg, VCBM) {
        nbm = VCBM.length;
        if (cbm.checked) {
          nbmc++;
          if (nbmc == nbm) {
            cbg.checked = true;
            /*alert("nombre de checkbox cochees: "+nbmc+" nbm: "+nbm);*/
          }
        } else {
          nbmc--;
          cbg.checked = false;
          /*alert("nombre de checkbox cochees: "+nbmc+" nbm: "+nbm);*/
        }
      }
      function GetPeriodes(search1, search2, typeRech) {
        //alert("debut");
        if (window.XMLHttpRequest) {
          // code pour IE7+, Firefox, Chrome, Opera, Safari
          xmlhttp = new XMLHttpRequest();
        } else {
          // code pour IE6, IE5
          xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function () {
          if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            document.getElementById("data").innerHTML = xmlhttp.responseText;
          }
        };
        xmlhttp.open(
          "GET",
          "searchPeriode.asp?search1=" +
            search1 +
            "&search2=" +
            search2 +
            "&typeRech=" +
            typeRech,
          true
        );
        xmlhttp.send();
      }
      function verifD(search1, search2, typeRech) {
        if (typeRech == "periode") {
          if (!VerifDate(search1) || !VerifDate(search2) || search1 > search2) {
            alert(
              "Veuillez saisir des dates correctes, sans tmergin s'il vous plaît"
            );
            return;
          }
        }
        GetPeriodes(search1, search2, typeRech);
      }
      function Rediriger() {
        var x = document.getElementById("Redirection").value;
        if (x == "add") document.location = "formulaireInsertPeriode.asp";
        else if (x == "del") VerifS();
      }
      function Modifier(x) {
        document.location = "updatePeriode.asp?idPeriode=" + x;
      }
      function VerifS() {
        if (nbmc == 0) {
          alert("Veuillez selectionner une ou plusieurs Periodes");
          return;
        }
        document.getElementById("formPeriodes").action = "deletePeriode.asp";
        document.getElementById("formPeriodes").method = "POST";
        document.getElementById("formPeriodes").submit();
      }
      function appairer(val) {
        if (val == "periode") {
          document.getElementById("labSearch2").style.visibility = "visible";
          document.getElementById("search2").style.visibility = "visible";
          document.getElementById("search1").setAttribute("placeholder","La date de début...");
          document.getElementById("labSearch1").innerHTML = "La date de début";
        } else {
          document.getElementById("labSearch2").style.visibility = "hidden";
          document.getElementById("search2").style.visibility = "hidden";
          if(val == "designation")
          {
            document.getElementById("search1").setAttribute("placeholder","Saisir la désignation ...");
            document.getElementById("labSearch1").innerHTML = "La désignation de la période";
          }
          else if(val == "idperiode")
          {
            document.getElementById("search1").setAttribute("placeholder","Saisir ID ...");
            document.getElementById("labSearch1").innerHTML = "L'identifiant de la période";
          }
        }
      }
    </script>
  </head>

  <body onload="NavSetActive2(4);">
    <header>
      <!-- on va inclure le fichier menu.inc in chaa Allah -->
      <!--#include file="menu.html"-->
    </header>
    <br /><br />
    <form id="formPeriodes" class="formPC">
      <div class="DivHead">
        <table class="TabHead">
          <tr>
            <td>
              <label id="labSearch1">La désignation de la période</label>
            </td>
            <td>
              <label id="labSearch2" style="visibility: hidden;"
                >La date de fin</label
              >
            </td>
            <td colspan="2">
              <label id="labSearch3">Objet de recherche</label>
            </td>
          </tr>
          <tr>
            <!--onkeyup="javascript:GetPeriodes(document.getElementById('search1').value,document.getElementById('search2').value,document.getElementById('typeRech').value);"-->
            <td>
              <input
                type="text"
                name="textRech1"
                id="search1"
                placeholder="Saisir la désignation ..."
              />
            </td>
            <td>
              <input
                type="text"
                name="textRech2"
                id="search2"
                style="visibility: hidden;"
                placeholder="La date de fin ..."
              />
            </td>
            <td colspan="2">
              <select
                name="typeRech"
                id="typeRech"
                class="selectForm1"
                onchange="javascript:appairer(this.value);"
              >
                <option value="designation">Désignation</option>
                <option value="idperiode">ID</option>
                <option value="periode">Période</option>
              </select>
            </td>
          </tr>
          <tr>
            <td>
              <select class="selectForm1" id="Redirection">
                <option value="add">Ajouter</option>
                <option value="del">Supprimer</option>
              </select>
            </td>
            <td>
              <input
                type="button"
                value="Valider l'operation"
                class="BTR"
                onclick="javascript:Rediriger();"
              />
            </td>
            <td colspan="2">
              <input
                type="button"
                value="Rechercher"
                class="BTR"
                onclick="verifD(document.getElementById('search1').value,document.getElementById('search2').value,document.getElementById('typeRech').value);"
              />
            </td>
          </tr>
          <tr>
            <td><b>Désignation</b></td>
            <td><b>Date de début</b></td>
            <td><b>Date de fin</b></td>
            <td style="width: 30px;">
              <input
                type="checkbox"
                name="CBAll"
                id="CBSAll"
                style="width: 30px;"
                onclick="javascript:SelectAll(this, document.getElementsByName('CBID'));"
              />
            </td>
          </tr>
        </table>
      </div>

      <div id="data" class="DivData"></div>
    </form>
  </body>
</html>
