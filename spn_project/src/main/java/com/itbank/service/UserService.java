package com.itbank.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.model.DeliverAddressDTO;
import com.itbank.model.UserDTO;
import com.itbank.repository.UserDAO;

@Service
public class UserService {
	
	@Autowired private UserDAO dao;

	public UserDTO login(UserDTO dto) {
		
		return dao.login(dto);
	}

	public int join(UserDTO dto) {
		return dao.insert(dto);
	}

	public int dupCheck(String inputId) {
		
		return dao.idDupCheck(inputId);
	}

	public List<DeliverAddressDTO> getList(String user_id) {
		return dao.selectList(user_id);
	}

	public int addressRegist(DeliverAddressDTO dto) {
	
		return dao.insertAddress(dto);
	}

	public DeliverAddressDTO getOne(String userId) {
		
		return dao.addressOne(userId);
	}
	

}
