package com.qingsong.qs.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.qingsong.qs.dto.InvestmentVo;
import com.qingsong.qs.service.InvestmentService;
import com.qingsong.qs.util.QingsongConfig;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/investment")
public class InvestmentController {
	Logger logger = LoggerFactory.getLogger(InvestmentController.class);

	@Autowired
	private InvestmentService investmentService;

	@RequestMapping("")
	public String getIInvestment(HttpServletRequest request) {
		List<InvestmentVo> investmentVoList = investmentService.getInvestmentList();
		request.setAttribute("investmentVoList", investmentVoList);
		return "investment/investment";
	}
	
	@RequestMapping("getInvestmentWap")
	public String getInvestmentWap(HttpServletRequest request) {
		List<InvestmentVo> investmentVoList = investmentService.getInvestmentList();
		request.setAttribute("investmentVoList", investmentVoList);
		return "investment/investmentWap";
	}

	@RequestMapping("/edit/investmentManager")
	public String getInvestmentManager(HttpServletRequest request) {
		List<InvestmentVo> investmentList = investmentService.getInvestmentList();
		request.setAttribute("investmentList", investmentList);
		return "investment/investmentManager";

	}

	@RequestMapping("/investmentDetailWap")
	public String investmentDetailWap(HttpServletRequest request, Integer id) {
		InvestmentVo investment = investmentService.getInvestmentById(id);
		request.setAttribute("investment", investment);
		return "investment/investmentDetailWap";
	}
	
	@RequestMapping("/investmentDetail")
	public String investmentDetail(HttpServletRequest request, Integer id) {
		InvestmentVo investment = investmentService.getInvestmentById(id);
		request.setAttribute("investment", investment);
		return "investment/investmentDetail";
	}
	
	@RequestMapping("/getInvestmentById")
	@ResponseBody
	public InvestmentVo getInvestmentById(HttpServletRequest request, Integer id) {
		return investmentService.getInvestmentById(id);
	}

	@RequestMapping("/edit/deleteInvestmentById")
	public void deleteInvestmentById(Integer id, HttpServletResponse response) throws IOException {
		JSONObject jsonObj = new JSONObject();
		try {
			investmentService.deleteInvestmentById(id);
			jsonObj.put("Status", "OK");
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			jsonObj.put("Status", "ERROR");
		}
		response.setContentType("application/json;charset=UTF-8");
		response.getWriter().print(jsonObj.toString());
	}

	@RequestMapping("/edit/saveInvestment")
	public void saveInvestment(InvestmentVo investmentVo, HttpServletResponse response) throws IOException {
		JSONObject jsonObj = new JSONObject();
		try {
			investmentService.saveInvestment(investmentVo);
			jsonObj.put("Status", "OK");
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			jsonObj.put("Status", "ERROR");
		}
		response.setContentType("application/json;charset=UTF-8");
		response.getWriter().print(jsonObj.toString());
	}

	@RequestMapping("/uploadImage")
	public void fileUpload(@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws IOException {
		JSONObject json = new JSONObject();
		response.setCharacterEncoding("utf-8");
		String imagePath = QingsongConfig.IMAGE_PATH;
		String fileName = file.getOriginalFilename(); // prefix suffix
		String suffix = fileName.substring(fileName.lastIndexOf('.'));
		String newFileName = UUID.randomUUID().toString() + suffix;
		File targetFile = new File(imagePath, newFileName);
		logger.info("File path:" + targetFile.getAbsolutePath());
		logger.info("File path:" + targetFile.getAbsolutePath());
		if (!targetFile.exists()) {
			targetFile.mkdirs();
		}
		try {
			file.transferTo(targetFile);
			json.put("Status", "OK");
			json.put("fileId","/image/" + newFileName);
		} catch (Exception e) {
			json.put("Status", "ERROR");
			json.put("errorMsg", "上传失败：" + e.getMessage());
			logger.error(e.getMessage(), e);
		}
		response.getWriter().print(json);
	}
}
