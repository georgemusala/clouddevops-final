package com.georgemusala;

import java.io.*;
import java.nio.file.*;
import java.util.Scanner;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@Scope("session")
public class LoginController {

	@Autowired
	private ServletContext context;

	//if request is root context then load start page or home page(if logged in)
	@RequestMapping(value="/", method=RequestMethod.GET)
	public ModelAndView loginPage()
	{
		ModelAndView model = new ModelAndView("start");

		return model;
	}

	//if request is home and method=POST (made from start.jsp) then do some validation
	@RequestMapping(value="/home", method=RequestMethod.POST)
	public ModelAndView goHome(@ModelAttribute("welcomeUser") User newUser, HttpSession session)
	{	//bind welcomeUser from start.jsp form with newUser
		//store "lang" parameter from start.jsp form to language

		ModelAndView model;

		//getting credentials send by newUser
		Credentials loginData = newUser.getLoginData();

		//if newUser exists and sent username and password are non-blank check credentials
		//else redirect to start
		if(newUser != null && loginData.getUsername() != null & loginData.getPassword() != null)
		{
			//check credentials
			if(valid(loginData))
				{
				model = new ModelAndView("home");

				//add currentUser to model (and also to HttpSession)
				model.addObject("currentUser",newUser);
				session.setAttribute("currentUser",newUser);
				}
			else
				model = new ModelAndView("start");
		}
		else
		{
			model = new ModelAndView("start");
		}

		return model;
	}

	//if request is home and method=GET (logged in) then do some checks
	@RequestMapping(value="/home", method=RequestMethod.GET)
	public ModelAndView goHome()
	{

		ModelAndView model = new ModelAndView("home");
		return model;
	}


	//logout user
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public ModelAndView logout(HttpSession session)
	{
		ModelAndView model;

		//set currentUser in session to null
		session.removeAttribute("currentUser");
		model = new ModelAndView("start");

		return model;
	}


	//validate credentials
	public boolean valid(Credentials loginData)
	{
		String appRoot = context.getRealPath("/WEB-INF/credentials.txt");
		Path filePath = Paths.get(appRoot);
		Scanner in = null;
		try{
				in = new Scanner(filePath);
				while(in.hasNext())
				{
					String user = in.next();
						if(user.equals(loginData.getUsername().toLowerCase()))
						{
							String pass = in.next();
								return pass.equals(loginData.getPassword().toLowerCase());
						}
					user = in.next();
				}
				in.close();
			}
		catch (FileNotFoundException e) {
					e.printStackTrace();
				}
		catch (IOException e) {
					e.printStackTrace();
			}
		return false;
	}
}
