package com.dv.action.base;

import com.dv.service.UserService;
import com.opensymphony.xwork2.ActionSupport;



@SuppressWarnings("serial")
public class LoginBaseAction extends ActionSupport{
	protected UserService userservice;

	public void setUserservice(UserService userservice) {
		this.userservice = userservice;
	}
}
