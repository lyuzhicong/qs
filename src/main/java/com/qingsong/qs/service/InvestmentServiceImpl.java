package com.qingsong.qs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qingsong.qs.dto.InvestmentVo;
import com.qingsong.qs.mapper.InvestmentMapper;

@Service
public class InvestmentServiceImpl implements InvestmentService{
	
	@Autowired
	public InvestmentMapper investmentMapper;

	@Override
	public List<InvestmentVo> getInvestmentList() {
		return investmentMapper.getInvestmentList();
	}

	@Override
	public int deleteInvestmentById(Integer id) {
		return investmentMapper.deleteInvestmentById(id);
	}

	@Override
	public int saveInvestment(InvestmentVo investmentVo) {
		if (investmentVo.getId() != null) {
			return investmentMapper.updateInvestment(investmentVo);
		} else {
			return investmentMapper.insertInvestment(investmentVo);
		}
	}

	@Override
	public InvestmentVo getInvestmentById(Integer id) {
		return investmentMapper.getInvestmentById(id);
	}
}
