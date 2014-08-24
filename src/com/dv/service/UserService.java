package com.dv.service;

import java.util.List;

import com.dv.entity.User;




public interface UserService {

	List<User> allowLogin(String username, String password);
	
}
