package com.qingsong.qs.service;

import java.util.List;

import com.qingsong.qs.dto.TeamVo;

public interface TeamService {
	public List<TeamVo> getTeamList();
	
	public TeamVo getTeamById(Integer id);
	
	public int saveTeam(TeamVo teamVo);
	
	public int deleteTeamById(Integer id);
}
