package com.dv.action.base;

import com.dv.service.DataSourceService;
import com.opensymphony.xwork2.ActionSupport;


@SuppressWarnings("serial")
public class DataSourceBaseAction extends ActionSupport{
	protected DataSourceService dsservice;

	public void setDsservice(DataSourceService dsservice) {
		this.dsservice = dsservice;
	}

	
}
