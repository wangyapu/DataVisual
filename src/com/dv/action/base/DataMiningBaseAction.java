package com.dv.action.base;

import com.dv.service.DataMiningService;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class DataMiningBaseAction extends ActionSupport{
	protected DataMiningService dmservice;
	public void setDmservice(DataMiningService dmservice) {
		this.dmservice = dmservice;
	}
	
	
}
