package com.qingsong.qs.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qingsong.enums.contentTypeEnums;
import com.qingsong.qs.dto.ArticleVo;
import com.qingsong.qs.dto.TheyTalkVo;
import com.qingsong.qs.service.ArticleService;
import com.qingsong.qs.service.TheyTalkService;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/share")
public class ShareController {
	Logger logger = LoggerFactory.getLogger(ShareController.class);

	@Autowired
	private TheyTalkService theyTalkService;
	
	@Autowired
	private ArticleService articleService;

	@RequestMapping("")
	public String getTheyTalk(HttpServletRequest request) {
		List<TheyTalkVo> theyTalkVoList = theyTalkService.getTheyTalkVoList();
		request.setAttribute("theyTalkVoList", theyTalkVoList);
		request.setAttribute("isShow", theyTalkService.getIsShow());
		return "share/share";
	}
	
	@RequestMapping("getShareWap")
	public String getShareWap(HttpServletRequest request) {
		ArticleVo articleVo = new ArticleVo();
		request.setAttribute("articleVoList", articleService.getArticleList(articleVo));
		return "share/shareWap";
	}
	
	@RequestMapping("/edit/theyTalkManager")
	public String editTheyTalk(HttpServletRequest request) {
		List<TheyTalkVo> theyTalkVoList = theyTalkService.getTheyTalkVoList();
		request.setAttribute("theyTalkVoList", theyTalkVoList);
		Integer isShow = theyTalkService.getIsShow();
		request.setAttribute("isShow", isShow);
		return "share/theyTalkManager";
	}
	
	@RequestMapping("/getTheyTalkById")
	@ResponseBody
	public TheyTalkVo getTheyTalkById(HttpServletRequest request, Integer id) {
		return theyTalkService.getTheyTalkById(id);
	}

	@RequestMapping("/edit/deleteTheyTalkById")
	public void deleteTheyTalkById(Integer id, HttpServletResponse response) throws IOException {
		JSONObject jsonObj = new JSONObject();
		try {
			theyTalkService.deleteTheyTalkById(id);
			jsonObj.put("Status", "OK");
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			jsonObj.put("Status", "ERROR");
		}
		response.setContentType("application/json;charset=UTF-8");
		response.getWriter().print(jsonObj.toString());
	}

	@RequestMapping("/edit/saveTheyTalk")
	public void saveTheyTalk(TheyTalkVo theyTalkVo, HttpServletResponse response) throws IOException {
		JSONObject jsonObj = new JSONObject();
		try {
			theyTalkService.saveTheyTalk(theyTalkVo);
			jsonObj.put("Status", "OK");
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			jsonObj.put("Status", "ERROR");
		}
		response.setContentType("application/json;charset=UTF-8");
		response.getWriter().print(jsonObj.toString());
	}
	
	@RequestMapping("edit/updateIsShow")
	public void updateIsShow(String configVal, HttpServletResponse response) throws IOException {
		JSONObject obj = new JSONObject();
		try {
			theyTalkService.updateIsShow(configVal);
			obj.put("Status", "OK");
		} catch(Exception e) {
			logger.error(e.getMessage(), e);
			obj.put("Status", "ERROR");
		}
		response.setContentType(contentTypeEnums.json.getContentType());
		response.getWriter().print(obj);
	}
	
}
