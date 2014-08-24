package com.dv.util;

import org.rosuda.JRI.Rengine;

public class StaticData
{
   private static StaticData sd = null;
   
   public Rengine re = null;
   public int count = 2;
   
   private StaticData(){}
   
   public static StaticData getInstance(){
	   if(sd == null){
		   sd = new StaticData();
	   }
	   return sd;
   }
   
   public void setAr(){
	   System.out.println(System.getProperty("java.library.path"));
	   if(re == null){
		   System.loadLibrary("jri");
		   String a[] = new String[1];
		   a[0]="--no-save";
		   re = new Rengine(a, false, new TextConsole());
		   re.eval("library(ff)");
		   re.eval("library(zoo)");
		   re.eval("library(rminer)");
		   re.eval("library(stats)");
		   re.eval("library(cluster)");
		   re.eval("library(arules)");
		   re.eval("library(arulesViz)");
	   }
	   else{
		   System.out.println("已经初始化！");
	   } 
   }
}
