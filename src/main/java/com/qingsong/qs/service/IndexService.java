package com.qingsong.qs.service;

import java.util.List;

import com.qingsong.qs.dto.IndexVo;

public interface IndexService {
	public List<IndexVo> getIndexVoList();
	
	public int updateIndex(IndexVo indexVo);

	public IndexVo getIndexDataById(Integer id);

	public void updateIndexData(IndexVo indexVo);
}
