package com.qingsong.qs.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qingsong.enums.contentTypeEnums;
import com.qingsong.qs.dto.CompanyVo;
import com.qingsong.qs.dto.IndexVo;
import com.qingsong.qs.service.IndexService;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/")
public class IndexController {
	Logger logger = LoggerFactory.getLogger(IndexController.class);

	@Autowired
	private IndexService indexService;

	@RequestMapping("")
	public String getIndex(HttpServletRequest request) {
		List<IndexVo> indexVoList = indexService.getIndexVoList();
		request.setAttribute("indexVoList", indexVoList);
		return "index/index";
	}

	@RequestMapping("edit/indexManager")
	public String indexManager(HttpServletRequest request) {
		request.setAttribute("indexVoList", indexService.getIndexVoList());
		return "index/indexManager";

	}

	@RequestMapping(value = "getIndexDataById")
	@ResponseBody
	public IndexVo getIndexDataById(Integer id) {
		return indexService.getIndexDataById(id);
	}

	@RequestMapping("edit/saveIndexData")
	public void updateIndexData(IndexVo indexVo, HttpServletResponse response) throws IOException {
		JSONObject jsonObj = new JSONObject();
		try {
			indexService.saveIndexData(indexVo);
			jsonObj.put("Status", "OK");
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			jsonObj.put("Status", "ERROR");
		}
		response.setContentType(contentTypeEnums.json.getContentType());
		response.getWriter().print(jsonObj.toString());
	}

	@RequestMapping("getIndexWap")
	public String getIndexWap(HttpServletRequest request) {
		List<IndexVo> indexVoList = indexService.getIndexVoList();
		request.setAttribute("companyList", indexService.getCompanyList());
		request.setAttribute("indexVoList", indexVoList);
		return "index/indexWap";
	}
	
	@RequestMapping(value = "edit/index/{id}", method = RequestMethod.DELETE)
	public void deleteIndexById(@PathVariable("id") Integer id, HttpServletResponse response) throws IOException{
		JSONObject jsonObj = new JSONObject();
		try {
			indexService.deleteIndexById(id);
			jsonObj.put("Status", "OK");
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			jsonObj.put("Status", "ERROR");
		}
		response.setContentType(contentTypeEnums.json.getContentType());
		response.getWriter().print(jsonObj.toString());
	}
	

	@RequestMapping("edit/indexWapManager")
	public String getIndexWapManager(HttpServletRequest request) {
		request.setAttribute("companyList", indexService.getCompanyList());
		return "index/indexWapManager";
	}
	
	@RequestMapping("/companyDetailWap")
	public String getIndexWapManager(Integer id, HttpServletRequest request) {
		request.setAttribute("company", indexService.getCompanyById(id));
		return "index/companyDetailWap";
	}

	@RequestMapping(value = "edit/company/{id}", method = RequestMethod.DELETE)
	public void deleteCompanyById(@PathVariable("id") Integer id, HttpServletResponse response) throws IOException{
		JSONObject jsonObj = new JSONObject();
		try {
			indexService.deleteCompanyById(id);
			jsonObj.put("Status", "OK");
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			jsonObj.put("Status", "ERROR");
		}
		response.setContentType(contentTypeEnums.json.getContentType());
		response.getWriter().print(jsonObj.toString());
	}
	
	@RequestMapping("edit/saveCompany")
	public void saveCompany(CompanyVo companyVo, HttpServletResponse response) throws IOException {
		JSONObject jsonObj = new JSONObject();
		try {
			indexService.saveCompany(companyVo);
			jsonObj.put("Status", "OK");
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			jsonObj.put("Status", "ERROR");
		}
		response.setContentType(contentTypeEnums.json.getContentType());
		response.getWriter().print(jsonObj.toString());
	}
	
	@RequestMapping(value = "company/{id}", method = RequestMethod.GET)
	@ResponseBody
	public CompanyVo getCompanyById(@PathVariable("id") Integer id) {
		return indexService.getCompanyById(id);
	}

}
