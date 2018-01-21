package com.qingsong.qs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qingsong.qs.dto.TheyTalkVo;
import com.qingsong.qs.mapper.TheyTalkMapper;

@Service
public class TheyTalkServiceImpl implements TheyTalkService{
	
	@Autowired
	public TheyTalkMapper theyTalkMapper;

	@Override
	public List<TheyTalkVo> getTheyTalkVoList() {
		return theyTalkMapper.getTheyTalkVoList();
	}

	@Override
	public TheyTalkVo getTheyTalkById(Integer id) {
		return theyTalkMapper.getTheyTalkById(id);
	}

	@Override
	public int deleteTheyTalkById(Integer id) {
		return theyTalkMapper.deleteTheyTalkById(id);
	}

	@Override
	public int saveTheyTalk(TheyTalkVo theyTalkVo) {
		if(theyTalkVo.getId() != null) {
			return theyTalkMapper.updateTheyTalk(theyTalkVo);
		} else {
			return theyTalkMapper.insertTheyTalk(theyTalkVo);
		}
	}

}
