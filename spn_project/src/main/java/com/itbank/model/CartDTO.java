package com.itbank.model;

public class CartDTO {

		private int cart_idx;
		private String cart_value;
		private int product_idx;
		private int product_opt_idx;
		private int product_count;
		private String product_size;
		private String product_color;
		private String product_name;
		private int product_price;
		private String product_opts;
		
		public int getProduct_idx() {
			return product_idx;
		}
		public void setProduct_idx(int product_idx) {
			this.product_idx = product_idx;
		}
		public String getProduct_size() {
			return product_size;
		}
		public void setProduct_size(String product_size) {
			this.product_size = product_size;
		}
		public String getProduct_color() {
			return product_color;
		}
		public void setProduct_color(String product_color) {
			this.product_color = product_color;
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
		public String getProduct_opts() {
			return product_opts;
		}
		public void setProduct_opts(String product_opts) {
			this.product_opts = product_opts;
		}
		public int getCart_idx() {
			return cart_idx;
		}
		public void setCart_idx(int cart_idx) {
			this.cart_idx = cart_idx;
		}
		public int getProduct_opt_idx() {
			return product_opt_idx;
		}
		public void setProduct_opt_idx(int product_opt_idx) {
			this.product_opt_idx = product_opt_idx;
		}
		public String getCart_value() {
			return cart_value;
		}
		public void setCart_value(String cart_value) {
			this.cart_value = cart_value;
		}
		public int getProduct_count() {
			return product_count;
		}
		public void setProduct_count(int product_count) {
			this.product_count = product_count;
		}
		
		
	
}
