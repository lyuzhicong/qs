package com.qingsong.qs.dto;

public class ArticleVo {
	private Long id;
	private String title;
	private String littleTitle;
	private String content;
	private String date;
	private String path;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getLittleTitle() {
		return littleTitle;
	}

	public void setLittleTitle(String littleTitle) {
		this.littleTitle = littleTitle;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

}
