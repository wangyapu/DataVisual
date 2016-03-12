package com.dv.action;


import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.util.UUID;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;


@SuppressWarnings("serial")
public class DatasetUploadAction extends ActionSupport {

    private File doc;
    private String fileName;
    private String fileType;
    private String filePath;
    private String fileSize;
    private String savaPath;

    public File getDoc() {
        return doc;
    }

    public void setDoc(File doc) {
        this.doc = doc;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getFileSize() {
        return fileSize;
    }

    public void setFileSize(String fileSize) {
        this.fileSize = fileSize;
    }

    public String getFileType() {
        return fileType;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType;
    }

    public void setDocContentType(String fileType) {
        this.fileType = fileType;
    }

    public void setDocFileName(String fileName) {
        this.fileName = fileName;
    }

    @SuppressWarnings("deprecation")
    public String getSavaPath() {
        return ServletActionContext.getRequest().getRealPath(savaPath);
    }

    public void setSavaPath(String savaPath) {
        this.savaPath = savaPath;
    }

    public String execute() throws Exception {
        UUID uuid = UUID.randomUUID();
        String fileId = uuid.toString();
        int position = fileName.lastIndexOf(".");
        String extention = fileName.substring(position);
        File target = new File(getSavaPath(), fileId + extention);
        try {
            FileUtils.copyFile(doc, target);
        } catch (IOException e) {
            e.printStackTrace();
        }
        filePath = fileId + extention;
        DecimalFormat df = new DecimalFormat("0.00");
        fileSize = df.format(doc.length() / 1024.0 / 1024.0);
        PrintWriter out = ServletActionContext.getResponse().getWriter();
        out.print(URLEncoder.encode(fileName, "utf-8") + "," + filePath + "," + fileSize);
        out.close();
        return SUCCESS;
    }

}
