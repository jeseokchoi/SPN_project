package com.itbank.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itbank.model.ProductDTO;
import com.itbank.service.FileService;
import com.itbank.service.ProductService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired private FileService fileService;
	@Autowired private ProductService productService;
	
	@GetMapping("/index")
	public void index() {}
	
	@GetMapping("/uploadFile")
	public void uploadFile() {}
	
	@PostMapping("/uploadFile")
	public String uploadFile(ProductDTO dto) {
		
		int row = productService.insertProductDTO(dto);
		int idx = productService.getProductIdx(dto);
		fileService.uploadMultipleFile(dto, idx);
		
		return "/admin/index";
	}
	
	
}
