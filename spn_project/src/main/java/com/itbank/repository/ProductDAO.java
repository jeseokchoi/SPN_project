package com.itbank.repository;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.itbank.model.ProductDTO;
import com.itbank.model.Product_optDTO;
import com.itbank.model.Product_t_imgDTO;

@Repository
public interface ProductDAO {

	List<ProductDTO> selectList(String cat);

	List<String> select_t_img(String cat);

	ProductDTO selectOne(int idx);

	List<String> selectTImgList(int idx);

	List<String> selectDImgList(int idx);
	
	List<Product_optDTO> selectOpt(HashMap<String, String> param);

	int insertProductDTO(ProductDTO dto);

	int selectProductIdx(ProductDTO dto);

	int insertTImg(HashMap<String, String> param);

	int insertDImg(HashMap<String, String> param);
	
}
