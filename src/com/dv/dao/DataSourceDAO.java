package com.dv.dao;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.dv.entity.Dbdataset;
import com.dv.entity.Filedataset;



public class DataSourceDAO extends HibernateDaoSupport {

	public void addFileDataset(String datasetName,String fileName, String fileSize,String filePath, String separator,String hasheadline,String missing) {
		int position=fileName.lastIndexOf(".");
	    String extention=fileName.substring(position+1);
	    Timestamp now=new Timestamp(System.currentTimeMillis());
		Filedataset fd=new Filedataset();
		fd.setDatasetname(datasetName);
		fd.setFilename(fileName);
		fd.setFilepath(filePath);
		fd.setFilesize(fileSize);
		fd.setFiletype(extention);
		fd.setHasheadline(hasheadline);
		fd.setSeparate(separator);
		fd.setMissing(missing);
		fd.setUploadtime(now);
		fd.setUser("admin");
	    this.getHibernateTemplate().save(fd);
	}

	@SuppressWarnings("unchecked")
	public int getTotalFileDataset(){
		String hql="select count(*) from Filedataset";
    	List<Number> list=this.getHibernateTemplate().find(hql);
    	Number a=list.get(0);
    	return a.intValue();
	}
	
	@SuppressWarnings("unchecked")
	public List<Filedataset> fileDatasetList(final int pageno,final int pagesize){
		List<Filedataset> allFileDataset=getHibernateTemplate().executeFind(new HibernateCallback(){
			public Object doInHibernate(Session session)
			throws HibernateException, SQLException {
				String hql="from Filedataset order by uploadtime desc";
				Query query=session.createQuery(hql);
				query.setFirstResult((pageno-1)*pagesize);
				query.setMaxResults(pagesize);
				List<Filedataset> list=query.list();
				return list;
			}			
		});
		return allFileDataset;
	}
	
	public Filedataset getById(String sid){
		Filedataset fd=new Filedataset();
		int id=Integer.parseInt(sid);
		this.getHibernateTemplate().load(fd, id);
		return fd;
	}
	
	@SuppressWarnings("unchecked")
	public List<String> allDbType(){
		String hql="select distinct dbtype from Dbdataset";
		List<String> list=this.getHibernateTemplate().find(hql);
		return list;
	}
	
	@SuppressWarnings("unchecked")
	public List<String> getDbName(String dbtype){
		String hql="select distinct dbname from Dbdataset where dbtype='"+dbtype+"'";
		List<String> list=this.getHibernateTemplate().find(hql);
		return list;
	}
	
	/*@SuppressWarnings("unchecked")
	public List<Dbdataset> getTableName(String t0,String t1){
		String hql="from Dbdataset where dbtype='"+t0+"' and dbname='"+t1+"'";
		List<Dbdataset> list=this.getHibernateTemplate().find(hql);
		return list;
	}*/
	
	@SuppressWarnings("unchecked")
	public int getTotalTable(String t0,  String t1){
		String hql="select count(*) from Dbdataset where dbtype='"+t0+"' and dbname='"+t1+"'";
    	List<Number> list=this.getHibernateTemplate().find(hql);
    	Number a=list.get(0);
    	return a.intValue();
	}
	
	@SuppressWarnings("unchecked")
	public List<Dbdataset> getTableName(final int pageno,final int pagesize,final String t0, final String t1){
		List<Dbdataset> allDbDataset=getHibernateTemplate().executeFind(new HibernateCallback(){
			public Object doInHibernate(Session session)
			throws HibernateException, SQLException {
				String hql="from Dbdataset where dbtype='"+t0+"' and dbname='"+t1+"'";
				Query query=session.createQuery(hql);
				query.setFirstResult((pageno-1)*pagesize);
				query.setMaxResults(pagesize);
				List<Dbdataset> list=query.list();
				return list;
			}			
		});
		return allDbDataset;
	}
	
	public Dbdataset getDbById(String sid){
		Dbdataset dd=new Dbdataset();
		int id=Integer.parseInt(sid);
		this.getHibernateTemplate().load(dd, id);
		return dd;
	}
	
	public List<Object[]> getCols(String db,String tb)
	{
		
		String hql="select COLUMN_NAME,DATA_TYPE from information_schema.columns where table_schema='"+db+"' and table_name='"+tb+"'";
    	Session session = null;
		try {
			session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		} catch (HibernateException e) {
			// TODO Auto-generated catch block
			session = this.getHibernateTemplate().getSessionFactory().openSession();
			//e.printStackTrace();
		}
    	
    	Query q = session.createSQLQuery(hql);
    	List<Object[]> obj =(List<Object[]>) q.list();
    	
    	
    	/*try {
			for(Object[] s:obj)
			{
				for(int i=0 ; i<s.length ; i++)
					System.out.print(s[i] + " ");
				System.out.println();
				
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
    	
    	return obj;

    	
	}
	
}
