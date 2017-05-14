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

	@RequestMapping("editArticle.do")
	public String editArticle() {
		return "/article/editArticle";
	}
	
	@RequestMapping(value = "getArticleList.do", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public void getArticleList(ArticleVo articleVo, HttpServletResponse response) throws IOException {
		JSONObject jsonObj = new JSONObject();
		List<ArticleVo> articleVoList = articleService.getArticleList(articleVo);
		jsonObj.put("articleVoList", articleVoList);
		jsonObj.put("pageSize", articleVo.getPageSize());
		jsonObj.put("currentPage", articleVo.getCurrentPage());
		jsonObj.put("pageCount", articleVo.getPageCount());
		response.setContentType("application/json;charset=UTF-8");
		response.getWriter().print(jsonObj);
	}

	@RequestMapping(value = "saveArticle.do", method = RequestMethod.POST)
	public String saveArticle(ArticleVo articleVo, HttpServletRequest request) {
		String[] imagesName = request.getParameterValues("image");
		JSONArray jsonArray = new JSONArray();
		String content = articleVo.getContent();
		if(content!=null){
			content = "<p>" + content;
			content = content.replaceAll("(\\r\\n)+", "</p><p>") + "</p>";
			articleVo.setContent(content);
		}
		if(imagesName != null && imagesName.length > 1){
			for (String imageName : imagesName) {
				JSONObject pathObj = new JSONObject();
				pathObj.put("path", imageName);
				jsonArray.add(pathObj);
			}
		}
		if(jsonArray != null && jsonArray.size() > 0){
			articleVo.setPath(jsonArray.toString());
		}
		try {
			articleService.saveArticle(articleVo);
			return "/article/articleList";
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return "/article/editArticle";
	}

	@RequestMapping(value = "getArticleById.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public String getArticleById(Long id, HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("articleVo", articleService.getArticleById(id));
		return "/article/article";
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
				File ff = new File(dir,path);
				multipartFile.transferTo(ff);
			}
			jsonObj.put("Status", "OK");
			jsonObj.put("path", "article" + File.separator + path);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			jsonObj.put("Status", "ERROR");
		}
		response.setContentType("application/json;charset=UTF-8");
		response.getWriter().print(jsonObj);
	}
}
