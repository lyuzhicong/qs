package com.qingsong.qs.service;

import java.util.List;

import com.qingsong.qs.dto.ArticleVo;

public interface ArticleService {

	public void saveArticle(ArticleVo articleVo);

	public ArticleVo getArticleById(Long id);
	
	public List<ArticleVo> getArticleList(ArticleVo articleVo);
}
