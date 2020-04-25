package com.georgemusala;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@Scope("session")
public class WishlistController {

	@Autowired
	private ServletContext context;

	@RequestMapping(value="/wishlist", method=RequestMethod.GET)
	public ModelAndView showList(HttpSession session)
	{
		ModelAndView model = new ModelAndView("wishlist");
		Credentials loginData = ((User)session.getAttribute("currentUser")).getLoginData();
		List<String> list = getWishesList(loginData);
		List<Integer> wishNo = new ArrayList<>(list.size());

		for(int i=0;i<list.size();i++)
		{
			wishNo.add(i);
		}

		model.addObject("list",list);
		model.addObject("wishNo", wishNo);
		model.addObject("checkedWishes", new CheckedWishes());
		return model;
	}

	@RequestMapping(value="/deleteitems", method=RequestMethod.PUT)
	public ModelAndView deleteWish(@ModelAttribute("checkedList") CheckedWishes checkedWishes, HttpSession session)
	{
		ModelAndView model = new ModelAndView("wishlist");
		Credentials loginData = ((User)session.getAttribute("currentUser")).getLoginData();
		List<String> list = getWishesList(loginData);
		//setWishesList(loginData, checkedWishes.getList());
		model.addObject("list",Arrays.asList(list));
		return model;
	}


	public List<String> getWishesList(Credentials loginData)
	{

		String appRoot = context.getRealPath("/WEB-INF/users/"+loginData.getUsername()+"/wishlist.txt");
		Path filePath = Paths.get(appRoot);
		Scanner in = null;
		List<String> list = new ArrayList<>();
		try{
				in = new Scanner(filePath);
				while(in.hasNext())
				{
					String listItem = in.next();
					list.add(listItem);
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

	public void setWishesList(Credentials loginData, List<String> list)
	{

		String appRoot = context.getRealPath("/WEB-INF/users/"+loginData.getUsername()+"/wishlist.txt");
		Path filePath = Paths.get(appRoot);
		try{
			Files.write(filePath, list, Charset.forName("UTF-8"));
			}
		catch (FileNotFoundException e) {
					e.printStackTrace();
				}
		catch (IOException e) {
					e.printStackTrace();
			}

	}

}
