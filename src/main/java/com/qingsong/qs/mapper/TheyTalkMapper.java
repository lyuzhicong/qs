package com.qingsong.qs.mapper;

import java.util.List;

import com.qingsong.qs.dto.TheyTalkVo;

public interface TheyTalkMapper {
	public List<TheyTalkVo> getTheyTalkVoList();

	public int insertTheyTalk(TheyTalkVo theyTalkVo);

	public int updateTheyTalk(TheyTalkVo theyTalkVo);

	public int deleteTheyTalkById(Integer id);

	public TheyTalkVo getTheyTalkById(Integer id);
	
	public int updateIsShow(String configVal);
	
	public Integer getIsShow();
	
}
