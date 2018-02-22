package com.qingsong.qs.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.qingsong.qs.dto.ArticleVo;
import com.qingsong.qs.service.ArticleService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/article")
public class ArticleController {
	Logger logger = LoggerFactory.getLogger(ArticleController.class);

	@Autowired
	ArticleService articleService;

	@RequestMapping("/edit/editArticle.do")
	public String editArticle(Long id, HttpServletRequest request) {
		if (id != null) {
			ArticleVo articleVo = articleService.getArticleById(id);
			JSONArray contentArray = JSONArray.fromObject(articleVo.getContent());
			JSONArray newContArray = new JSONArray();
			for (Object obj : contentArray) {
				JSONObject jsonObj = JSONObject.fromObject(obj);
				String content = jsonObj.getString("content");
				content = content.replace("\n", "\\n");
				content = content.replace("\r", "\\r");
				jsonObj.put("content", content);
				newContArray.add(jsonObj);
			}
			articleVo.setContent(newContArray.toString());
			request.setAttribute("articleVo", articleVo);
		}
		return "/article/editArticle";
	}

	@RequestMapping(value = "getArticleList.do", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public void getArticleList(ArticleVo articleVo, HttpServletResponse response) throws IOException {
		JSONObject jsonObj = new JSONObject();
		List<ArticleVo> articleVoList = articleService.getShowArticleList(articleVo);
		jsonObj.put("articleVoList", articleVoList);
		jsonObj.put("pageSize", articleVo.getPageSize());
		jsonObj.put("currentPage", articleVo.getCurrentPage());
		jsonObj.put("pageCount", articleVo.getPageCount());
		response.setContentType("application/json;charset=UTF-8");
		response.getWriter().print(jsonObj);
	}
	
	@RequestMapping(value = "getRelatedArticleList.do", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public void getRelatedArticleList(ArticleVo articleVo, HttpServletResponse response) throws IOException {
		JSONObject jsonObj = new JSONObject();
		List<ArticleVo> articleVoList = articleService.getRelatedArticleList(articleVo);
		jsonObj.put("articleVoList", articleVoList);
		jsonObj.put("pageSize", articleVo.getPageSize());
		jsonObj.put("currentPage", articleVo.getCurrentPage());
		jsonObj.put("pageCount", articleVo.getPageCount());
		response.setContentType("application/json;charset=UTF-8");
		response.getWriter().print(jsonObj);
	}

	@RequestMapping(value = "/edit/articleManager.do")
	public String articleManager(ArticleVo articleVo, HttpServletRequest request) {
		request.setAttribute("articleVoList", articleService.getArticleList(articleVo));
		return "/article/articleList";
	}

	@RequestMapping(value = "/articleDetail")
	@Deprecated
	public String articleDetail(Long id, HttpServletRequest request) {
		request.setAttribute("id", id);
		return "/article/articleDetail";
	}
	
	@RequestMapping(value = "/articleShareDetail")
	public String articleShareDetail(Long id, HttpServletRequest request) {
		request.setAttribute("id", id);
		return "/article/articleShareDetail";
	}

	
	@RequestMapping(value = "/getArticleDetailWap")
	public String getarticleDetailWap(Long id, HttpServletRequest request) {
		request.setAttribute("id", id);
		return "/article/articleDetailWap";
	}

	@RequestMapping(value = "/edit/saveArticle.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public JSONObject saveArticle(ArticleVo articleVo, HttpServletRequest request) {
		JSONObject jsonObj = new JSONObject();
		String[] littleTitleArray = request.getParameterValues("littleTitle");
		String[] contentArray = request.getParameterValues("content");
		JSONArray contentJsonArray = new JSONArray();
		if (contentArray != null) {
			for (int i = 0; i < contentArray.length; i++) {
				String content = contentArray[i];
				JSONObject contentJsonObj = new JSONObject();
				contentJsonObj.put("title", littleTitleArray[i]);
				contentJsonObj.put("content", content);
				contentJsonArray.add(contentJsonObj);
			}
			articleVo.setContent(contentJsonArray.toString());
		}
		try {
			articleService.saveArticle(articleVo);
			jsonObj.put("Status", "OK");
		} catch (Exception e) {
			jsonObj.put("Status", "ERROR");
		}
		return jsonObj;
	}

	@RequestMapping(value = "/edit/saveShareArticle.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public JSONObject saveShareArticle(ArticleVo articleVo, HttpServletRequest request) {
		JSONObject jsonObj = new JSONObject();
		try {
			articleService.saveArticle(articleVo);
			jsonObj.put("Status", "OK");
		} catch (Exception e) {
			jsonObj.put("Status", "ERROR");
		}
		return jsonObj;
	}

	@RequestMapping(value = "/getArticleById.do", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ArticleVo getArticleById(Long id) {
		ArticleVo articleVo = articleService.getArticleById(id);
		JSONArray contentArray = JSONArray.fromObject(articleVo.getContent());
		JSONArray newContArray = new JSONArray();
		for (Object obj : contentArray) {
			JSONObject jsonObj = JSONObject.fromObject(obj);
			String content = jsonObj.getString("content");
			content = "<p>" + content;
			content = content.replaceAll("(\r\n)|(\n)", "</p><p>") + "</p>";
			jsonObj.put("content", content);
			newContArray.add(jsonObj);
		}
		articleVo.setContent(newContArray.toString());
		return articleVo;
	}
	

	@RequestMapping(value = "/getArticleShareById.do", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ArticleVo getArticleShareById(Long id) {
		return articleService.getArticleById(id);
	}

	@RequestMapping(value = "/edit/deleteArticleById.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject deleteArticleById(Long id) {
		JSONObject jsonObj = new JSONObject();
		try {
			articleService.deleteArticleById(id);
			jsonObj.put("Status", "OK");
		} catch (Exception e) {
			jsonObj.put("Status", "ERROR");
			logger.error(e.getMessage(), e);
		}
		return jsonObj;
	}

	@RequestMapping(value = "uploadImages.do")
	public void uploadImages(HttpServletRequest request, HttpServletResponse response) throws IOException {
		JSONObject jsonObj = new JSONObject();
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> map = multipartHttpServletRequest.getFileMap();
		File dir = new File(request.getSession().getServletContext().getRealPath("resources/article"));
		if (!dir.exists()) {
			dir.mkdirs();
		}
		String path = null;
		try {
			for (Map.Entry<String, MultipartFile> entity : map.entrySet()) {
				MultipartFile multipartFile = entity.getValue();
				path = UUID.randomUUID() + multipartFile.getOriginalFilename();
				File ff = new File(dir, path);
				multipartFile.transferTo(ff);
			}
			jsonObj.put("Status", "OK");
			jsonObj.put("path", "article" + File.separator + path);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			jsonObj.put("Status", "ERROR");
		}
		response.setContentType("application/json;charset=UTF-8");
		response.getWriter().print(jsonObj.toString());
	}

	@RequestMapping("edit/articleShareEdit")
	public String testRichEditor(Long id, HttpServletRequest reuqest) {
		reuqest.setAttribute("article", articleService.getArticleById(id));
		return "article/editArticleWithRichText";
	}
}
