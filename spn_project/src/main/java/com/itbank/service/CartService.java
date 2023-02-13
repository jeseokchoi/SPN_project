package com.itbank.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.model.CartDTO;
import com.itbank.model.Product_optDTO;
import com.itbank.repository.CartDAO;

@Service
public class CartService {

	@Autowired
	private CartDAO dao;
	
//	public CartDTO getList(int product_opt_idx) {
//		return dao.getCartList(product_opt_idx);
//	}

	public List<CartDTO> getCartList(int product_opt_idx) {
		return dao.getCartList(product_opt_idx);
	}

	public Product_optDTO getProductOptDTO(CartDTO cartDTO) {
		return dao.selectCartDTO(cartDTO);
	}

	
}
