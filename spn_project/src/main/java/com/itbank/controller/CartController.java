package com.itbank.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.model.CartDTO;
import com.itbank.service.CartService;

@Controller
@RequestMapping("/board")
public class CartController {
	
	@Autowired
	private CartService cartService;

	@PostMapping("/cart/nonUser")
	public ModelAndView cartList(List<CartDTO> cartDTO ) {
		ModelAndView mav = new ModelAndView("/board/cart");
		System.out.println("왔니?");
		System.out.println(cartDTO);
		return mav;
		
	}
//	@GetMapping("/cart/{product_opt_idx}")
//	@ResponseBody
//	public String cartList(@PathVariable("product_opt_idx") int product_opt_idx) throws IOException {
//		System.out.println(product_opt_idx);
//		List<CartDTO> list = cartService.getCartList(product_opt_idx);
//		String jsonString = mapper.writeValueAsString(list);
//		System.out.println(jsonString);
//		return jsonString;
//	}
}
