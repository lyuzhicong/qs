package com.qingsong.qs.mapper;

import java.util.List;

import com.qingsong.qs.dto.TeamVo;

public interface TeamMapper {
	public List<TeamVo> getTeamList();
	
	public TeamVo getTeamById(Integer id);
	
	public int updateTeam(TeamVo teamVo);
	
	public int insertTeam(TeamVo teamVo);
	
	public int deleteTeamById(Integer id);
	
}
