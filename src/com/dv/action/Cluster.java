package com.dv.action;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
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
public class Cluster extends DataMiningBaseAction {
    private String ids;
    private String center;//kmeans,clara,pam
    private String itermax;//kmeans
    private String nstart;//kmeans
    private String algorithm;//kmeans
    private String savaPath;
    private String imagename;
    private String imagename1;

    private List<Export_excelBean> excellist = null;
    private List<Export_imageBean> imagelist = null;

    private List<Map<String, String>> matrixdata;//散点矩阵图数据
    private String[][] datashow;//平行坐标图数据

    private int[] clustertype = null;//每一类标识
    private int clustersize[] = null;//每类数目
    private String[] dimensions = null;
    private String[] typename = null;
    private String sample[] = null;
    private double centers[][] = null;
    private double medoids[][] = null;
    private double clusinfo[][] = null;


    @SuppressWarnings("deprecation")
    public String getSavaPath() {
        return ServletActionContext.getRequest().getRealPath(savaPath);
    }

    public void setSavaPath(String savaPath) {
        this.savaPath = savaPath;
    }

    public String Kmeans() {
        String imagepath = getSavaPath().replace("\\", "//") + "//";
        System.out.println(imagepath);
        imagename = "result" + new Date().getTime() + ".png";
        imagename1 = "result1" + new Date().getTime() + ".png";
        StaticData sd = StaticData.getInstance();
        sd.setAr();
        Rengine c = sd.re;
        Map<String, Object> session = ActionContext.getContext().getSession();
        //c.eval("kc<-kmeans(x=na.omit(data[,c("+ids+")]),centers="+center+",iter.max="+itermax+",nstart="+nstart+",algorithm=c('"+algorithm+"'));");
        c.eval("kc<-kmeans(x=na.omit(data[,c(" + ids + ")]),centers=" + center + ",iter.max=" + itermax + ");");

        clustertype = c.eval("kc$cluster").asIntArray();

        String idarray[] = ids.split(",");
        String colnames[] = (String[]) session.get("colnames");
        int totalrow = c.eval("length(data[,1])").asInt();
        dimensions = new String[idarray.length];
        for (int i = 0; i < idarray.length; i++) {
            dimensions[i] = colnames[Integer.parseInt(idarray[i]) - 1];
        }
        typename = new String[Integer.parseInt(center)];
        for (int i = 1; i <= Integer.parseInt(center); i++) {
            typename[i - 1] = "聚类簇" + i;
        }
        datashow = new String[totalrow + 1][idarray.length + 1];
        for (int i = 0; i < idarray.length + 1; i++) {
            if (i == idarray.length) {
                datashow[0][i] = "clustertype";
            } else {
                datashow[0][i] = colnames[Integer.parseInt(idarray[i]) - 1];
            }
        }

        //平行坐标图数据
        for (int i = 1; i <= totalrow; i++) {
            for (int j = 0; j < idarray.length + 1; j++) {
                if (j == idarray.length) {
                    datashow[i][j] = clustertype[i - 1] + "";
                } else {
                    datashow[i][j] = c.eval("as.character(data[" + i + "," + idarray[j] + "])").asString();
                }
            }
        }

        //散点矩阵图数据
        matrixdata = new ArrayList<Map<String, String>>();
        for (int i = 1; i <= totalrow; i++) {
            Map<String, String> maptemp = new HashMap<String, String>();
            for (int j = 0; j < idarray.length + 1; j++) {
                if (j == idarray.length) {
                    maptemp.put("clustertype", clustertype[i - 1] + "");
                } else {
                    maptemp.put(colnames[Integer.parseInt(idarray[j]) - 1], c.eval("as.character(data[" + i + "," + idarray[j] + "])").asString());
                }
            }
            matrixdata.add(maptemp);
        }

        DecimalFormat df = new DecimalFormat(".##");
        c.eval("{temp<-kc$size;dim(temp)<-c(length(kc$size))}");
        clustersize = c.eval("temp").asIntArray();
        for (int i = 0; i < clustersize.length; i++) {
            System.out.println(clustersize[i]);
        }
        //最佳中心点
        centers = c.eval("kc$centers").asDoubleMatrix();
        for (int i = 0; i < centers.length; i++) {
            for (int j = 0; j < centers[0].length; j++) {
                centers[i][j] = Double.parseDouble(df.format(centers[i][j]));
                System.out.print(centers[i][j] + " ");
            }
            System.out.println();
        }
        excellist = new ArrayList<Export_excelBean>();
        Export_excelBean ieb = new Export_excelBean();
        ieb.setArrayname("每簇聚类数目");
        ieb.setArray_E(clustersize);
        ieb.setArraytype("E");
        excellist.add(ieb);
        Export_excelBean ieb1 = new Export_excelBean();
        ieb1.setArrayname("最佳中心点");
        ieb1.setArray_D(centers);
        ieb1.setArraytype("D");
        excellist.add(ieb1);

        imagelist = new ArrayList<Export_imageBean>();
        Export_imageBean exportimage = new Export_imageBean();
        exportimage.setImageinfo("图1");
        exportimage.setImagepath(imagepath + imagename);
        imagelist.add(exportimage);

        session.remove("excellist");
        session.put("excellist", excellist);
        session.remove("imagelist");
        session.put("imagelist", imagelist);
        c.eval("rm('kc')");
        return "kmeans";
    }


    public String getIds() {
        return ids;
    }

    public void setIds(String ids) {
        this.ids = ids;
    }

    public String getCenter() {
        return center;
    }

    public void setCenter(String center) {
        this.center = center;
    }

    public String getItermax() {
        return itermax;
    }

    public void setItermax(String itermax) {
        this.itermax = itermax;
    }

    public String getNstart() {
        return nstart;
    }

    public void setNstart(String nstart) {
        this.nstart = nstart;
    }

    public String getAlgorithm() {
        return algorithm;
    }

    public void setAlgorithm(String algorithm) {
        this.algorithm = algorithm;
    }

    public String getImagename() {
        return imagename;
    }

    public void setImagename(String imagename) {
        this.imagename = imagename;
    }

    public String[] getSample() {
        return sample;
    }

    public void setSample(String[] sample) {
        this.sample = sample;
    }

    public double[][] getCenters() {
        return centers;
    }

    public void setCenters(double[][] centers) {
        this.centers = centers;
    }

    public double[][] getMedoids() {
        return medoids;
    }

    public void setMedoids(double[][] medoids) {
        this.medoids = medoids;
    }

    public double[][] getClusinfo() {
        return clusinfo;
    }

    public void setClusinfo(double[][] clusinfo) {
        this.clusinfo = clusinfo;
    }

    public String getImagename1() {
        return imagename1;
    }

    public void setImagename1(String imagename1) {
        this.imagename1 = imagename1;
    }

    public int[] getClustersize() {
        return clustersize;
    }

    public void setClustersize(int[] clustersize) {
        this.clustersize = clustersize;
    }

    public String[][] getDatashow() {
        return datashow;
    }

    public void setDatashow(String[][] datashow) {
        this.datashow = datashow;
    }

    public int[] getClustertype() {
        return clustertype;
    }

    public void setClustertype(int[] clustertype) {
        this.clustertype = clustertype;
    }

    public String[] getDimensions() {
        return dimensions;
    }

    public void setDimensions(String[] dimensions) {
        this.dimensions = dimensions;
    }

    public String[] getTypename() {
        return typename;
    }

    public void setTypename(String[] typename) {
        this.typename = typename;
    }

    public List<Map<String, String>> getMatrixdata() {
        return matrixdata;
    }

    public void setMatrixdata(List<Map<String, String>> matrixdata) {
        this.matrixdata = matrixdata;
    }


}
