package com.itbank.model;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class ProductDTO {

	private int product_idx;
	private String product_code;
	private String product_name;
	private int product_price;
	private String product_desc;
	private Date product_date;
	private int product_hits;
	private String delete_check;
	private String show_check;
	private List<MultipartFile> upload_t_file;
	private List<MultipartFile> upload_d_file;
	private List<String> product_t_img;
	private List<String> product_d_img;
	
	public int getProduct_idx() {
		return product_idx;
	}
	
	public List<MultipartFile> getUpload_t_file() {
		return upload_t_file;
	}

	public void setUpload_t_file(List<MultipartFile> upload_t_file) {
		this.upload_t_file = upload_t_file;
	}

	public List<MultipartFile> getUpload_d_file() {
		return upload_d_file;
	}

	public void setUpload_d_file(List<MultipartFile> upload_d_file) {
		this.upload_d_file = upload_d_file;
	}

	public List<String> getProduct_t_img() {
		return product_t_img;
	}

	public void setProduct_t_img(List<String> product_t_img) {
		this.product_t_img = product_t_img;
	}

	public List<String> getProduct_d_img() {
		return product_d_img;
	}

	public void setProduct_d_img(List<String> product_d_img) {
		this.product_d_img = product_d_img;
	}

	public void setProduct_idx(int product_idx) {
		this.product_idx = product_idx;
	}
	public String getProduct_code() {
		return product_code;
	}
	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public int getProduct_price() {
		return product_price;
	}
	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}
	public String getProduct_desc() {
		return product_desc;
	}
	public void setProduct_desc(String product_desc) {
		this.product_desc = product_desc;
	}
	public Date getProduct_date() {
		return product_date;
	}
	public void setProduct_date(Date product_date) {
		this.product_date = product_date;
	}
	public int getProduct_hits() {
		return product_hits;
	}
	public void setProduct_hits(int product_hits) {
		this.product_hits = product_hits;
	}
	public String getDelete_check() {
		return delete_check;
	}
	public void setDelete_check(String delete_check) {
		this.delete_check = delete_check;
	}
	public String getShow_check() {
		return show_check;
	}
	public void setShow_check(String show_check) {
		this.show_check = show_check;
	}
	
	
}
