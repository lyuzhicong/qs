package com.qingsong.qs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qingsong.qs.dto.MaterialVo;
import com.qingsong.qs.mapper.MaterialMapper;

@Service
public class MaterialServiceImpl implements MaterialService{
	
	@Autowired
	public MaterialMapper materialMapper;

	@Override
	public List<MaterialVo> getMaterialList() {
		return materialMapper.getMaterialList();
	}

	@Override
	public int deleteMaterialById(Integer id) {
		return materialMapper.deleteMaterialById(id);
	}

	@Override
	public int saveMaterial(MaterialVo materialVo) {
		if (materialVo.getId() != null) {
			return materialMapper.updateMaterial(materialVo);
		} else {
			return materialMapper.insertMaterial(materialVo);
		}
	}

	@Override
	public MaterialVo getMaterialById(Integer id) {
		return materialMapper.getMaterialById(id);
	}
}
