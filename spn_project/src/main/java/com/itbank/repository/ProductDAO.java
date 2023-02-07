package com.itbank.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.itbank.model.ProductDTO;

@Repository
public interface ProductDAO {

	List<ProductDTO> selectList();
	
}
