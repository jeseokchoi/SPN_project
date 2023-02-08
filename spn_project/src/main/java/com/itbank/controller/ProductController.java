package com.itbank.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.model.ProductDTO;
import com.itbank.service.ProductService;

@Controller
@RequestMapping("/board")
public class ProductController {

	@Autowired
	private ProductService productService;
	
	@GetMapping("/{cat}")
	public ModelAndView productList(@PathVariable("cat") String cat) {
		ModelAndView mav = new ModelAndView("/board/productList");
		List<ProductDTO> list = productService.getList(cat);
		
		String s = "";
		if(!cat.equals("m_") && !cat.equals("w_")) {
			s = cat.substring(cat.indexOf("_")+1).toUpperCase();
		}else {
			s = "ALL";
		}
		mav.addObject("category",s);
		
		mav.addObject("list", list);
		return mav;
	}
}
