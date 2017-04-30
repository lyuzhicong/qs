package com.qingsong.qs.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

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
	
	@RequestMapping("saveArticle.do")
	public void saveArticle(ArticleVo articleVo){
		try{
			articleService.saveArticle(articleVo);
			System.out.println("保存成功!");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
	}
}
