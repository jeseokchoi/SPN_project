package com.itbank.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.model.ProductDTO;
import com.itbank.repository.ProductDAO;

@Service
public class ProductService {
	
	@Autowired
	private ProductDAO dao;

	public List<ProductDTO> getList() {
		return dao.selectList();
	}

}
