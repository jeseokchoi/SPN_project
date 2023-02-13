package com.itbank.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.model.ProductDTO;
import com.itbank.model.Product_t_imgDTO;
import com.itbank.repository.ProductDAO;

@Service
public class ProductService {
	
	@Autowired
	private ProductDAO dao;

	public List<ProductDTO> getList(String cat) {
		List<ProductDTO> list = dao.selectList(cat);
		List<String> tList = dao.select_t_img(cat);
		System.out.println("tList: "+tList);
		
		for(int i = 0; i < list.size(); i++) {
			List<String> li = new ArrayList<String>();
			li.add(tList.get(i));
			list.get(i).setProduct_t_img(li);
		}
		return list;
	}

	public ProductDTO getDTO(int idx) {
		ProductDTO dto = dao.selectOne(idx);
		dto.setProduct_t_img(dao.selectTImgList(idx));
		dto.setProduct_d_img(dao.selectDImgList(idx));
		return dto;
	}

	public int insertProductDTO(ProductDTO dto) {
		return dao.insertProductDTO(dto);
	}

	public int getProductIdx(ProductDTO dto) {
		return dao.selectProductIdx(dto);
	}

	public List<Product_t_imgDTO> getHomeList() {
		return dao.selectHomeList();
	}

}
