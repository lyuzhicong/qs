package com.qingsong.qs.service;

import java.util.List;

import com.qingsong.qs.dto.ArticleVo;

public interface ArticleService {

	void saveArticle(ArticleVo articleVo);

	ArticleVo getArticleById(Long id);
	
	List<ArticleVo> getArticleList(ArticleVo articleVo);

	int deleteArticleById(Long id);
	
	List<ArticleVo> getShowArticleList(ArticleVo articleVo);

	List<ArticleVo> getRelatedArticleList(ArticleVo articleVo);
}
