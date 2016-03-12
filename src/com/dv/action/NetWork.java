package com.dv.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.rosuda.JRI.Rengine;

import com.dv.action.base.DataSourceBaseAction;
import com.dv.entity.Filedataset;
import com.dv.util.FileDatasetDetailBean;
import com.dv.util.StaticData;
import com.dv.util.ToolsFactory;
import com.opensymphony.xwork2.ActionContext;

@SuppressWarnings("serial")
public class NetWork extends DataSourceBaseAction {
    private String ids1;
    private String ids2;
    private String sid;
    private String separator;
    private String hasheadline;
    private String missing;
    private double filedatasize;
    private int totalrow;
    private List<FileDatasetDetailBean> fddBeans = new ArrayList<FileDatasetDetailBean>();
    private String[] datacolnames;


    //指定保存的名称
    private String headname;
    //上传文件域
    private File upload;
    //上传文件类型
    private String uploadFileType;
    //上传文件名
    private String uploadFileName;
    //直接在sturts.xml文件中配置值的属性
    private String savePath;

    public String readNameFile() {
        HttpServletRequest request = ServletActionContext.getRequest();
        Filedataset fd = dsservice.getById(sid);
        separator = fd.getSeparate();
        hasheadline = fd.getHasheadline();
        missing = fd.getMissing();
        filedatasize = Double.parseDouble(fd.getFilesize());
        String filePath = (request.getRealPath("/datasets") + "\\" + fd.getFilepath()).replace("\\", "/");
        StaticData sd = StaticData.getInstance();
        sd.setAr();
        Rengine c = sd.re;
        c.eval("rm(list=ls()");
        if (filedatasize < 4) {
            c.eval("data_name<-read.table('" + filePath + "',header=" + hasheadline + ",sep='" + separator + "')");
            c.eval("{rcolname<-names(data_name);dim(rcolname)<-c(length(names(data_name)))}");
            String colnames[] = c.eval("rcolname").asStringArray();
            datacolnames = new String[colnames.length + 1];
            for (int i = 0; i <= colnames.length; i++) {
                if (i == 0) {
                    datacolnames[i] = "序号";
                } else {
                    datacolnames[i] = colnames[i - 1];
                }
            }
            Map<String, Object> session = ActionContext.getContext().getSession();
            session.remove("colnames");
            session.put("colnames", colnames);
            String coltypes[] = ToolsFactory.getColType(filePath, hasheadline, separator, missing, colnames.length);
            session.remove("coltypes");
            session.put("coltypes", coltypes);
            int missingnum[] = new int[colnames.length];
            double missingratio[] = new double[colnames.length];
            totalrow = c.eval("length(data_name[,1])").asInt();
            DecimalFormat df = new DecimalFormat("##.##");

            if (!missing.equals("无缺失值")) {
                for (int i = 0; i < colnames.length; i++) {
                    c.eval("data_name[," + (i + 1) + "][data_name[," + (i + 1) + "]=='" + missing + "']=NA");
                    missingnum[i] = c.eval("sum(is.na(data_name[," + (i + 1) + "]))").asInt();
                    missingratio[i] = (double) missingnum[i] / (double) totalrow;
                }
            } else {
                for (int i = 0; i < colnames.length; i++) {
                    missingnum[i] = 0;
                    missingratio[i] = 0.00;
                }
            }
            //数据集各字段基本信息
            for (int i = 0; i < colnames.length; i++) {
                FileDatasetDetailBean fddb = new FileDatasetDetailBean();
                fddb.setColname(colnames[i]);
                fddb.setColtype(coltypes[i].equals("S") ? "字符型" : "数值型");
                fddb.setMissingnum(missingnum[i]);
                fddb.setMissingratio(df.format(missingratio[i] * 100) + "%");
                //fddb.setMissingratio(Double.toString(missingratio[i]));
                fddBeans.add(fddb);
            }

        } else if (filedatasize >= 4 && filedatasize <= 500) {
            if (!missing.equals("无缺失值")) {
                if (fd.getFiletype().equals("txt")) {
                    c.eval("data_name<-read.table.ffdf(file='" + filePath + "',header=" + hasheadline + ",sep='" + separator + "',first.rows=100,next.rows=5000,na.strings='" + missing + "')");
                } else if (fd.getFiletype().equals("csv")) {
                    c.eval("data_name<-read.csv.ffdf(file='" + filePath + "',header=" + hasheadline + ",sep='" + separator + "',first.rows=100,next.rows=5000,na.strings='" + missing + "')");
                }
            } else {
                if (fd.getFiletype().equals("txt")) {
                    c.eval("data_name<-read.table.ffdf(file='" + filePath + "',header=" + hasheadline + ",sep='" + separator + "',first.rows=100,next.rows=5000,na.strings='')");
                } else if (fd.getFiletype().equals("csv")) {
                    c.eval("data_name<-read.csv.ffdf(file='" + filePath + "',header=" + hasheadline + ",sep='" + separator + "',first.rows=100,next.rows=5000,na.strings='')");
                }
            }

            c.eval("{rcolname<-names(data_name);dim(rcolname)<-c(length(names(data_name)))}");
            String colnames[] = c.eval("rcolname").asStringArray();
            datacolnames = new String[colnames.length + 1];
            for (int i = 0; i <= colnames.length; i++) {
                if (i == 0) {
                    datacolnames[i] = "序号";
                } else {
                    datacolnames[i] = colnames[i - 1];
                }
            }
            Map<String, Object> session = ActionContext.getContext().getSession();
            session.remove("colnames");
            session.put("colnames", colnames);
            String coltypes[] = ToolsFactory.getColType(filePath, hasheadline, separator, missing, colnames.length);
            session.remove("coltypes");
            session.put("coltypes", coltypes);
            int missingnum[] = new int[colnames.length];
            double missingratio[] = new double[colnames.length];
            totalrow = c.eval("length(data_name[,1])").asInt();
            DecimalFormat df = new DecimalFormat("##.##");

            if (!missing.equals("无缺失值")) {
                for (int i = 0; i < colnames.length; i++) {
                    //c.eval("data_name[,"+(i+1)+"][data_name[,"+(i+1)+"]=='"+missing+"']=NA");
                    missingnum[i] = c.eval("sum(is.na(data_name[," + (i + 1) + "]))").asInt();
                    missingratio[i] = (double) missingnum[i] / (double) totalrow;
                }
            } else {
                for (int i = 0; i < colnames.length; i++) {
                    missingnum[i] = 0;
                    missingratio[i] = 0.00;
                }
            }
            for (int i = 0; i < colnames.length; i++) {
                FileDatasetDetailBean fddb = new FileDatasetDetailBean();
                fddb.setColname(colnames[i]);
                fddb.setColtype(coltypes[i].equals("S") ? "字符型" : "数值型");
                fddb.setMissingnum(missingnum[i]);
                fddb.setMissingratio(df.format(missingratio[i] * 100) + "%");
                //fddb.setMissingratio(Double.toString(missingratio[i]));
                fddBeans.add(fddb);
            }
        }
        return SUCCESS;
    }


    public String readLinkFile() {
        HttpServletRequest request = ServletActionContext.getRequest();
        Filedataset fd = dsservice.getById(sid);
        separator = fd.getSeparate();
        hasheadline = fd.getHasheadline();
        missing = fd.getMissing();
        filedatasize = Double.parseDouble(fd.getFilesize());
        String filePath = (request.getRealPath("/datasets") + "\\" + fd.getFilepath()).replace("\\", "/");
        StaticData sd = StaticData.getInstance();
        sd.setAr();
        Rengine c = sd.re;
        c.eval("rm(list=ls()");
        if (filedatasize < 4) {
            c.eval("data_link<-read.table('" + filePath + "',header=" + hasheadline + ",sep='" + separator + "')");
            c.eval("{rcolname<-names(data_link);dim(rcolname)<-c(length(names(data_link)))}");
            String colnames[] = c.eval("rcolname").asStringArray();
            datacolnames = new String[colnames.length + 1];
            for (int i = 0; i <= colnames.length; i++) {
                if (i == 0) {
                    datacolnames[i] = "序号";
                } else {
                    datacolnames[i] = colnames[i - 1];
                }
            }
            Map<String, Object> session = ActionContext.getContext().getSession();
            session.remove("colnames");
            session.put("colnames", colnames);
            String coltypes[] = ToolsFactory.getColType(filePath, hasheadline, separator, missing, colnames.length);
            session.remove("coltypes");
            session.put("coltypes", coltypes);
            int missingnum[] = new int[colnames.length];
            double missingratio[] = new double[colnames.length];
            totalrow = c.eval("length(data_link[,1])").asInt();
            DecimalFormat df = new DecimalFormat("##.##");

            if (!missing.equals("无缺失值")) {
                for (int i = 0; i < colnames.length; i++) {
                    c.eval("data_link[," + (i + 1) + "][data_link[," + (i + 1) + "]=='" + missing + "']=NA");
                    missingnum[i] = c.eval("sum(is.na(data_link[," + (i + 1) + "]))").asInt();
                    missingratio[i] = (double) missingnum[i] / (double) totalrow;
                }
            } else {
                for (int i = 0; i < colnames.length; i++) {
                    missingnum[i] = 0;
                    missingratio[i] = 0.00;
                }
            }
            //数据集各字段基本信息
            for (int i = 0; i < colnames.length; i++) {
                FileDatasetDetailBean fddb = new FileDatasetDetailBean();
                fddb.setColname(colnames[i]);
                fddb.setColtype(coltypes[i].equals("S") ? "字符型" : "数值型");
                fddb.setMissingnum(missingnum[i]);
                fddb.setMissingratio(df.format(missingratio[i] * 100) + "%");
                //fddb.setMissingratio(Double.toString(missingratio[i]));
                fddBeans.add(fddb);
            }

        } else if (filedatasize >= 4 && filedatasize <= 500) {
            if (!missing.equals("无缺失值")) {
                if (fd.getFiletype().equals("txt")) {
                    c.eval("data_link<-read.table.ffdf(file='" + filePath + "',header=" + hasheadline + ",sep='" + separator + "',first.rows=100,next.rows=5000,na.strings='" + missing + "')");
                } else if (fd.getFiletype().equals("csv")) {
                    c.eval("data_link<-read.csv.ffdf(file='" + filePath + "',header=" + hasheadline + ",sep='" + separator + "',first.rows=100,next.rows=5000,na.strings='" + missing + "')");
                }
            } else {
                if (fd.getFiletype().equals("txt")) {
                    c.eval("data_link<-read.table.ffdf(file='" + filePath + "',header=" + hasheadline + ",sep='" + separator + "',first.rows=100,next.rows=5000,na.strings='')");
                } else if (fd.getFiletype().equals("csv")) {
                    c.eval("data_link<-read.csv.ffdf(file='" + filePath + "',header=" + hasheadline + ",sep='" + separator + "',first.rows=100,next.rows=5000,na.strings='')");
                }
            }

            c.eval("{rcolname<-names(data_link);dim(rcolname)<-c(length(names(data_link)))}");
            String colnames[] = c.eval("rcolname").asStringArray();
            datacolnames = new String[colnames.length + 1];
            for (int i = 0; i <= colnames.length; i++) {
                if (i == 0) {
                    datacolnames[i] = "序号";
                } else {
                    datacolnames[i] = colnames[i - 1];
                }
            }
            Map<String, Object> session = ActionContext.getContext().getSession();
            session.remove("colnames");
            session.put("colnames", colnames);
            String coltypes[] = ToolsFactory.getColType(filePath, hasheadline, separator, missing, colnames.length);
            session.remove("coltypes");
            session.put("coltypes", coltypes);
            int missingnum[] = new int[colnames.length];
            double missingratio[] = new double[colnames.length];
            totalrow = c.eval("length(data_link[,1])").asInt();
            DecimalFormat df = new DecimalFormat("##.##");

            if (!missing.equals("无缺失值")) {
                for (int i = 0; i < colnames.length; i++) {
                    //c.eval("data_link[,"+(i+1)+"][data_link[,"+(i+1)+"]=='"+missing+"']=NA");
                    missingnum[i] = c.eval("sum(is.na(data_link[," + (i + 1) + "]))").asInt();
                    missingratio[i] = (double) missingnum[i] / (double) totalrow;
                }
            } else {
                for (int i = 0; i < colnames.length; i++) {
                    missingnum[i] = 0;
                    missingratio[i] = 0.00;
                }
            }
            for (int i = 0; i < colnames.length; i++) {
                FileDatasetDetailBean fddb = new FileDatasetDetailBean();
                fddb.setColname(colnames[i]);
                fddb.setColtype(coltypes[i].equals("S") ? "字符型" : "数值型");
                fddb.setMissingnum(missingnum[i]);
                fddb.setMissingratio(df.format(missingratio[i] * 100) + "%");
                //fddb.setMissingratio(Double.toString(missingratio[i]));
                fddBeans.add(fddb);
            }
        }
        return SUCCESS;
    }

    public String network() {
        return "network";
    }

    public String uploadHeadImg() {
        try {
            FileOutputStream fos = new FileOutputStream(getSavePath() + "\\" + getHeadname() + getUploadFileName().substring(getUploadFileName().lastIndexOf(".")));
            FileInputStream fis = new FileInputStream(getUpload());
            byte[] buffer = new byte[1024];
            int len = 0;
            try {
                while ((len = fis.read(buffer)) > 0) {
                    fos.write(buffer, 0, len);
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        return SUCCESS;
    }


    public String getSid() {
        return sid;
    }


    public void setSid(String sid) {
        this.sid = sid;
    }


    public String getSeparator() {
        return separator;
    }


    public void setSeparator(String separator) {
        this.separator = separator;
    }


    public String getHasheadline() {
        return hasheadline;
    }


    public void setHasheadline(String hasheadline) {
        this.hasheadline = hasheadline;
    }


    public String getMissing() {
        return missing;
    }


    public void setMissing(String missing) {
        this.missing = missing;
    }


    public double getFiledatasize() {
        return filedatasize;
    }


    public void setFiledatasize(double filedatasize) {
        this.filedatasize = filedatasize;
    }


    public int getTotalrow() {
        return totalrow;
    }


    public void setTotalrow(int totalrow) {
        this.totalrow = totalrow;
    }


    public List<FileDatasetDetailBean> getFddBeans() {
        return fddBeans;
    }


    public void setFddBeans(List<FileDatasetDetailBean> fddBeans) {
        this.fddBeans = fddBeans;
    }


    public String[] getDatacolnames() {
        return datacolnames;
    }


    public void setDatacolnames(String[] datacolnames) {
        this.datacolnames = datacolnames;
    }


    public String getIds1() {
        return ids1;
    }


    public void setIds1(String ids1) {
        this.ids1 = ids1;
    }


    public String getIds2() {
        return ids2;
    }


    public void setIds2(String ids2) {
        this.ids2 = ids2;
    }


    public File getUpload() {
        return upload;
    }


    public void setUpload(File upload) {
        this.upload = upload;
    }


    public String getUploadFileType() {
        return uploadFileType;
    }


    public void setUploadFileType(String uploadFileType) {
        this.uploadFileType = uploadFileType;
    }


    public String getUploadFileName() {
        return uploadFileName;
    }


    public void setUploadFileName(String uploadFileName) {
        this.uploadFileName = uploadFileName;
    }

    @SuppressWarnings("deprecation")
    public String getSavePath() {
        return ServletActionContext.getRequest().getRealPath(savePath);
    }

    public void setSavePath(String savePath) {
        this.savePath = savePath;
    }


    public String getHeadname() {
        return headname;
    }


    public void setHeadname(String headname) {
        this.headname = headname;
    }

}


