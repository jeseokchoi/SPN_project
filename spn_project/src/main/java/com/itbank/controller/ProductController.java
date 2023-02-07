package com.itbank.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.model.ProductDTO;
import com.itbank.service.ProductService;

@Controller
public class ProductController {

	@Autowired
	private ProductService productService;
	
	@GetMapping("/board/man/top")
	public ModelAndView productList() {
		ModelAndView mav = new ModelAndView();
		
		List<ProductDTO> list = productService.getList();
		mav.addObject("list", list);
		return mav;
	}
}
