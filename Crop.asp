<%	
	If((Len(Session("Iduser")) = 0) OR (Session("ID") <> Session.SessionId)) Then
		Session("MSG") = "Veuillez vous identifier"
		Response.Redirect "Login.asp"
	End If
%>
<html lang="fr">

<head>
	<title>Découpage Image</title>
	<meta name="description" content="Manipulation des photos des étudiants">
	<meta name="keywords" content="FSTS, ESPACE ETUDIANT, ORIENTATION, DEUST, LST, CHOIX DES FILIERS">
	<meta content="index, follow" name="robots">
	<meta charset="UTF-8">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

	<script language="JavaScript">
		var tst, tst2,
			crd_x = 140,
			crd_y = 140,
			img_x = 120,
			img_y = 120,
			pos_x = 0,
			pos_y = 0,
			wo = 0,
			ho = 0,
			w = 0,
			h = 0,
			fact = 1,
			OImg = new Image();

		function TElement(id) {
			this.id = id;
			this.elt = (this.id) ? document.getElementById(id) : null;

			function getX() {
				return this.elt.offsetLeft;
			}
			TElement.prototype.getX = getX;


			function getY() {
				return this.elt.offsetTop;
			}
			TElement.prototype.getY = getY;

			function setX(x) {
				return this.elt.style.left = x + "px";
			}
			TElement.prototype.setX = setX;

			function setY(y) {
				return this.elt.style.top = y + "px"
			}
			TElement.prototype.setY = setY;

		}

		function TEvent() {
			this.x = 0;
			this.y = 0;

			function init(evt) {
				this.evt = (evt) ? evt : window.event; // l'objet événement 
				if (!this.evt) return;
				this.elt = (this.evt.target) ? this.evt.target : this.evt.srcElement; // la source de l'événement 

				this.id = (this.elt) ? this.elt.id : "";

				// Calcul des coordonnées de la souris par rapport au document 

				if (this.evt.pageX || this.evt.pageY) {
					this.x = this.evt.pageX;
					this.y = this.evt.pageY;
				} else if (this.evt.clientX || this.evt.clientY) {
					this.x = this.evt.clientX + document.body.scrollLeft;
					this.y = this.evt.clientY + document.body.scrollTop;
				}
			}
			TEvent.prototype.init = init;

			function stop() {
				this.evt.cancelBubble = true;
				if (this.evt.stopPropagation) this.evt.stopPropagation(); //Annuler l'appel de meme event
			}
			TEvent.prototype.stop = stop;
		}

		function TDragObject(id) {
			if (!id) return;
			this.base = TElement;

			this.base(id);
			this.elt.obj = this
			this.elt.onmousedown = _startDrag; // When mouse bouton is pressed

			function startDrag(evt) {
				this.elt.style.zIndex = 1; //  Place in front
				this.lastMouseX = evt.x;
				this.lastMouseY = evt.y;
				evt.dragObject = this;

				document.onmousemove = _drag;
				document.onmouseup = _stopDrag;

				if (this.onStartDrag) this.onStartDrag();
			}
			TDragObject.prototype.startDrag = startDrag;

			function stopDrag(evt) {
				this.elt.style.zIndex = 0;
				evt.dragObject = null;
				document.onmousemove = null;
				document.onmouseup = null;

				if (this.onDrop) this.onDrop();
			}
			TDragObject.prototype.stopDrag = stopDrag;

			function drag(evt) {
				dX = this.getX() + evt.x - this.lastMouseX;
				dY = this.getY() + evt.y - this.lastMouseY;

				this.setX(dX);
				this.setY(dY);

				this.lastMouseX = evt.x;
				this.lastMouseY = evt.y;

				if (this.onDrag) this.onDrag();

			}
			TDragObject.prototype.drag = drag;
		}
		TDragObject.prototype = new TElement();

		var _event = new TEvent(); // Objet global pour manipuler l'événement en cours 

		function _startDrag(evt) {
			_event.init(evt);
			if (this.obj && this.obj.startDrag) {
				this.obj.startDrag(_event);
			}
		}

		function _stopDrag(evt) {
			if (_event.dragObject) _event.dragObject.stopDrag(_event);
		}

		function _drag(evt) {
			_event.init(evt);
			if (_event.dragObject) _event.dragObject.drag(_event);
			return false;
		}

		function afficherStatus() {
			if (this.id == 'crd') {
				crd_x = this.getX();
				crd_y = this.getY();

			} else if (this.id == 'img') {
				img_x = this.getX();
				img_y = this.getY();
			}
			pos_x = crd_x - img_x;
			pos_y = crd_y - img_y;
			document.getElementById('crd_x').value = crd_x;
			document.getElementById('crd_y').value = crd_y;
			document.getElementById('img_x').value = img_x;
			document.getElementById('img_y').value = img_y;
			document.getElementById('pos_x').value = pos_x;
			document.getElementById('pos_y').value = pos_y;
		}

		function load() {
			tst = new TDragObject("img");
			tst.onDrag = afficherStatus;

			tst2 = new TDragObject("crd");
			tst2.onDrag = afficherStatus;

			OImg.src = document.getElementById('photo').src;
			wo = OImg.width;
			ho = OImg.height;
		}

		function ResizeUp() {
			if (fact > 2.0)
				return;
			fact = fact + 0.05;
			document.getElementById('photo').style.width = parseInt(wo * fact);
			document.getElementById('photo').style.height = parseInt(ho * fact);
			document.getElementById('photo').style.display = 'none';
			document.getElementById('ratio').value = fact.toFixed(2);
			console.log('w :' + document.getElementById('photo').width + ' value-w:' + parseInt(wo * fact) + ' h :' + document
				.getElementById('photo').height + ' r :' + fact.toFixed(2))
		}

		function ResizeDown() {
			if (fact < 0.3)
				return;
			fact = fact - 0.05;
			document.getElementById('photo').style.width = parseInt(wo * fact);
			document.getElementById('photo').style.height = parseInt(ho * fact);
			document.getElementById('ratio').value = fact.toFixed(2); //convert to str
			console.log('w :' + document.getElementById('photo').width + ' value-w:' + parseInt(wo * fact) + ' h :' + document
				.getElementById('photo').height + ' r :' + fact.toFixed(2))
		}

		function ChangeColor(color) {
			document.getElementById('crd').style.border = '2px dashed ' + color;
		}

		function ChangePos() {
			var cod = window.event.keyCode;
			var crd = document.getElementById('crd');

			if (cod == 37) {
				crd_x = tst2.getX() - 1;
				tst2.setX(crd_x);
			} else if (cod == 38) {
				crd_y = tst2.getY() - 1;
				tst2.setY(crd_y);
			} else if (cod == 39) {
				crd_x = tst2.getX() + 1;
				tst2.setX(crd_x);
			} else if (cod == 40) {
				crd_y = tst2.getY() + 1;
				tst2.setY(crd_y);
			}
			afficherStatus();
		}

		function Crop() {
			document.getElementById('CropForm').submit();
		}
	</script>
	<style>
		.Crop-img-class {
			display: block;
			position: fixed;
			z-index: 1;
			left: 0;
			top: 0;
			width: 100%;
			height: 100%;
			overflow: auto;
			background-color: rgb(0, 0, 0);
			background-color: rgba(0, 0, 0, 0.4);
		}

		/** Modal Content/Box */
		.crop-content {
			background-color: #fefefe;
			margin: 5% auto;
			padding: 20px;
			border: 1px solid #888;
			width: 80%;
			height: 80%;
			border-radius: 10px;
		}

		.BTfermer {
			color: #aaa;
			float: right;
			font-size: 28px;
			font-weight: bold;
		}

		.BTfermer:hover,
		.BTfermer:focus {
			color: black;
			text-decoration: none;
			cursor: pointer;
		}

		.ratio-menu input {
			padding: 10px;
			margin: 50px 10px;
			cursor: pointer;
			width: 100px;
			display: flex;
			text-align: center;
		}

		.ratio-menu {
			float: right;
		}

		.dragDrop {
			position: absolute;
		}
	</style>

</head>

<body onload="javascript:load(); afficherStatus();ChangeColor('#0000FF');" onkeydown="ChangePos();">
	<button id="myBtn">Click here</button>
	<div id="Crop-img" class="Crop-img-class">
		<div class="crop-content">
			<form name="CropForm" id="CropForm" method="POST" action="CropAction.asp">
				<span class="BTfermer">&times;</span>
				<table align="left">
					<tr style="height:30px;">
						<td><input type="hidden" id="crd_x" name="crd_x" readonly></td>
						<td><input type="hidden" id="crd_y" name="crd_y" readonly></td>
						<td><input type="hidden" id="img_x" name="img_x" readonly></td>
						<td><input type="hidden" id="img_y" name="img_y" readonly></td>
						<td><input type="hidden" id="pos_x" name="pos_x" readonly></td>
						<td><input type="hidden" id="pos_y" name="pos_y" readonly></td>
					</tr>
				</table>
				<div class="ratio-menu">
					<input type="text" id="ratio" name="ratio" value="1.0" readonly>
					<input type="button" name="BTDown" id="BTDown" value="-" onclick="javscript:ResizeDown();">
					<input type="button" name="BTUp" id="BTUp" value="+" onclick="javscript:ResizeUp();">
					<input type="button" name="BtCrop"" id=" BtCrop" value="Crop" onclick="javascript:Crop();">
				</div>

				<div class="img-content">
					<div id="img" class="dragDrop" style="border:1px dashed navy;top:120px; left:120px;"><img id="photo"
							src="img/upload/<%=Session("fname")%>"></div>
					<div id="crd" class="dragDrop"
						style="top:140px; left:140px; border:2px dashed navy; width:250px; height:300px;">
					</div>
				</div>
			</form>
		</div>
	</div>
	<script>
		var modal = document.getElementById("Crop-img");

		var btn = document.getElementById("myBtn");

		var span = document.getElementsByClassName("BTfermer")[0];

		btn.onclick = function () {
			modal.style.display = "block";
		}

		span.onclick = function () {
			modal.style.display = "none";
		}

		document.getElementById('photo').width *= 0.3;
		document.getElementById('ratio').value = 0.3;
	</script>
</body>

</html>