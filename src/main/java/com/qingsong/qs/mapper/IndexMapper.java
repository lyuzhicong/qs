package com.qingsong.qs.mapper;

import java.util.List;

import com.qingsong.qs.dto.IndexVo;

public interface IndexMapper {
	public List<IndexVo> getIndexVoList();
	
	public int updateIndex(IndexVo indexVo);

	public IndexVo getIndexDataById(Integer id);
	
	
}
