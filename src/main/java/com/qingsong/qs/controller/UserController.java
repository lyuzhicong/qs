package com.qingsong.qs.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.qingsong.qs.dto.UserVo;
import com.qingsong.qs.service.UserService;

@Controller
public class UserController {
	
	Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	public UserService userService;
	
	@RequestMapping("/")
	public ModelAndView getIndex(){
		ModelAndView mav = new ModelAndView("index");
		UserVo userVo  = userService.getUserVoList().get(0);
		mav.addObject("user", userVo);
		return mav;
	}

}
