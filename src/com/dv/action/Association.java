package com.dv.action;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.struts2.ServletActionContext;
import org.rosuda.JRI.RFactor;
import org.rosuda.JRI.Rengine;

import com.dv.action.base.DataMiningBaseAction;
import com.dv.util.Export_excelBean;
import com.dv.util.Export_imageBean;
import com.dv.util.StaticData;
import com.opensymphony.xwork2.ActionContext;

@SuppressWarnings("serial")
public class Association extends DataMiningBaseAction {
    private String ids;
    private String lift;
    private String conf;
    private String matrixcols;//二维数组的各个属性名
    private String colsnum;//二维数组的各个属性名拥有的数量
    private String savaPath;
    private String imagename;

    private List<Export_excelBean> excellist = null;
    private List<Export_imageBean> imagelist = null;

    private String[] allrules = null;
    private double aprinfo[][] = null;

    @SuppressWarnings("deprecation")
    public String getSavaPath() {
        return ServletActionContext.getRequest().getRealPath(savaPath);
    }

    public void setSavaPath(String savaPath) {
        this.savaPath = savaPath;
    }

    public String Apriori() {
        String imagepath = getSavaPath().replace("\\", "//") + "//";
        imagename = "result" + new Date().getTime() + ".png";
        StaticData sd = StaticData.getInstance();
        sd.setAr();
        Rengine c = sd.re;
        Map<String, Object> session = ActionContext.getContext().getSession();
        c.eval("rules<-apriori(data[,c(" + ids + ")],parameter = list(minlen=2,support = " + lift + ",confidence = " + conf + "))");
        c.eval("{" +
                "setwd('" + imagepath + "');" +
                "png(file='" + imagename + "',bg='transparent');" +
                "plot(rules, method='graph', control=list(type='items'));" +
                "dev.off();" +
                "}");
        c.eval("allrules<-as(rules,'data.frame')");
        String colnames[] = (String[]) session.get("colnames");
        matrixcols = "";
        colsnum = "";
        String[] namestemp;
        int[] numtemp;
        for (int i = 0; i < colnames.length; i++) {
            namestemp = c.eval("names(table(data[," + (i + 1) + "]))").asStringArray();
            numtemp = c.eval("table(data[," + (i + 1) + "])").asIntArray();
            for (int j = 0; j < numtemp.length; j++) {
                matrixcols += namestemp[j] + "&";
                colsnum += numtemp[j] + "&";
            }
        }
        matrixcols = matrixcols.substring(0, matrixcols.length() - 1);
        colsnum = colsnum.substring(0, colsnum.length() - 1);
        RFactor rf = c.eval("allrules[,1]").asFactor();
        allrules = new String[rf.size()];
        for (int i = 0; i < rf.size(); i++) {
            allrules[i] = rf.at(i);
        }
        aprinfo = c.eval("as.matrix(allrules[,c(2,3,4)])").asDoubleMatrix();
        c.eval("rm('rules')");
        c.eval("rm('allrules')");
        return "apriori";
    }


    public String getIds() {
        return ids;
    }

    public void setIds(String ids) {
        this.ids = ids;
    }

    public String getImagename() {
        return imagename;
    }

    public void setImagename(String imagename) {
        this.imagename = imagename;
    }

    public String[] getAllrules() {
        return allrules;
    }

    public void setAllrules(String[] allrules) {
        this.allrules = allrules;
    }

    public double[][] getAprinfo() {
        return aprinfo;
    }

    public void setAprinfo(double[][] aprinfo) {
        this.aprinfo = aprinfo;
    }

    public String getLift() {
        return lift;
    }

    public void setLift(String lift) {
        this.lift = lift;
    }

    public String getConf() {
        return conf;
    }

    public void setConf(String conf) {
        this.conf = conf;
    }

    public String getMatrixcols() {
        return matrixcols;
    }

    public void setMatrixcols(String matrixcols) {
        this.matrixcols = matrixcols;
    }

    public String getColsnum() {
        return colsnum;
    }

    public void setColsnum(String colsnum) {
        this.colsnum = colsnum;
    }

}
