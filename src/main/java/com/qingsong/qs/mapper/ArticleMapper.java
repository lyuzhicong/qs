package com.qingsong.qs.mapper;

import com.qingsong.qs.dto.ArticleVo;

public interface ArticleMapper {
	public int updateArticle(ArticleVo articleVo);
	
	public int insertArticle(ArticleVo articleVo);
	
}
