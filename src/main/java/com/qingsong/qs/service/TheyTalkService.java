package com.qingsong.qs.service;

import java.util.List;

import com.qingsong.qs.dto.TheyTalkVo;

public interface TheyTalkService {
	public List<TheyTalkVo> getTheyTalkVoList();

	public TheyTalkVo getTheyTalkById(Integer id);

	public int deleteTheyTalkById(Integer id);
	
	public int saveTheyTalk(TheyTalkVo theyTalkVo);

	public void updateIsShow(String configVal);
	
	public Integer getIsShow();
}
