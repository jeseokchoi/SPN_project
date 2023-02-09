package com.itbank.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.itbank.model.Product_optDTO;
import com.itbank.service.AjaxService;

@RestController
public class AjaxController {
	
	@Autowired
	private AjaxService ajaxService;

	@GetMapping("/board/optCheck/{idx}/{color}")
	public List<Product_optDTO> optCheck(@PathVariable("idx") int product_idx, @PathVariable("color") String color) {
		List<Product_optDTO> optList = ajaxService.selectOpt(product_idx, color);
		return optList;
	}
}
