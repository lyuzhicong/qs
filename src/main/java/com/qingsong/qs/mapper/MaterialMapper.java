package com.qingsong.qs.mapper;

import java.util.List;

import com.qingsong.qs.dto.MaterialVo;

public interface MaterialMapper {

	public List<MaterialVo> getMaterialList();
	
	public MaterialVo getMaterialById(Integer id);
	
	public int updateMaterial(MaterialVo materialVo);
	
	public int insertMaterial(MaterialVo materialVo);
	
	public int deleteMaterialById(Integer id);
}
