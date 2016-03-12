package com.dv.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.struts2.ServletActionContext;
import org.rosuda.JRI.Rengine;

import com.dv.action.base.DataMiningBaseAction;
import com.dv.util.Export_excelBean;
import com.dv.util.Export_imageBean;
import com.dv.util.StaticData;
import com.opensymphony.xwork2.ActionContext;


@SuppressWarnings("serial")
public class Classification extends DataMiningBaseAction {
    private String outputline;
    private String ids;
    private String search;//svm
    private String vmethod;//svm
    private String C;//svm
    private String epsilon;//svm
    private String metric;//svm

    private double[][] tempArrays = null;
    private int totalrow;
    private String method;

    private double acc;

    private String imagename;
    private String[] pnames = null;

    private List<Export_excelBean> excellist = null;
    private List<Export_imageBean> imagelist = null;

    private String savaPath;

    @SuppressWarnings("deprecation")
    public String getSavaPath() {
        return ServletActionContext.getRequest().getRealPath(savaPath);
    }

    public void setSavaPath(String savaPath) {
        this.savaPath = savaPath;
    }

    public String Dtree() {
        String imagepath = getSavaPath().replace("\\", "//") + "//";
        System.out.println(imagepath);
        imagename = "result" + new Date().getTime() + ".png";
        Map<String, Object> session = ActionContext.getContext().getSession();
        String colnames[] = (String[]) session.get("colnames");
        String colids[] = ids.split(",");
        String inputline = "";
        for (int i = 0; i < colids.length; i++) {
            inputline += colnames[Integer.parseInt(colids[i]) - 1] + "+";
        }
        inputline = inputline.substring(0, inputline.length() - 1);
        StaticData sd = StaticData.getInstance();
        sd.setAr();
        Rengine c = sd.re;
        System.out.println(outputline);
        System.out.println(inputline);
        c.eval("{dtreemodel<-fit(" + outputline + "~" + inputline + ",data,model='dt');" +
                "dtreep<-predict(dtreemodel,data);" +
                "setwd('" + imagepath + "');" +
                "png(file='" + imagename + "',bg='transparent');" +
                "mgraph(data$" + outputline + ",dtreep,graph='ROC',main='ROC',baseline=TRUE,leg='Versicolor',Grid=10);" +
                "dev.off();" +
                "}");
        acc = c.eval("acc<-mmetric(data$" + outputline + ",dtreep,'ACC')").asDouble();
        double[][] dtreepredict = c.eval("dtreep").asDoubleMatrix();
        pnames = c.eval("names(data.frame(dtreep))").asStringArray();
        System.out.println(pnames[0]);
        int length = dtreepredict.length > 20 ? 20 : dtreepredict.length;
        tempArrays = new double[20][pnames.length];
        for (int i = 0; i < length; i++) {
            for (int j = 0; j < dtreepredict[0].length; j++) {
                tempArrays[i][j] = dtreepredict[i][j];
            }
        }
        totalrow = dtreepredict.length;

        excellist = new ArrayList<Export_excelBean>();
        Export_excelBean ieb = new Export_excelBean();
        ieb.setArrayname("概率预测");
        ieb.setArray_D(dtreepredict);
        ieb.setArraytype("D");
        excellist.add(ieb);

        imagelist = new ArrayList<Export_imageBean>();
        Export_imageBean exportimage = new Export_imageBean();
        exportimage.setImageinfo("图1");
        exportimage.setImagepath(imagepath + imagename);
        imagelist.add(exportimage);

        session.remove("excellist");
        session.put("excellist", excellist);
        session.remove("imagelist");
        session.put("imagelist", imagelist);

        c.eval("rm('dtreemodel')");
        c.eval("rm('dtreep')");
        return "dtree";
    }

    public String getOutputline() {
        return outputline;
    }

    public void setOutputline(String outputline) {
        this.outputline = outputline;
    }

    public String getIds() {
        return ids;
    }

    public void setIds(String ids) {
        this.ids = ids;
    }

    public String getSearch() {
        return search;
    }

    public void setSearch(String search) {
        this.search = search;
    }

    public String getVmethod() {
        return vmethod;
    }

    public void setVmethod(String vmethod) {
        this.vmethod = vmethod;
    }

    public String getC() {
        return C;
    }

    public void setC(String c) {
        C = c;
    }

    public String getEpsilon() {
        return epsilon;
    }

    public void setEpsilon(String epsilon) {
        this.epsilon = epsilon;
    }

    public String getMetric() {
        return metric;
    }

    public void setMetric(String metric) {
        this.metric = metric;
    }

    public double[][] getTempArrays() {
        return tempArrays;
    }

    public void setTempArrays(double[][] tempArrays) {
        this.tempArrays = tempArrays;
    }

    public int getTotalrow() {
        return totalrow;
    }

    public void setTotalrow(int totalrow) {
        this.totalrow = totalrow;
    }

    public String getImagename() {
        return imagename;
    }

    public void setImagename(String imagename) {
        this.imagename = imagename;
    }

    public String[] getPnames() {
        return pnames;
    }

    public void setPnames(String[] pnames) {
        this.pnames = pnames;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public double getAcc() {
        return acc;
    }

    public void setAcc(double acc) {
        this.acc = acc;
    }

}
