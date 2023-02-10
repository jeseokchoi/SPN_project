package com.itbank.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.itbank.model.ProductDTO;
import com.itbank.repository.ProductDAO;

@Service
public class FileService {
	
	@Autowired
	private ProductDAO productDAO;
	
	private final String saveDirectory = "C:\\itemImg";
			
	public FileService() {
		File dir = new File(saveDirectory);
		if(dir.exists() == false) {
			dir.mkdirs();
		}
	}	
	public int tFileUpload(MultipartFile file, String cat, int product_idx, int idx) {
		
		// t_img 파일 이름 생성
		String fileName = cat + "_" + product_idx + "_t_"+idx +"."+ file.getContentType().split("/")[1];
		System.out.println("fileName = "+fileName);
		
		// t_img 테이블에 데이터 생성
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("fileName", fileName);
		param.put("product_idx", product_idx+"");
		int row = productDAO.insertTImg(param);
		
		File dest = new File(saveDirectory, fileName);
		
		try {
			file.transferTo(dest);
			return 1;
			
		} catch (IllegalStateException | IOException e) {e.printStackTrace();}
		
		return 0;
	}
	
	public int dFileUpload(MultipartFile file, String cat, int product_idx, int idx) {
		
		// t_img 파일 이름 생성
		String fileName = cat + "_" + product_idx + "_d_"+idx +"."+ file.getContentType().split("/")[1];
		System.out.println("fileName = "+fileName);
		
		// t_img 테이블에 데이터 생성
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("fileName", fileName);
		param.put("product_idx", product_idx+"");
		int row = productDAO.insertDImg(param);
		
		File dest = new File(saveDirectory, fileName);
		
		try {
			file.transferTo(dest);
			return 1;
			
		} catch (IllegalStateException | IOException e) {e.printStackTrace();}
		
		return 0;
	}
	


	public int uploadMultipleFile(ProductDTO dto, int idx) {
		List<MultipartFile> tList = dto.getUpload_t_file();
		List<MultipartFile> dList = dto.getUpload_d_file();
		tList.removeIf(file -> file.getSize() == 0);
		dList.removeIf(file -> file.getSize() == 0);
		dto.setUpload_t_file(tList);
		dto.setUpload_d_file(dList);
		
		int row = 0;
		
		for(int i = 0; i < dto.getUpload_t_file().size(); i++) {
			row += tFileUpload(dto.getUpload_t_file().get(i), dto.getProduct_code(), idx, i+1);
		}
		for(int i = 0; i < dto.getUpload_d_file().size(); i++) {
			row += dFileUpload(dto.getUpload_d_file().get(i), dto.getProduct_code(), idx, i+1);
		}
		
		
		return 0;
	}

}
