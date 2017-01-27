package com.georgemusala;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthenticationInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception
	{
		HttpSession session = request.getSession();
		boolean isLoggedIn = session.getAttribute("currentUser") != null ? true:false;
		String currentRequest = request.getServletPath();
		if(isLoggedIn)
		{
			if(currentRequest.equals("/"))
			{
			   request.getRequestDispatcher("/home").forward(request, response);
			   return false;
			}
			
			else
				return true;
		}
		
		else
		{
			if(currentRequest.equals("/")||(currentRequest.equals("/home")&&request.getMethod().equals("POST")))
				return true;
			else
			   {
				   request.getRequestDispatcher("/").forward(request, response);
				   return false;
				}
		}
	
	}
	

}
