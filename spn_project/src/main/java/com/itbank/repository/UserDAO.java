package com.itbank.repository;

import org.springframework.stereotype.Repository;

import com.itbank.model.UserDTO;

@Repository
public interface UserDAO {

	UserDTO login(UserDTO dto);

	int insert(UserDTO dto);

	int idDupCheck(String inputId);
	
	

}
