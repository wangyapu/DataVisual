package com.dv.action;

import java.io.InputStream;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class DownloadFileAction extends ActionSupport {
    private String fileName;
    private String mypath;   //下载路径
    @SuppressWarnings("unused")
    private InputStream downloadFile;

    public String getMypath() {
        return mypath;
    }

    public void setMypath(String mypath) {
        this.mypath = mypath;
    }

    //主要的方法
    public InputStream getDownloadFile() {
        try {

            HttpServletRequest request = ServletActionContext.getRequest();
            mypath = (String) request.getAttribute("mypath");

            //将制定的文件作为一个流返回出去;
            return ServletActionContext
                    .getServletContext()
                    .getResourceAsStream("/WEB-INF/DownloadFiles/" + mypath);


        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public String execute() throws Exception {
        return SUCCESS;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public void setDownloadFile(InputStream downloadFile) {
        this.downloadFile = downloadFile;
    }


}

