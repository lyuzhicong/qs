package com.qingsong.qs.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qingsong.qs.dto.TeamVo;
import com.qingsong.qs.service.TeamService;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/team")
public class TeamController {
	Logger logger = LoggerFactory.getLogger(TeamController.class);

	@Autowired
	private TeamService teamService;

	@RequestMapping("")
	public String getTeamPage(HttpServletRequest request) {
		List<TeamVo> teamVoList = teamService.getTeamList();
		request.setAttribute("teamVoList", teamVoList);
		return "team/team";
	}
	
	@RequestMapping("getTeamWap")
	public String getTeamWap(HttpServletRequest request) {
		List<TeamVo> teamVoList = teamService.getTeamList();
		request.setAttribute("teamVoList", teamVoList);
		return "team/teamWap";
	}
	
	@RequestMapping("/edit/teamManager")
	public String getTeamManager(HttpServletRequest request) {
		List<TeamVo> teamList = teamService.getTeamList();
		request.setAttribute("teamList", teamList);
		return "team/teamManager";

	}

	@RequestMapping("/teamDetail")
	public String teamDetail(HttpServletRequest request, Integer id) {
		TeamVo team = teamService.getTeamById(id);
		request.setAttribute("team", team);
		request.setAttribute("teamVoList", teamService.getTeamList());
		return "team/teamDetail";
	}
	@RequestMapping("/getTeamDetailWap")
	public String getTeamDetailWap(HttpServletRequest request, Integer id) {
		TeamVo team = teamService.getTeamById(id);
		request.setAttribute("team", team);
		return "team/teamDetailWap";
	}
	
	@RequestMapping("/getTeamById")
	@ResponseBody
	public TeamVo getTeamById(HttpServletRequest request, Integer id) {
		return teamService.getTeamById(id);
	}

	@RequestMapping("/edit/deleteTeamById")
	public void deleteTeam(Integer id, HttpServletResponse response) throws IOException {
		JSONObject jsonObj = new JSONObject();
		try {
			teamService.deleteTeamById(id);
			jsonObj.put("Status", "OK");
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			jsonObj.put("Status", "ERROR");
		}
		response.setContentType("application/json;charset=UTF-8");
		response.getWriter().print(jsonObj.toString());
	}

	@RequestMapping("/edit/saveTeam")
	public void saveTeam(TeamVo teamVo, HttpServletResponse response) throws IOException {
		JSONObject jsonObj = new JSONObject();
		try {
			teamService.saveTeam(teamVo);
			jsonObj.put("Status", "OK");
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			jsonObj.put("Status", "ERROR");
		}
		response.setContentType("application/json;charset=UTF-8");
		response.getWriter().print(jsonObj.toString());
	}

}
