package com.dv.service.impl;


import java.util.List;

import com.dv.dao.DataSourceDAO;
import com.dv.entity.Dbdataset;
import com.dv.entity.Filedataset;
import com.dv.service.DataSourceService;

public class DataSourceServiceImpl implements DataSourceService{
	DataSourceDAO dsDAO;
	public DataSourceDAO getDsDAO() {
		return dsDAO;
	}
	public void setDsDAO(DataSourceDAO dsDAO) {
		this.dsDAO = dsDAO;
	}

	public void addFileDataset(String datasetName, String fileName,
			String fileSize, String filePath, String separator,
			String hasheadline,String missing) {
		dsDAO.addFileDataset(datasetName, fileName, fileSize, filePath, separator, hasheadline,missing);
		
	}
	
	public int getTotalFileDataset(){
		return dsDAO.getTotalFileDataset();
	}
	
	public List<Filedataset> fileDatasetList(int pageno,int pagesize){
		return dsDAO.fileDatasetList(pageno, pagesize);
	}
	
	public Filedataset getById(String sid){
		return dsDAO.getById(sid);
	}
	
	public List<String> allDbType() {
		return dsDAO.allDbType();
	}
	
	public List<String> getDbName(String dbtype) {
		return dsDAO.getDbName(dbtype);
	}
	
	public int getTotalTable(String t0,  String t1){
		return dsDAO.getTotalTable(t0, t1);
	}
	
	public List<Dbdataset> getTableName(int pageno,int pagesize,String t0,String t1) {
		return dsDAO.getTableName(pageno,pagesize,t0,t1);
	}
	
	public Dbdataset getDbById(String sid){
		return dsDAO.getDbById(sid);
	}
	public List<Object[]> getCols(String database, String table) {
		// TODO Auto-generated method stub
		return dsDAO.getCols(database, table);
	}
}
