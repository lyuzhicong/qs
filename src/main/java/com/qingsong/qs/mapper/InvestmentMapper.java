package com.qingsong.qs.mapper;

import java.util.List;

import com.qingsong.qs.dto.InvestmentVo;

public interface InvestmentMapper {

	public List<InvestmentVo> getInvestmentList();
	
	public InvestmentVo getInvestmentById(Integer id);
	
	public int updateInvestment(InvestmentVo investmentVo);
	
	public int insertInvestment(InvestmentVo investmentVo);
	
	public int deleteInvestmentById(Integer id);
}
