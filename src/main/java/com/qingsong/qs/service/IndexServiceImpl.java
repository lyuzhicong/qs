package com.qingsong.qs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qingsong.qs.dto.IndexVo;
import com.qingsong.qs.mapper.IndexMapper;

@Service
public class IndexServiceImpl implements IndexService{
	
	@Autowired
	public IndexMapper indexMapper;

	@Override
	public List<IndexVo> getIndexVoList() {
		return indexMapper.getIndexVoList();
	}
	
	@Override
	public int updateIndex(IndexVo indexVo){
		return indexMapper.updateIndex(indexVo);
	}

	@Override
	public IndexVo getIndexDataById(Integer id) {
		return indexMapper.getIndexDataById(id);
	}

	@Override
	public void updateIndexData(IndexVo indexVo) {
		indexMapper.updateIndex(indexVo);
	}
}
