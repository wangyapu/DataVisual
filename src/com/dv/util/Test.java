package com.dv.util;

import org.rosuda.JRI.Rengine;
import org.rosuda.REngine.Rserve.RserveException;

public class Test {

    /**
     * @param args
     * @throws RserveException
     */
    public static void main(String[] args) throws RserveException {
        // TODO Auto-generated method stub
        StaticData sd = StaticData.getInstance();
        sd.setAr();
        Rengine c = sd.re;
        //c.eval("d<-read.table('F:/iris.txt',header=F,sep=',')");
        //c.eval("library(rJava)");
        //c.eval("d<-read.table('F:/Rstudy/iris.txt',header=F,sep=',')");
        //System.out.println(c.eval("boxplot.stats(d[,3])$out").asDoubleArray().length);
        //System.out.println(c.eval("fivenum(d[,1])").asDoubleArray()[4]);
        //System.out.println(c.eval("as.matrix(d[,c(1,2)])").asDoubleMatrix());
        //System.out.println(c.eval("as.character(d[1,2])").asString());
        c.eval("d<-read.table('C:/Users/pu/Desktop/titanic.csv',header=T,sep=',')");
        System.out.println(c.eval("names(table(d[,1]))").asStringArray()[0]);
    }

}
