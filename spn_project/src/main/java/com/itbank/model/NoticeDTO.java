package com.itbank.model;

import java.sql.Date;

public class NoticeDTO {

	private int notice_idx;
	private String notice_writer;
	private String notice_title;
	private String notice_content;
	private Date notice_writeDate;
	private String show_check;
	
	public int getNotice_idx() {
		return notice_idx;
	}
	public void setNotice_idx(int notice_idx) {
		this.notice_idx = notice_idx;
	}
	public String getNotice_writer() {
		return notice_writer;
	}
	public void setNotice_writer(String notice_writer) {
		this.notice_writer = notice_writer;
	}
	public String getNotice_title() {
		return notice_title;
	}
	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}
	public String getNotice_content() {
		return notice_content;
	}
	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}
	public Date getNotice_writeDate() {
		return notice_writeDate;
	}
	public void setNotice_writeDate(Date notice_writeDate) {
		this.notice_writeDate = notice_writeDate;
	}
	public String getShow_check() {
		return show_check;
	}
	public void setShow_check(String show_check) {
		this.show_check = show_check;
	}
	
	
	
}
