package com.georgemusala;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.Scanner;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@Scope("session")
public class Spin {

	@Autowired
	private ServletContext context;

	@RequestMapping(value="/spin", method=RequestMethod.GET)
	public ModelAndView showList(HttpSession session)
	{
		ModelAndView model = new ModelAndView("spin");
		Credentials loginData = ((User)session.getAttribute("currentUser")).getLoginData();
		List<String> list = getUsersList(loginData.getUsername());
		List<String> colorsList = getColorsList();
		int segmentNumber = getRandomSegment(list.size());
		setPickedUser(loginData, list.get(segmentNumber));

		model.addObject("segmentNumber",segmentNumber+1);
		model.addObject("participantsNo",list.size());
		model.addObject("list",list);
		model.addObject("colorsList", colorsList);

		return model;
	}

	public List<String> getUsersList(String currentUser)
	{
		String appRoot = context.getRealPath("/WEB-INF/credentials.txt");
		Path filePath = Paths.get(appRoot);
		Scanner in = null;
		List<String> list = new ArrayList<>();
		try{
				in = new Scanner(filePath);
				while(in.hasNext())
				{
					String user = in.next();
					if(!currentUser.equals(user))
						list.add(user);
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
		return list;
	}

	public List<String> getColorsList()
	{
		String appRoot = context.getRealPath("/WEB-INF/colors.txt");
		Path filePath = Paths.get(appRoot);
		Scanner in = null;
		List<String> list = new ArrayList<>();
		try{
				in = new Scanner(filePath);
				while(in.hasNext())
				{
					String color = in.next();
					list.add(color);
				}
				in.close();
			}
		catch (FileNotFoundException e) {
					e.printStackTrace();
				}
		catch (IOException e) {
					e.printStackTrace();
			}
		return list;
	}

	public void setPickedUser(Credentials loginData, String pickedUser)
	{
		String appRoot = context.getRealPath("/WEB-INF/users/"+loginData.getUsername()+"/picked-user.txt");
		File file = new File(appRoot);

		try{
			PrintWriter writer = new PrintWriter(file);
			System.out.println(pickedUser);
			writer.println(pickedUser);
			writer.close();
			}
		catch (FileNotFoundException e) {
					e.printStackTrace();
				}
		catch (IOException e) {
					e.printStackTrace();
			}
	}
	public int getRandomSegment(int max)
	{
		Random gen = new Random(System.currentTimeMillis());
		return gen.nextInt(max);
	}
}
