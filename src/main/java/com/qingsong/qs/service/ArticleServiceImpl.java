package com.qingsong.qs.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qingsong.qs.controller.ArticleController;
import com.qingsong.qs.dto.ArticleVo;
import com.qingsong.qs.mapper.ArticleMapper;
import com.qingsong.qs.util.Toolkit;

@Service
public class ArticleServiceImpl implements ArticleService {
	Logger logger = LoggerFactory.getLogger(ArticleController.class);

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

	@Override
	public ArticleVo getArticleById(Long id) {
		return articleMapper.getArticleById(id);
	}

	@Override
	public List<ArticleVo> getArticleList(ArticleVo articleVo) {
		int rownum = articleMapper.getArticleCount(articleVo);
		int pageCount = Toolkit.getPageCount(rownum, articleVo.getPageSize());
		articleVo.setPageCount(pageCount);
		List<ArticleVo> articleVoList = articleMapper.getArticleList(articleVo);
		return articleVoList;
	}

	@Override
	public int deleteArticleById(Long id) {
		return articleMapper.deleteArticleById(id);
	}
}
