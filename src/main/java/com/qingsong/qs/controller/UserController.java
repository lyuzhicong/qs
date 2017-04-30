package com.qingsong.qs.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.qingsong.qs.dto.UserVo;
import com.qingsong.qs.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	
	Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	public UserService userService;
	
	@RequestMapping("/")
	public String getIndex(HttpServletRequest request){
		UserVo userVo  = userService.getUserVoList().get(0);
		request.setAttribute("user", userVo);
		return "index";
	}
	
	@RequestMapping("loginPage.do")
	public String login(){
		return "login";
	}
	
	@RequestMapping("login.do")
	public String login(UserVo userVo){
		int count = userService.login(userVo);
		if(count == 1){
			return "loginSuc";
		}
		else{
			return "loginFail";
		}
	}

}
