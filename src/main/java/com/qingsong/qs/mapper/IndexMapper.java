package com.qingsong.qs.mapper;

import java.util.List;

import com.qingsong.qs.dto.CompanyVo;
import com.qingsong.qs.dto.IndexVo;

public interface IndexMapper {
	public List<IndexVo> getIndexVoList();
	
	public int updateIndex(IndexVo indexVo);

	public IndexVo getIndexDataById(Integer id);
	
	public int insertIndex(IndexVo indexVo);
	
	public int deleteIndexById(Integer id);
	
	
	//wap comany
	public List<CompanyVo> getCompanyList();
	
	public CompanyVo getCompanyById(Integer id);
	
	public int insertCompany(CompanyVo companyVo);
	
	public int updateCompany(CompanyVo companyVo);
	
	public int deleteCompanyById(Integer id);
	
}
