package com.qingsong.qs.service;

import java.util.List;

import com.qingsong.qs.dto.MaterialVo;

public interface MaterialService {

	public List<MaterialVo> getMaterialList();

	public int deleteMaterialById(Integer id);
	
	public int saveMaterial(MaterialVo materialVo);

	public MaterialVo getMaterialById(Integer id);
}
