package com.itbank.repository;

import org.springframework.stereotype.Repository;

import com.itbank.model.CartDTO;

@Repository
public interface CartDAO {

	CartDTO getCartList(int idx);

	
}
