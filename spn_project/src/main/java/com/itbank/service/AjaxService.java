package com.itbank.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.model.Product_optDTO;
import com.itbank.repository.ProductDAO;

@Service
public class AjaxService {
	
	@Autowired
	private ProductDAO dao;

	public List<Product_optDTO> selectOpt(int product_idx, String color) {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("product_idx", product_idx+"");
		param.put("color", color);
		return dao.selectOpt(param);
	}

}
