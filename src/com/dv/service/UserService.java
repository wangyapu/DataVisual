package com.dv.service;

import com.dv.entity.User;

import java.util.List;


public interface UserService {

    List<User> allowLogin(String username, String password);

}
