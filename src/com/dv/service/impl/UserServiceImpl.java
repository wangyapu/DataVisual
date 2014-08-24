package com.dv.service.impl;

import java.util.List;

import com.dv.dao.UserDAO;
import com.dv.entity.User;
import com.dv.service.UserService;


public class UserServiceImpl implements UserService{
	UserDAO userDAO;

	public UserDAO getUserDAO() {
		return userDAO;
	}

	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}

	public List<User> allowLogin(String username, String password) {
		// TODO Auto-generated method stub
		List<User> list=userDAO.searchUser(username,password);
		return list;
	}
	
	
}
