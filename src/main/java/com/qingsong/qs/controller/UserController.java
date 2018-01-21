package com.qingsong.qs.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qingsong.enums.contentTypeEnums;
import com.qingsong.qs.dto.UserVo;
import com.qingsong.qs.service.UserService;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/")
public class UserController {

	Logger logger = LoggerFactory.getLogger(UserController.class);

	@Autowired
	public UserService userService;

	@RequestMapping("admin")
	public String login() {
		return "login";
	}

	@RequestMapping(value = "login.do", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public void login(UserVo userVo, HttpServletRequest request, HttpServletResponse response) throws IOException {
		JSONObject jsonObj = new JSONObject();
		int count = userService.login(userVo);
		if (count == 1) {
			request.getSession().setAttribute("adminsession", "login");
			jsonObj.put("Status", "OK");
		} else {
			jsonObj.put("Status", "ERROR");
		}
		response.setContentType(contentTypeEnums.json.getContentType());
		response.getWriter().print(jsonObj.toString());
	}
}
