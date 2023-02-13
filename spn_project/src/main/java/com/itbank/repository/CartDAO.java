package com.itbank.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.itbank.model.CartDTO;
import com.itbank.model.Product_optDTO;

@Repository
public interface CartDAO {

//	CartDTO getCartList(int product_opt_idx);

	List<CartDTO> getCartList(int product_opt_idx);

	Product_optDTO selectCartDTO(CartDTO cartDTO);

	
}
