package com.qingsong.qs.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qingsong.qs.dto.AboutQsVo;
import com.qingsong.qs.mapper.AboutQsMapper;

@Service
public class AboutQsServiceImpl implements AboutQsService{
	
	@Autowired
	public AboutQsMapper aboutQsMapper;

	@Override
	public AboutQsVo getAboutQsVo() {
		return aboutQsMapper.getAboutQsVo();
	}

	@Override
	public int updateAboutQsVo(AboutQsVo aboutQsVo) {
		if(aboutQsVo.getId() == null) {
			
			return aboutQsMapper.insertAboutQsVo(aboutQsVo);
		} else {
			return aboutQsMapper.updateAboutQsVo(aboutQsVo);
		}
	}

}
