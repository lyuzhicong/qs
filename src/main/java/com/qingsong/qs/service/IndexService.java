package com.qingsong.qs.service;

import java.util.List;

import com.qingsong.qs.dto.CompanyVo;
import com.qingsong.qs.dto.IndexVo;

public interface IndexService {
	public List<IndexVo> getIndexVoList();
	
	public int deleteIndexById(Integer id);

	public IndexVo getIndexDataById(Integer id);

	public void saveIndexData(IndexVo indexVo);
	
	//wap company
	
	public List<CompanyVo> getCompanyList();
	
	public CompanyVo getCompanyById(Integer id);
	
	public int saveCompany(CompanyVo companyVo);
	
	public int deleteCompanyById(Integer id);
	
	
}
