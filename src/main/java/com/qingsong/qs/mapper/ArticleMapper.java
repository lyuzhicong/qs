package com.qingsong.qs.mapper;

import java.util.List;

import com.qingsong.qs.dto.ArticleVo;

public interface ArticleMapper {
	int updateArticle(ArticleVo articleVo);
	
	int insertArticle(ArticleVo articleVo);
	
	ArticleVo getArticleById(Long id);

	int getArticleCount(ArticleVo articleVo);
	
	List<ArticleVo> getArticleList(ArticleVo articleVo);

	int deleteArticleById(Long id);
	
	List<ArticleVo> getShowArticleList(ArticleVo articleVo);
	
	int getShowArticleCount(ArticleVo articleVo);

	List<ArticleVo> getRelatedArticleList(ArticleVo articleVo);
	
}
