package com.qingsong.qs.dto;

import java.util.ArrayList;
import java.util.List;

public class TeamVo {

	private Integer id;

	private String name;
	private String imagePath;
	private String content;
	private String focusAreas;
	private String projects;
	private String introduction;
	private String email;
	private String identity;
	
	private List<String> projectList;
	
	private Integer location;
	
	public List<String> getProjectList(){
		this.projectList = new ArrayList<String>();
		if(projects != null && !"".equals(projects)) {
			String[] projectArray = projects.split(";");
			for(String project : projectArray) {
				projectList.add(project);
			}
		}
		return projectList;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	public Integer getLocation() {
		return location;
	}

	public void setLocation(Integer location) {
		this.location = location;
	}

	public String getProjects() {
		return projects;
	}

	public void setProjects(String projects) {
		this.projects = projects;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getIdentity() {
		return identity;
	}

	public void setIdentity(String identity) {
		this.identity = identity;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getFocusAreas() {
		return focusAreas;
	}

	public void setFocusAreas(String focusAreas) {
		this.focusAreas = focusAreas;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
