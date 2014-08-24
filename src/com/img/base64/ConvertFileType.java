package com.img.base64;


import java.awt.Rectangle;
import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Iterator;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.imageio.ImageReadParam;
import javax.imageio.ImageReader;
import javax.imageio.stream.ImageInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;


public class ConvertFileType extends ActionSupport
{
	private static final long serialVersionUID = -1916452043647719029L;
	
	private String type;
	private  InputStream  inputStream;
	
	/**
	 * post方法的回调函数处理
	 * window.open(spath+"myexport?contentfile="+contentfile+"&namefile="+namefile,"_self");
	 * 把服务器中存放的txt文件名称，传到这个action方法中
	 * 
	 */
	public String DownloadImg() throws IOException{

		HttpServletRequest request = ServletActionContext.getRequest(); 
		ActionContext actionContext = ActionContext.getContext();
		Map session = actionContext.getSession();
		String filename = (String) session.get("filepath");
		System.out.println(filename+"."+type);
		request.setAttribute("fileN","convertFile"+"."+type);
	    return SUCCESS;
	}
	
	public  String  getPc() throws Exception {
		return SUCCESS;
	}
	
	public InputStream  getInputStream() {
		try {
			  HttpServletRequest request = ServletActionContext.getRequest(); 
		      
		    ActionContext actionContext = ActionContext.getContext();
			Map session = actionContext.getSession();
			String filename = (String) session.get("filepath");
			inputStream=new FileInputStream(filename);
				
				
			//request.setAttribute("fileN","convertFile"+"."+type);
		      
			  return inputStream;
			} catch (Exception e) {
				e.printStackTrace();
			}
		return  null;
	}
	

	public static long getSerialversionuid() {
		return serialVersionUID;
	}


	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

}
