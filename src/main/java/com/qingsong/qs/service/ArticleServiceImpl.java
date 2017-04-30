package com.qingsong.qs.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qingsong.qs.dto.ArticleVo;
import com.qingsong.qs.mapper.ArticleMapper;

@Service
public class ArticleServiceImpl implements ArticleService {

	@Autowired
	public ArticleMapper articleMapper;

	@Override
	public void saveArticle(ArticleVo articleVo) {
		if (articleVo.getId() != null) {
			articleMapper.updateArticle(articleVo);
		} else {
			articleMapper.insertArticle(articleVo);
		}

	}

}
