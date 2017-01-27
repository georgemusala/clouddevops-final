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
		<script src='resources/js/winwheel.js'></script>
		<script src='resources/js/TweenMax.js'></script>
		<style>
			

		</style>
	</head>
	<body>
		<div id="page">
		<!-- Banner Secret Santa-->
	    <img src="resources/images/SecretSantaBanner.png" alt="Secret Santa Banner">
	   
   		
		<h1>Alegeti persoana careia ii veti darui cadoul</h1>
		
		<hr>
		
		<nav>
				<ul>
					<p><b id="menu">Meniu</b></p>
					<li>
					   <a class=navigItem href="home" id="home">Acasa</a>
					</li>
					<li>
					   <a class=navigItem href="wishlist" id="wishList">Lista dorinte</a>
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
					   <a class="navigItem" href="https://ro.wikipedia.org/wiki/Mo%C8%99_Cr%C4%83ciun" id="aboutSanta">Despre Mos Craciun</a>
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
			<p id="info">Rotiti cercul pentru a afla cui trebuie sa ii faceti cadou.</p>
			<br><br>
			<div id="canvasContainer">
    			<canvas id="canvas" width="400" height="400">
        				Canvas not supported, please user another browser.
    			</canvas>
			</div>
			<script>
            	var theWheel = new Winwheel({
            		'outerRadius' : 146,    // Use these three properties to
    				'centerX'     : 200,    // correctly position the wheel
    				'centerY'     : 201,    // over the background.
    				'lineWidth'   : 2,
        			'numSegments' : ${participantsNo},
        			'segments'    :
        				[
        				<c:forEach items="${list}" var="item" varStatus="loop">
      						{'fillStyle' : '${colorsList[loop.index]}', 'textFontSize' : 15, 'text' : '${item}'},		
            			</c:forEach>
        				],
        			'animation' :                   // Note animation properties passed in constructor parameters.
    				{
        				'type'     : 'spinToStop',  // Type of animation.
        				'duration' : 5,             // How long the animation is to take in seconds.
        				'spins'    : 8              // The number of complete 360 degree rotations the wheel is to do.
    				}
    			});

    			var segmentNumber = ${segmentNumber};   // The segment number should be in response.
 
            	if (segmentNumber)
            	{
                	// Get random angle inside specified segment of the wheel.
                	var stopAt = theWheel.getRandomForSegment(segmentNumber);
 
                	// Important thing is to set the stopAngle of the animation before stating the spin.
                	theWheel.animation.stopAngle = stopAt;
            	}
            	
        	</script>
        	
			<button onClick="theWheel.startAnimation();" style="float:right">Rotiti</button>	
			
		</div>
	  </div>
  
	</body>


</html>