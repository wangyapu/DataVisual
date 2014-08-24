package com.dv.dao;

import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.dv.entity.User;



public class UserDAO extends HibernateDaoSupport {

	@SuppressWarnings("unchecked")
	public List<User> searchUser(String username, String password) {
		// TODO Auto-generated method stub
		String hql="from User where username='"+username+"' and password='"+password+"'";
		List<User> list=this.getHibernateTemplate().find(hql);
		return list;
	}

	
}
