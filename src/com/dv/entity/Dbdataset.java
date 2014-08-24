package com.dv.entity;

/**
 * Dbdataset entity. @author MyEclipse Persistence Tools
 */

public class Dbdataset implements java.io.Serializable {

	// Fields

	private Integer id;
	private String dbtype;
	private String dbname;
	private String tablename;

	// Constructors

	/** default constructor */
	public Dbdataset() {
	}

	/** full constructor */
	public Dbdataset(String dbtype, String dbname, String tablename) {
		this.dbtype = dbtype;
		this.dbname = dbname;
		this.tablename = tablename;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getDbtype() {
		return this.dbtype;
	}

	public void setDbtype(String dbtype) {
		this.dbtype = dbtype;
	}

	public String getDbname() {
		return this.dbname;
	}

	public void setDbname(String dbname) {
		this.dbname = dbname;
	}

	public String getTablename() {
		return this.tablename;
	}

	public void setTablename(String tablename) {
		this.tablename = tablename;
	}

}