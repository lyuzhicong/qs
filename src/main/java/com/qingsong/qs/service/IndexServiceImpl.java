package com.qingsong.qs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qingsong.qs.dto.CompanyVo;
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
	public int deleteIndexById(Integer id){
		return indexMapper.deleteIndexById(id);
	}

	@Override
	public IndexVo getIndexDataById(Integer id) {
		return indexMapper.getIndexDataById(id);
	}

	@Override
	public void saveIndexData(IndexVo indexVo) {
		if(indexVo.getId() != null) {
			indexMapper.updateIndex(indexVo);
		} else {
			indexMapper.insertIndex(indexVo);
		}
	}

	@Override
	public List<CompanyVo> getCompanyList() {
		return indexMapper.getCompanyList();
	}

	@Override
	public CompanyVo getCompanyById(Integer id) {
		return indexMapper.getCompanyById(id);
	}

	@Override
	public int saveCompany(CompanyVo companyVo) {
		if(companyVo.getId() != null) {
			indexMapper.updateCompany(companyVo);
		} else {
			indexMapper.insertCompany(companyVo);
		}
		return 0;
	}

	@Override
	public int deleteCompanyById(Integer id) {
		return indexMapper.deleteCompanyById(id);
	}
}
