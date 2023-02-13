package com.itbank.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.itbank.model.DeliverAddressDTO;
import com.itbank.model.UserDTO;

@Repository
public interface UserDAO {

	UserDTO login(UserDTO dto);

	int insert(UserDTO dto);

	int idDupCheck(String inputId);

	List<DeliverAddressDTO> selectList(String user_id);

	int insertAddress(DeliverAddressDTO dto);

	DeliverAddressDTO addressOne(String userId);
	

}
