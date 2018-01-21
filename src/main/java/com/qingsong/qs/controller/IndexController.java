package com.qingsong.qs.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qingsong.enums.contentTypeEnums;
import com.qingsong.qs.dto.IndexVo;
import com.qingsong.qs.service.IndexService;
import com.qingsong.qs.service.TheyTalkService;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/")
public class IndexController {
	Logger logger = LoggerFactory.getLogger(IndexController.class);

	@Autowired
	private IndexService indexService;
	
	@Autowired
	private TheyTalkService theyTalkService;

	@RequestMapping("")
	public String getIndex(HttpServletRequest request) {
		List<IndexVo> indexVoList = indexService.getIndexVoList();
		if(indexVoList == null || indexVoList.size() < 3) {
			indexVoList.clear();
			IndexVo indexVo = new IndexVo();
			indexVo.setNumber("13亿");
			indexVo.setContent("资产管理规模");
			IndexVo indexVo1 = new IndexVo();
			indexVo1.setNumber("100");
			indexVo1.setContent("被投企业");
			IndexVo indexVo2 = new IndexVo();
			indexVo2.setNumber("60倍");
			indexVo2.setContent("50%项目退出回报率");
			indexVoList.add(indexVo);
			indexVoList.add(indexVo1);
			indexVoList.add(indexVo2);
		}
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
	
	@RequestMapping("edit/updateIndexData")
	public void updateIndexData(IndexVo indexVo, HttpServletResponse response) throws IOException {
		JSONObject jsonObj = new JSONObject();
		try {
			indexService.updateIndexData(indexVo);
			jsonObj.put("Status", "OK");
		} catch(Exception e) {
			logger.error(e.getMessage(), e);
			jsonObj.put("Status", "ERROR");
		}
		response.setContentType(contentTypeEnums.json.getContentType());
		response.getWriter().print(jsonObj.toString());
	}
	
	@RequestMapping("getIndexWap")
	public String getIndexWap(HttpServletRequest request) {
		List<IndexVo> indexVoList = indexService.getIndexVoList();
		if(indexVoList == null || indexVoList.size() < 3) {
			indexVoList.clear();
			IndexVo indexVo = new IndexVo();
			indexVo.setNumber("13亿");
			indexVo.setContent("资产管理规模");
			IndexVo indexVo1 = new IndexVo();
			indexVo1.setNumber("100");
			indexVo1.setContent("被投企业");
			IndexVo indexVo2 = new IndexVo();
			indexVo2.setNumber("60倍");
			indexVo2.setContent("50%项目退出回报率");
			indexVoList.add(indexVo);
			indexVoList.add(indexVo1);
			indexVoList.add(indexVo2);
		}
		request.setAttribute("theyTalkList", theyTalkService.getTheyTalkVoList());
		request.setAttribute("indexVoList", indexVoList);
		return "index/indexWap";
	}
	
}
