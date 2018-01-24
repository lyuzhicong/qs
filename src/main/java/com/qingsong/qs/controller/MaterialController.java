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

import com.qingsong.qs.dto.MaterialVo;
import com.qingsong.qs.service.MaterialService;
import com.qingsong.qs.util.QingsongConfig;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/material")
public class MaterialController {
	Logger logger = LoggerFactory.getLogger(MaterialController.class);

	@Autowired
	private MaterialService materialService;

	@RequestMapping("")
	public String getIMaterial(HttpServletRequest request) {
		List<MaterialVo> materialVoList = materialService.getMaterialList();
		request.setAttribute("materialVoList", materialVoList);
		return "material/material";
	}
	
	@RequestMapping("getMaterialWap")
	public String getMaterialWap(HttpServletRequest request) {
		List<MaterialVo> materialVoList = materialService.getMaterialList();
		request.setAttribute("materialVoList", materialVoList);
		return "material/materialWap";
	}

	@RequestMapping("/edit/materialManager")
	public String getMaterialManager(HttpServletRequest request) {
		List<MaterialVo> materialList = materialService.getMaterialList();
		request.setAttribute("materialList", materialList);
		return "material/materialManager";

	}

	@RequestMapping("/materialDetailWap")
	public String materialDetailWap(HttpServletRequest request, Integer id) {
		MaterialVo material = materialService.getMaterialById(id);
		request.setAttribute("material", material);
		return "material/materialDetailWap";
	}
	
	@RequestMapping("/materialDetail")
	public String materialDetail(HttpServletRequest request, Integer id) {
		MaterialVo material = materialService.getMaterialById(id);
		request.setAttribute("material", material);
		return "material/materialDetail";
	}
	
	@RequestMapping("/getMaterialById")
	@ResponseBody
	public MaterialVo getMaterialById(HttpServletRequest request, Integer id) {
		return materialService.getMaterialById(id);
	}

	@RequestMapping("/edit/deleteMaterialById")
	public void deleteMaterialById(Integer id, HttpServletResponse response) throws IOException {
		JSONObject jsonObj = new JSONObject();
		try {
			materialService.deleteMaterialById(id);
			jsonObj.put("Status", "OK");
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			jsonObj.put("Status", "ERROR");
		}
		response.setContentType("application/json;charset=UTF-8");
		response.getWriter().print(jsonObj.toString());
	}

	@RequestMapping("/edit/saveMaterial")
	public void saveMaterial(MaterialVo materialVo, HttpServletResponse response) throws IOException {
		JSONObject jsonObj = new JSONObject();
		try {
			materialService.saveMaterial(materialVo);
			jsonObj.put("Status", "OK");
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			jsonObj.put("Status", "ERROR");
		}
		response.setContentType("application/json;charset=UTF-8");
		response.getWriter().print(jsonObj.toString());
	}

	@RequestMapping("/uploadImage")
	public void fileUpload(@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request, HttpServletResponse response) {
		JSONObject json = new JSONObject();
		response.setCharacterEncoding("utf-8");
//		String path = "E:" + File.separator + "temp";
		String imagePath = QingsongConfig.IMAGE_PATH;
		System.out.println(imagePath);
		String fileName = file.getOriginalFilename(); // prefix suffix
		String suffix = fileName.substring(fileName.lastIndexOf("."));
		String newFileName = UUID.randomUUID().toString() + suffix;
		File targetFile = new File(imagePath, newFileName);
		if (!targetFile.exists()) {
			targetFile.mkdirs();
		}
		try {
			file.transferTo(targetFile);
			json.put("Status", "OK");
			json.put("fileId","/image/" + newFileName);
			response.getWriter().print(json);
		} catch (Exception e) {
			json.put("Status", "ERROR");
			json.put("errorMsg", "上传失败：" + e.getMessage());
			logger.error(e.getMessage(), e);
		}
	}
}

