package com.qingsong.qs.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.qingsong.qs.dto.AboutQsVo;
import com.qingsong.qs.service.AboutQsService;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/about")
public class AboutQsController {
	Logger logger = LoggerFactory.getLogger(AboutQsController.class);

	@Autowired
	private AboutQsService aboutQsService;

	@RequestMapping("")
	public String getAboutQs(HttpServletRequest request) {
		AboutQsVo aboutQsVo = aboutQsService.getAboutQsVo();
		request.setAttribute("aboutQsVo", aboutQsVo);
		return "aboutQs/about";
	}

	@RequestMapping("/edit/updateAboutQs")
	public void updateAboutQs(AboutQsVo aboutQsVo, HttpServletResponse response) throws IOException {
		JSONObject jsonObj = new JSONObject();
		try {
			aboutQsService.updateAboutQsVo(aboutQsVo);
			jsonObj.put("Status", "OK");
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			jsonObj.put("Status", "ERROR");
		}
		response.setContentType("application/json;charset=UTF-8");
		response.getWriter().print(jsonObj.toString());
	}

	@RequestMapping("/edit/editAboutQs")
	public String aboutQsManager(HttpServletRequest request) {
		AboutQsVo aboutQsVo = aboutQsService.getAboutQsVo();
		request.setAttribute("aboutQsVo", aboutQsVo);
		return "/aboutQs/editAboutQs";
	}
	
	@RequestMapping("/getAboutWap")
	public String getAboutQsWap(HttpServletRequest request) {
		AboutQsVo aboutQsVo = aboutQsService.getAboutQsVo();
		request.setAttribute("aboutQsVo", aboutQsVo);
		return "aboutQs/aboutWap";
	}
	
	@RequestMapping("/getContactWap")
	public String getAboutQsWap() {
		return "aboutQs/contactWap";
	}


}
