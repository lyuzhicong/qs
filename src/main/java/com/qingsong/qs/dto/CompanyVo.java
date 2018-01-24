package com.qingsong.qs.dto;

public class CompanyVo {

	private Integer id;

	private String imagePath;
	private String introduction;
	private String content;
	private String logoImagePath;
	private String littleLogoImagePath;
	private Integer location;

	public Integer getLocation() {
		return location;
	}

	public String getLogoImagePath() {
		return logoImagePath;
	}

	public void setLogoImagePath(String logoImagePath) {
		this.logoImagePath = logoImagePath;
	}

	public String getLittleLogoImagePath() {
		return littleLogoImagePath;
	}

	public void setLittleLogoImagePath(String littleLogoImagePath) {
		this.littleLogoImagePath = littleLogoImagePath;
	}

	public void setLocation(Integer location) {
		this.location = location;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
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
}
