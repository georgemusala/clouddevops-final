
var welcome;
var welcomeMessage;
var info;
var login;
var loginArea;
var user;
var pass;
var extLinks;
var christSongs;
var aboutSanta;
var tips;
var note;
var menu;
var home;
var participants;
var about;

var lang;
var logout;

var loginBtn;

var wishList;

function english()
{
	welcome = "Welcome to Secret Santa's Page!";
	info = "On this page you can find out to whom you will offer a Christmas gift.";
	login = "Please login below.";
	loginArea = "Login Area";
	user = "Username:";
	pass = "Password:";
	extLinks =  "External Links:";
	christSongs = "Christmas Songs";
	aboutSanta = "About Santa";
	tips = "Tips";
	welcomeMessage = ", welcome back! Your password is ";
	note = "<i><u>Notes:</u><br>Please note that the information regarding gift's recipient are confidential, being known only by the person that will offer the gift.</i>";
	menu = "Menu";
	home = "Home";
	participants = "Participants";
	about = "About";
	lang = "0";
	logout = "Logout";
	loginBtn = "Login";
	wishList = "Wish List";
}

function romanian()
{
	welcome = "Bine ați venit pe pagina Secret Santa!";
	info = "Pe aceasta pagină veți putea afla cui trebuie sa îi faceți un cadou de Moș Crăciun!";
	login = "Vă rugăm sa vă logați, mai jos.";
	loginArea = "Zona de autentificare";
	user = "Nume utilizator:";
	pass = "Parola:";
	extLinks =  "Legături externe:";
	christSongs = "Colinde";
	aboutSanta = "Despre Moș Crăciun";
	tips = "Sfaturi";
	welcomeMessage = ", bine ai revenit! Parola ta este ";
	note = "<i><u>Notă:</u><br>Vă aducem la cunoștință faptul că informațiile privind destinatarii cadourilor sunt confidențiale, fiind cunoscute doar de către persoana care va face cadoul respectiv.</i>";
	menu = "Meniu";
	home = "Acasa";
	participants = "Participanți";
	about = "Despre";
	lang = "1";
	logout = "Deconectare";
	loginBtn = "Autentificare";
	wishList = "Listă dorințe";

}

function languageIndex(input)
{
	if(input == 0)
	{
		english();

	}

	else
	{
		romanian();

	}

	document.getElementById("welcome").innerHTML = welcome;
	document.getElementById("info").innerHTML = info;
	document.getElementById("login").innerHTML = login;
	document.getElementById("loginArea").innerHTML = loginArea;
	document.getElementById("user").innerHTML = user;
	document.getElementById("pass").innerHTML = pass;
	document.getElementById("extLinks").innerHTML = extLinks;
	document.getElementById("christSongs").innerHTML = christSongs;
	document.getElementById("aboutSanta").innerHTML = aboutSanta;
	document.getElementById("tips").innerHTML = tips;
	
	document.getElementById("langChoice").value = lang;
	document.getElementById("loginBtn").value = loginBtn;

}

function languageHome(input)
{
	if(input == 0)
	{
		english();

	}

	else
	{
		romanian();

	}

	
	document.getElementById("welcomeMessage").innerHTML = welcomeMessage;
	document.getElementById("info").innerHTML = info;
	document.getElementById("extLinks").innerHTML = extLinks;
	document.getElementById("christSongs").innerHTML = christSongs;
	document.getElementById("aboutSanta").innerHTML = aboutSanta;
	document.getElementById("tips").innerHTML = tips;
	document.getElementById("note").innerHTML = note;
	document.getElementById("menu").innerHTML = menu;
	document.getElementById("home").innerHTML = home;
	
	var homeLink = document.getElementById("home").href;
	document.getElementById("home").href = homeLink.substring(0,homeLink.length-1) + lang;
	
	document.getElementById("wishList").innerHTML = wishList;
	
	var wishLink = document.getElementById("wishList").href;
	document.getElementById("wishList").href = wishLink.substring(0,wishLink.length-1) + lang;
	
	document.getElementById("participants").innerHTML = participants;
	document.getElementById("about").innerHTML = about;
	
	document.getElementById("logout").innerHTML = logout;
	
	document.getElementById("logout").href = "logout?lang=" + lang;
}

