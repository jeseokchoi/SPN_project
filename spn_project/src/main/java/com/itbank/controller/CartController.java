package com.itbank.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.model.CartDTO;
import com.itbank.service.CartService;

@Controller
@RequestMapping("/board")
public class CartController {
	
	@Autowired
	private CartService cartService;

	@GetMapping("/cart/{idx}")
	public ModelAndView cartList(@PathVariable("idx") int idx ) {
		ModelAndView mav = new ModelAndView("/board/cart");
		CartDTO dto = cartService.getList(idx);
		mav.addObject("dto", dto);
		return mav;
		
	}
}
