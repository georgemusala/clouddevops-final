<%@ page pageEncoding="UTF-8" %>
<html>
   	<head lang="ro-RO">
   		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta http-equiv="Content-Type" content="text/html" />
		<title>Secret Santa Page</title>
		<link rel="stylesheet" href="resources/css/styles.css">
		<style>
			

		</style>
	</head>
	<body>
		<div id="page">
		<!-- Banner Secret Santa-->
	    <img src="resources/images/SecretSantaBanner.png" alt="Secret Santa Banner">
	   	   		
		<h1>${currentUser.loginData.username}<span id="welcomeMessage">, bine ai revenit! Parola ta este: </span>${currentUser.loginData.password}</h1>
		<hr>
		
		<nav>
				<ul>
					<p><b id="menu">Meniu</b></p>
					<li>
					   <a class=navigItem href="home" id="home">Acasa</a>
					</li>
					<li>
					   <a class=navigItem href="wishlist" id="wishList">Lista dorinte</a>
					</li>
					<li>
					   <a class=navigItem href="spin" id="spin">Alege un nume</a>
					</li>
					<li>
					   <a class=navigItem href="participants" id="participants">Participanţi</a>
					</li>
					<li>
						<a class=navigItem href="about" id="about">Despre</a>
					</li>
				
					<p><b id="extLinks">Legaturi externe:</b></p>
					<li>
					   <a class="navigItem" href="https://www.dailymotion.com/video/x37qnbn_100-de-colinde-de-craciun-colaj-colinde-traditionale-romanesti_music" id="christSongs" >Colinde</a>
					</li>
					<li>
					   <a class="navigItem" href="https://ro.wikipedia.org/wiki/Mo%C8%99_Cr%C4%83ciun" id="aboutSanta">Despre Mos Craciun</a>
					</li>
					<li>
						<a class="navigItem" href="http://astrologie.acasa.ro/astrologie-zodii-105/cum-sa-alegi-cadoul-potrivit-de-craciun-pentru-fiecare-zodie-in-parte-211219.html" id="tips">Sfaturi</a>
					</li>
					<br>
					
					<li>
						<a href="logout" id="logout">Deconectare</a>
					</li>
				</ul> 

		</nav>

		<div class="text">
			<p id="info">Pe aceasta pagină veţi putea afla cui trebuie sa îi faceţi un cadou de Crăciun!</p>

			<p id="note"><i><u>Nota:</u><br>Vă aducem la cunostinţă faptul ca informaţiile privind destinatarii cadourilor sunt confidenţiale, fiind cunoscute doar de către persoana care va face cadoul respectiv.</i></p>
			
	  	</div>
	  </div>

	</body>


</html>