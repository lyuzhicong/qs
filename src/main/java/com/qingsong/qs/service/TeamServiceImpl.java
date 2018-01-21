package com.qingsong.qs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qingsong.qs.dto.TeamVo;
import com.qingsong.qs.mapper.TeamMapper;

@Service
public class TeamServiceImpl implements TeamService {

	@Autowired
	public TeamMapper teamMapper;

	@Override
	public List<TeamVo> getTeamList() {
		return teamMapper.getTeamList();
	}

	@Override
	public TeamVo getTeamById(Integer id) {
		return teamMapper.getTeamById(id);
	}

	@Override
	public int saveTeam(TeamVo teamVo) {
		if (teamVo.getId() != null) {
			return teamMapper.updateTeam(teamVo);
		} else {
			return teamMapper.insertTeam(teamVo);
		}
	}

	@Override
	public int deleteTeamById(Integer id) {
		return teamMapper.deleteTeamById(id);
	}

}
