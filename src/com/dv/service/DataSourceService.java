package com.dv.service;

import java.util.List;

import com.dv.entity.Dbdataset;
import com.dv.entity.Filedataset;




public interface DataSourceService {

	public void addFileDataset(String datasetName,String fileName, String fileSize,String filePath, String separator,String hasheadline,String missing);
	
	public int getTotalFileDataset();
	
	public List<Filedataset> fileDatasetList(int pageno,int pagesize);
	
	public Filedataset getById(String sid);
	
	public List<String> allDbType();
	
	public List<String> getDbName(String dbtype);
	
	public int getTotalTable(String t0,  String t1);
	
	public List<Dbdataset> getTableName(int pageno,int pagesize,String t0,String t1);
	
	public Dbdataset getDbById(String sid);
	
	public List<Object[]> getCols(String database , String table);
}
