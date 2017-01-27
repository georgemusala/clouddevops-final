<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
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
	   
   		
		<h1>Lista ta de dorinte</h1>
		
		<hr>
		
		<nav>
				<ul>
					<p><b id="menu">Meniu</b></p>
					<li>
					   <a class=navigItem href="home" id="home">Acasa</a>
					</li>
					<li>
					   <a class=navigItem href="wishlist" id="wishList">Lista dorinte</a>
					</li>
					<li>
					   <a class=navigItem href="spin" id="spin">Alege un nume</a>
					</li>
					<li>
					   <a class=navigItem href="participants" id="participants">Participanti</a>
					</li>
					<li>
						<a class=navigItem href="about" id="about">Despre</a>
					</li>
				
					<p><b id="extLinks">Legaturi externe:</b></p>
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
			<p id="info">Puteti adauga sau edita, mai jos, dorintele de Craciun.</p>

			
				<fieldset>
					<legend>Dorinte de Craciun:</legend>
					
					<form:form modelAttribute="checkedWishes" method="post" action="/SecretSanta/deleteitems">
						<ol>
							
  							<c:forEach items="${list}" var="item" varStatus="loop">
    						<form:checkboxes path="wishNo" items="${wishNo}" />
    						<li>
      							<c:out value="${item}" />
    						</li>
  							</c:forEach>
  						</ol>
  						<input type="submit" name="updatewishes" value="Delete selected">

  					</form:form>
  					<br>

  					<form action="/SecretSanta/wishlist" method="post">
						New wish:
						<input type="text" name="wish" required=true>
						<input type="submit" name="addwish" value="Add" id="loginBtn">
					</form>
		
				</fieldset> 
			
		
	  </div>
	</body>
</html>