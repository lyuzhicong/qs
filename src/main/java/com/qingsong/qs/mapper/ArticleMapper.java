package com.qingsong.qs.mapper;

import java.util.List;

import com.qingsong.qs.dto.ArticleVo;

public interface ArticleMapper {
	public int updateArticle(ArticleVo articleVo);
	
	public int insertArticle(ArticleVo articleVo);
	
	public ArticleVo getArticleById(Long id);

	public int getArticleCount(ArticleVo articleVo);
	
	public List<ArticleVo> getArticleList(ArticleVo articleVo);

	public int deleteArticleById(Long id);
	
}
