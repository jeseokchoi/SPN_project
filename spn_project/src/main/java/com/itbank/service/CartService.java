package com.itbank.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.model.CartDTO;
import com.itbank.repository.CartDAO;

@Service
public class CartService {

	@Autowired
	private CartDAO dao;
	
	public CartDTO getList(int idx) {
		return dao.getCartList(idx);
	}

	
}
