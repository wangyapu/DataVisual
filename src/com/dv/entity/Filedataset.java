package com.dv.entity;

import java.sql.Timestamp;

/**
 * Filedataset entity. @author MyEclipse Persistence Tools
 */

public class Filedataset implements java.io.Serializable {

	// Fields

	private Integer id;
	private String datasetname;
	private String filename;
	private String filesize;
	private String filepath;
	private String filetype;
	private String separate;
	private String hasheadline;
	private String missing;
	private Timestamp uploadtime;
	private String user;

	// Constructors

	/** default constructor */
	public Filedataset() {
	}

	/** full constructor */
	public Filedataset(String datasetname, String filename, String filesize,
			String filepath, String filetype, String separate,
			String hasheadline, String missing, Timestamp uploadtime,
			String user) {
		this.datasetname = datasetname;
		this.filename = filename;
		this.filesize = filesize;
		this.filepath = filepath;
		this.filetype = filetype;
		this.separate = separate;
		this.hasheadline = hasheadline;
		this.missing = missing;
		this.uploadtime = uploadtime;
		this.user = user;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getDatasetname() {
		return this.datasetname;
	}

	public void setDatasetname(String datasetname) {
		this.datasetname = datasetname;
	}

	public String getFilename() {
		return this.filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getFilesize() {
		return this.filesize;
	}

	public void setFilesize(String filesize) {
		this.filesize = filesize;
	}

	public String getFilepath() {
		return this.filepath;
	}

	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}

	public String getFiletype() {
		return this.filetype;
	}

	public void setFiletype(String filetype) {
		this.filetype = filetype;
	}

	public String getSeparate() {
		return this.separate;
	}

	public void setSeparate(String separate) {
		this.separate = separate;
	}

	public String getHasheadline() {
		return this.hasheadline;
	}

	public void setHasheadline(String hasheadline) {
		this.hasheadline = hasheadline;
	}

	public String getMissing() {
		return this.missing;
	}

	public void setMissing(String missing) {
		this.missing = missing;
	}

	public Timestamp getUploadtime() {
		return this.uploadtime;
	}

	public void setUploadtime(Timestamp uploadtime) {
		this.uploadtime = uploadtime;
	}

	public String getUser() {
		return this.user;
	}

	public void setUser(String user) {
		this.user = user;
	}

}