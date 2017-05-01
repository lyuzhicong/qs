package com.qingsong.qs.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.qingsong.qs.dto.ArticleVo;
import com.qingsong.qs.service.ArticleService;

@Controller
@RequestMapping("/article")
public class ArticleController {
	Logger logger = LoggerFactory.getLogger(ArticleController.class);
	
	@Autowired
	ArticleService articleService;
	
	@RequestMapping("editArticle.do")
	public String editArticle(){
		return "/article/editArticle";
	}
	
	@RequestMapping(value = "saveArticle.do", method = RequestMethod.POST)
	public String saveArticle(ArticleVo articleVo){
		try{
			articleService.saveArticle(articleVo);
			return "/article/articleList";
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return "/article/editArticle";
	}
}
