package com.qingsong.qs.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qingsong.qs.dto.UserVo;
import com.qingsong.qs.service.UserService;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/user")
public class UserController {
	
	Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	public UserService userService;
	
	@RequestMapping("admin")
	public String login(){
		return "login";
	}
	
	@RequestMapping(value = "login.do", produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public JSONObject login(UserVo userVo){
		JSONObject jsonObj = new JSONObject();
		int count = userService.login(userVo);
		if(count == 1){
			jsonObj.put("Status", "OK");
		}else{
			jsonObj.put("Status", "ERROR");
		}
		return jsonObj;
	}
}
