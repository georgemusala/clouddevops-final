<%@ page pageEncoding="UTF-8" %>
<html>
   	<head lang="ro-RO">
   		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<meta http-equiv="Content-Type" content="text/html; UTF-8" />
		<title>Secret Santa Page</title>
		<link rel="stylesheet" href="resources/css/styles.css" type="text/css">
		<style>
			

		</style>
	</head>
	<body>
	   <div id="page">
		<!-- Banner Secret Santa-->
	    <img src="resources/images/SecretSantaBanner.png" alt="Secret Santa Banner" id="banner"/>
	   			
		<h1 id="welcome">Bine ati venit pe pagina Secret Santa!</h1>
		<hr>
		
		<nav>
			
			<ul>
					<p><b id="extLinks">Legaturi externe:</b></p>
					<li>
					   <a class="navigItem" href="https://www.dailymotion.com/video/x37qnbn_100-de-colinde-de-craciun-colaj-colinde-traditionale-romanesti_music" target="_blank" id="christSongs" >Colinde</a>
					</li>
					<li>
					   <a class="navigItem" href="https://ro.wikipedia.org/wiki/Mo%C8%99_Cr%C4%83ciun" target="_blank" id="aboutSanta">Despre Mos Craciun</a>
					</li>
					<li>
						<a class="navigItem" href="http://astrologie.acasa.ro/astrologie-zodii-105/cum-sa-alegi-cadoul-potrivit-de-craciun-pentru-fiecare-zodie-in-parte-211219.html" target="_blank" id="tips">Sfaturi</a>
					</li>
				</ul> 

		</nav>

		<div class="text">
			<p id="info">
				Pe aceasta pagina veti putea afla cui trebuie sa ii faceti un cadou de Craciun!
			</p>

			<p id="login">Va rugam sa va logati, mai jos.</p><br>

			<form action="/SecretSanta/home" method="post">
				<fieldset>
					<legend id="inputArea">Zona de autentificare</legend>
					<p id="inputText">Nume utilizator:</p>
					<input type="text" name="loginData.username" value="Username" required=true>
					<br>
					<p id="pass">Parola:</p>
					<input type="password" name="loginData.password" required=true><br><br>
					<input type="submit" value="Autentificare" id="loginBtn">
					<input type="reset" value="Reset">
				</fieldset> 
			</form>
		 </div>
	 </div>
    
	</body>
</html>