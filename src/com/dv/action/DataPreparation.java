package com.dv.action;

import com.dv.action.base.DataMiningBaseAction;
import com.dv.util.FileDatasetDetailBean;
import com.dv.util.QuickSort;
import com.dv.util.StaticData;
import com.opensymphony.xwork2.ActionContext;
import org.rosuda.JRI.Rengine;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


@SuppressWarnings("serial")
public class DataPreparation extends DataMiningBaseAction {
    private String ids;
    private String method;

    private int totalrow;
    private List<FileDatasetDetailBean> fddBeans = new ArrayList<FileDatasetDetailBean>();
    private List<double[]> statdata = new ArrayList<double[]>();//条形图、折线图数据
    private List<double[][]> scatterdata = new ArrayList<double[][]>();//散点图、箱线图数据
    private List<double[][]> scatterdata3d = new ArrayList<double[][]>();//散点图3d
    private List<double[][]> outlier = new ArrayList<double[][]>();//箱线图数据异常值
    private List<int[]> varname = new ArrayList<int[]>();//散点图横、纵坐标名称
    private String[] colors;
    private List<String[]> missdata = new ArrayList<String[]>();
    private String missinput;
    private String hasmissing;

    public String updateMissing() {
        StaticData sd = StaticData.getInstance();
        sd.setAr();
        Rengine c = sd.re;
        String rowids[] = ids.substring(0, ids.length() - 1).split(",");
        Map<String, Object> session = ActionContext.getContext().getSession();
        String colnames[] = (String[]) session.get("colnames");
        String coltypes[] = (String[]) session.get("coltypes");
        int missingnum[] = new int[colnames.length];
        double missingratio[] = new double[colnames.length];
        totalrow = c.eval("length(data[,1])").asInt();
        String[] missarray = missinput.split(";");

        for (int i = 0; i < rowids.length; i++) {
            for (int j = 0; j < colnames.length; j++) {
                if (c.eval("is.factor(data[" + rowids[i] + "," + (j + 1) + "])").asBool().equals("FALSE")) {
                    c.eval("data[" + rowids[i] + "," + (j + 1) + "]=" + missarray[i * colnames.length + j] + "");
                } else {
                    c.eval("data[" + rowids[i] + "," + (j + 1) + "]='" + missarray[i * colnames.length + j] + "'");
                }

            }
        }

        DecimalFormat df = new DecimalFormat("##.##");
        for (int i = 0; i < colnames.length; i++) {
            missingnum[i] = c.eval("sum(is.na(data[," + (i + 1) + "]))").asInt();
            missingratio[i] = (double) missingnum[i] / (double) totalrow;
        }
        for (int i = 0; i < colnames.length; i++) {
            FileDatasetDetailBean fddb = new FileDatasetDetailBean();
            fddb.setColname(colnames[i]);
            fddb.setColtype(coltypes[i].equals("S") ? "字符型" : "数值型");
            fddb.setMissingnum(missingnum[i]);
            fddb.setMissingratio(df.format(missingratio[i] * 100) + "%");
            fddBeans.add(fddb);
        }
        return SUCCESS;
    }

    public String delMissing() {
        StaticData sd = StaticData.getInstance();
        sd.setAr();
        Rengine c = sd.re;
        c.eval("data<-data[-c(" + ids.substring(0, ids.length() - 1) + "),]");
        Map<String, Object> session = ActionContext.getContext().getSession();
        String colnames[] = (String[]) session.get("colnames");
        String coltypes[] = (String[]) session.get("coltypes");
        int missingnum[] = new int[colnames.length];
        double missingratio[] = new double[colnames.length];
        totalrow = c.eval("length(data[,1])").asInt();
        DecimalFormat df = new DecimalFormat("##.##");
        for (int i = 0; i < colnames.length; i++) {
            missingnum[i] = c.eval("sum(is.na(data[," + (i + 1) + "]))").asInt();
            missingratio[i] = (double) missingnum[i] / (double) totalrow;
        }


        for (int i = 0; i < colnames.length; i++) {
            FileDatasetDetailBean fddb = new FileDatasetDetailBean();
            fddb.setColname(colnames[i]);
            fddb.setColtype(coltypes[i].equals("S") ? "字符型" : "数值型");
            fddb.setMissingnum(missingnum[i]);
            fddb.setMissingratio(df.format(missingratio[i] * 100) + "%");
            fddBeans.add(fddb);
        }
        return SUCCESS;
    }

    public String showMissing() {
        StaticData sd = StaticData.getInstance();
        sd.setAr();
        Rengine c = sd.re;
        Map<String, Object> session = ActionContext.getContext().getSession();
        String colnames[] = (String[]) session.get("colnames");

        if (c.eval("{data}") != null && colnames != null) {
            totalrow = c.eval("length(data[,1])").asInt();
            for (int i = 0; i < totalrow; i++) {
                for (int j = 0; j < colnames.length; j++) {
                    String temp = c.eval("as.character(data[" + (i + 1) + "," + (j + 1) + "])").asString();
                    if (temp == null) {
                        String misstemp[] = new String[colnames.length + 1];
                        for (int k = 0; k < colnames.length + 1; k++) {
                            if (k == 0) {
                                misstemp[k] = (i + 1) + "";//第一个放第几行有缺失值
                            } else {
                                misstemp[k] = c.eval("as.character(data[" + (i + 1) + "," + k + "])").asString();
                            }
                        }
                        missdata.add(misstemp);
                        break;
                    }
                }
            }
        }

        return SUCCESS;
    }

    public String judgeMissing() {
        hasmissing = "false";
        StaticData sd = StaticData.getInstance();
        sd.setAr();
        Rengine c = sd.re;
        Map<String, Object> session = ActionContext.getContext().getSession();
        String colnames[] = (String[]) session.get("colnames");

        if (c.eval("{data}") != null && colnames != null) {
            totalrow = c.eval("length(data[,1])").asInt();
            for (int i = 0; i < totalrow; i++) {
                for (int j = 0; j < colnames.length; j++) {
                    String temp = c.eval("as.character(data[" + (i + 1) + "," + (j + 1) + "])").asString();
                    if (temp == null) {
                        hasmissing = "true";
                        String misstemp[] = new String[colnames.length + 1];
                        for (int k = 0; k < colnames.length + 1; k++) {
                            if (k == 0) {
                                misstemp[k] = (i + 1) + "";//第一个放第几行有缺失值
                            } else {
                                misstemp[k] = c.eval("as.character(data[" + (i + 1) + "," + k + "])").asString();
                            }
                        }
                        missdata.add(misstemp);
                        break;
                    }
                }
            }
        }
        return SUCCESS;
    }

    public String dealMissing() {
        StaticData sd = StaticData.getInstance();
        sd.setAr();
        Rengine c = sd.re;
        String colids[] = ids.split(",");

        for (String colid : colids) {
            switch (method) {
                case "prior":
                    c.eval("data[," + colid + "]<-na.locf(data[," + colid + "],fromLast=F)");
                    break;
                case "mean":
                    c.eval("{data[," + colid + "]<-as.double(as.character(data[," + colid + "]));" +
                            "data[," + colid + "][which(is.na(data[," + colid + "]))]<-mean(data[," + colid + "][-which(is.na(data[," + colid + "]))]);" +
                            "}");
                    break;
                case "spline":
                    c.eval("{data[," + colid + "]<-as.double(as.character(data[," + colid + "]));" +
                            "data[," + colid + "]<-na.spline(data[," + colid + "],na.rm=TRUE);" +
                            "}");
                    break;
            }
        }

        Map<String, Object> session = ActionContext.getContext().getSession();
        String colnames[] = (String[]) session.get("colnames");
        String coltypes[] = (String[]) session.get("coltypes");
        int missingnum[] = new int[colnames.length];
        double missingratio[] = new double[colnames.length];
        totalrow = c.eval("length(data[,1])").asInt();
        DecimalFormat df = new DecimalFormat("##.##");

        for (int i = 0; i < colnames.length; i++) {
            missingnum[i] = c.eval("sum(is.na(data[," + (i + 1) + "]))").asInt();
            missingratio[i] = (double) missingnum[i] / (double) totalrow;
        }


        for (int i = 0; i < colnames.length; i++) {
            FileDatasetDetailBean fddb = new FileDatasetDetailBean();
            fddb.setColname(colnames[i]);
            fddb.setColtype(coltypes[i].equals("S") ? "字符型" : "数值型");
            fddb.setMissingnum(missingnum[i]);
            fddb.setMissingratio(df.format(missingratio[i] * 100) + "%");
            fddBeans.add(fddb);
        }
        return "success";
    }

    public String statInfo() {
        StaticData sd = StaticData.getInstance();
        sd.setAr();
        Rengine c = sd.re;
        String colids[] = ids.split(",");
        colors = new String[]{"#FF0000", "#EB4310", "#F6941D", "#FFFF00", "#CDD541",
                "#99CC33", "#3F9337", "#219167", "#24998D", "#1F9BAA",
                "#A1488E", "#C71585", "#BD2158", "#CCFFFF", "#FFCCCC",
                "#33FF99", "#FF95CA", "#00FFFF", "#FF5809", "#1AFD9C"};
        switch (method) {
            case "bar":
                for (String colid : colids) {
                    statdata.add(c.eval("data[," + colid + "]").asDoubleArray());
                }
                break;
            case "breakline":
                for (int i = 0; i < colids.length; i++) {
                    statdata.add(c.eval("data[," + colids[i] + "]").asDoubleArray());
                }
                break;
            case "scatter":
                for (int i = 0; i < colids.length; i++) {
                    for (int j = 0; j < colids.length; j++) {
                        if (i != j) {
                            int[] temp = new int[2];
                            temp[0] = Integer.parseInt(colids[i]);
                            temp[1] = Integer.parseInt(colids[j]);
                            varname.add(temp);
                            scatterdata.add(c.eval("as.matrix(data[,c(" + colids[i] + "," + colids[j] + ")])").asDoubleMatrix());
                        }
                    }
                }
                break;
            case "scatter3d":
                for (int i = 0; i < colids.length; i++) {
                    for (int j = 0; j < colids.length; j++) {
                        for (int k = 0; k < colids.length; k++) {
                            if (i != j && i != k && j != k && i < j && j < k) {
                                int[] temp = new int[3];
                                temp[0] = Integer.parseInt(colids[i]);
                                temp[1] = Integer.parseInt(colids[j]);
                                temp[2] = Integer.parseInt(colids[k]);
                                varname.add(temp);
                                scatterdata3d.add(c.eval("as.matrix(data[,c(" + colids[i] + "," + colids[j] + "," + colids[k] + ")])").asDoubleMatrix());
                            }
                        }

                    }
                }
                break;
            case "box":
                double fivearray[];
                double outarray[];
                double fivenum[][] = new double[colids.length][5];
                for (int i = 0; i < colids.length; i++) {
                    fivearray = c.eval("fivenum(data[," + colids[i] + "])").asDoubleArray();
                    outarray = c.eval("boxplot.stats(data[," + colids[i] + "])$out").asDoubleArray();
                    fivenum[i] = fivearray;
                    System.out.println(outarray.length);
                    if (outarray.length > 0) {
                        double outpoint[][] = new double[outarray.length][2];
                        for (int j = 0; j < outarray.length; j++) {
                            outpoint[j] = new double[]{i, outarray[j]};
                        }
                        outlier.add(outpoint);
                    }
                }

                scatterdata.add(fivenum);
                break;
        }

        return SUCCESS;
    }

    public String resetBar() {
        StaticData sd = StaticData.getInstance();
        sd.setAr();
        Rengine c = sd.re;
        String colids[] = ids.split(",");

        for (String colid : colids) {
            statdata.add(c.eval("data[," + colid + "]").asDoubleArray());
        }
        return SUCCESS;
    }

    public String sortHighToLow() {
        StaticData sd = StaticData.getInstance();
        sd.setAr();
        Rengine c = sd.re;
        String colids[] = ids.split(",");
        double[] strVoid = null;

        for (String colid : colids) {
            strVoid = c.eval("data[," + colid + "]").asDoubleArray();
            statdata.add(new QuickSort().quickSort(strVoid, 0, strVoid.length - 1));
        }
        return SUCCESS;
    }

    public String sortLowToHigh() {
        StaticData sd = StaticData.getInstance();
        sd.setAr();
        Rengine c = sd.re;
        String colids[] = ids.split(",");
        double[] strVoid = null;
        for (int i = 0; i < colids.length; i++) {
            strVoid = c.eval("data[," + colids[i] + "]").asDoubleArray();
            statdata.add(new QuickSort().quickSort1(strVoid, 0, strVoid.length - 1));
        }
        return SUCCESS;
    }


    public String getIds() {
        return ids;
    }

    public void setIds(String ids) {
        this.ids = ids;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
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

    public List<double[]> getStatdata() {
        return statdata;
    }

    public void setStatdata(List<double[]> statdata) {
        this.statdata = statdata;
    }

    public List<double[][]> getScatterdata() {
        return scatterdata;
    }

    public void setScatterdata(List<double[][]> scatterdata) {
        this.scatterdata = scatterdata;
    }

    public List<int[]> getVarname() {
        return varname;
    }

    public void setVarname(List<int[]> varname) {
        this.varname = varname;
    }

    public List<double[][]> getOutlier() {
        return outlier;
    }

    public void setOutlier(List<double[][]> outlier) {
        this.outlier = outlier;
    }

    public String[] getColors() {
        return colors;
    }

    public void setColors(String[] colors) {
        this.colors = colors;
    }

    public List<String[]> getMissdata() {
        return missdata;
    }

    public void setMissdata(List<String[]> missdata) {
        this.missdata = missdata;
    }

    public String getMissinput() {
        return missinput;
    }

    public void setMissinput(String missinput) {
        this.missinput = missinput;
    }

    public String getHasmissing() {
        return hasmissing;
    }

    public void setHasmissing(String hasmissing) {
        this.hasmissing = hasmissing;
    }

    public List<double[][]> getScatterdata3d() {
        return scatterdata3d;
    }

    public void setScatterdata3d(List<double[][]> scatterdata3d) {
        this.scatterdata3d = scatterdata3d;
    }


}
