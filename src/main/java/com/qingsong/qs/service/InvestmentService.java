package com.qingsong.qs.service;

import java.util.List;

import com.qingsong.qs.dto.InvestmentVo;

public interface InvestmentService {

	public List<InvestmentVo> getInvestmentList();

	public int deleteInvestmentById(Integer id);
	
	public int saveInvestment(InvestmentVo investmentVo);

	public InvestmentVo getInvestmentById(Integer id);
}
