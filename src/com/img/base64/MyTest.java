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

import javax.imageio.ImageIO;
import javax.imageio.ImageReadParam;
import javax.imageio.ImageReader;
import javax.imageio.stream.ImageInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import com.opensymphony.xwork2.ActionSupport;


public class MyTest extends ActionSupport
{
	private static final long serialVersionUID = -1916452043647719029L;
	
	private String imgData;
	public static String saveDir = "/WEB-INF/DownloadFiles/";
	public static String savename = "";
	private  InputStream  downloadImage;
	
	//定义裁剪图片的坐标和尺寸
	private String x1;
	private String y1;
	private String x2;
	private String y2;
	private String wei;
	private String hei;
	
	private static String fileName;
	
	@Override
	public String execute()
	{
		try {
			MyTest.createNewFile();
		} catch (IOException e) {
			e.printStackTrace();
		}
		MyTest.GenerateImage(imgData);

		return SUCCESS;
	}
	
	public static boolean createNewFile()throws IOException {
		// 删除以前的临时文件
		String mypath = ServletActionContext.getServletContext().getRealPath(
				MyTest.saveDir);
		File mydir = new File(mypath);
		String[] fileList = mydir.list();
		System.out.println("文件个数："+fileList.length);
		for (int i = 0; i < fileList.length; i++) {
			if (fileList[i].contains(".png")) {
				File deletefile = new File(ServletActionContext
						.getServletContext().getRealPath(saveDir + fileList[i]));
				deletefile.delete();
			}
		}
		// 创建新的临时文件
		java.text.SimpleDateFormat dateFormatter = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
		String uploadTime = dateFormatter.format(new java.util.Date());
		savename = "name_" + uploadTime + ".png";
		
		// 保存内容为具体表格内容的临时文本文件
		String path = ServletActionContext.getServletContext().getRealPath(
				saveDir + savename);
		File dir = new File(path);
		// 存在临时文件则删除，不存在则新建
		if (dir.exists()) {
			dir.delete();
		}	
		return true;
	}
	
	public static boolean GenerateImage(String imgStr) {
		if (imgStr == null) 
			return false;
		BASE64Decoder decoder = new BASE64Decoder();
		try {
			
			byte[] b = decoder.decodeBuffer(imgStr);
			for (int i = 0; i < b.length; ++i) {
				if (b[i] < 0) {
					b[i] += 256;
				}
			}
		
			String imgFilePath = ServletActionContext.getServletContext().getRealPath(MyTest.saveDir)+"\\"+savename;
			System.out.println(imgFilePath);
			OutputStream out = new FileOutputStream(imgFilePath);
			out.write(b);
			out.flush();
			out.close();
			return true;
		} catch (Exception e) {
			System.out.print(e);
		}
		return false;
	}
	
	public void DownloadImg2(){
		
	}
	
	/**
	 * post方法的回调函数处理
	 * window.open(spath+"myexport?contentfile="+contentfile+"&namefile="+namefile,"_self");
	 * 把服务器中存放的txt文件名称，传到这个action方法中
	 * 
	 */
	public String DownloadImg() throws IOException{

		HttpServletRequest request = ServletActionContext.getRequest(); 
		//img名称的路径
		String path1 = ServletActionContext.getServletContext().getRealPath(
				MyTest.saveDir+MyTest.savename);
		 File dir1 = new File(path1);
	     String name = dir1.getName();
	     System.out.println(name);
	     //BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(dir1)));
	    // String pngname = "result.png";
		// pngname = br.readLine();
		 //br.close();
		 request.setAttribute("filename",name);
		 if(fileName!=null)request.setAttribute("fileN",fileName); 
	     return SUCCESS;
	}
	
	public  String  getPc() throws Exception {
		return SUCCESS;
	}
	
	public InputStream  getDownloadImage() {
		try {
			  BASE64Encoder be = new BASE64Encoder();
			  HttpServletRequest request = ServletActionContext.getRequest(); 
		      String filename = (String) request.getAttribute("filename");
		      System.out.println(filename);
		      //byte [] bt = fileName.getBytes();
		      if(request.getAttribute("fileN")==null){
		    	  request.setAttribute("fileN",fileName);
		      }
		      else{
		    	  System.out.println(fileName+"------------getDownloadImg");
		      }
		      
			  return ServletActionContext.getServletContext()
									.getResourceAsStream("/WEB-INF/DownloadFiles/"+filename);
			} catch (Exception e) {
				e.printStackTrace();
			}
		return  null;
	}
	
	/**
	 * 用于裁剪保存
	 * @return
	 * @throws Exception
	 */
	public  String  excuteCrop() throws Exception {
		try {
			MyTest.createNewFile();
		} catch (IOException e) {
			e.printStackTrace();
		}
		MyTest.GenerateImage(imgData);//生成原始图像
		imageCrop();//裁剪图像
		return SUCCESS;
	}
	
	/**
	 * 图像裁剪
	 * @throws IOException 
	 */
	public void imageCrop() throws IOException{
		System.out.println("x1="+x1+",y1="+y1+",x2="+x2+",y2="+y2+",weight="+wei+",height="+hei);
		FileInputStream is = null;  
        ImageInputStream iis = null;  
        String srcpath = ServletActionContext.getServletContext().getRealPath(
				MyTest.saveDir+MyTest.savename);
        try {  
            // 读取图片文件  
            is = new FileInputStream(srcpath);  
            /* 
             * 返回包含所有当前已注册 ImageReader 的 Iterator，这些 ImageReader 声称能够解码指定格式。 
             * 参数：formatName - 包含非正式格式名称 . （例如 "jpeg" 或 "tiff"）等 。 
             */  
            Iterator<ImageReader> it = ImageIO.getImageReadersByFormatName("png");  
            ImageReader reader = it.next();  
            // 获取图片流  
            iis = ImageIO.createImageInputStream(is);  
            /* 
             * <p>iis:读取源.true:只向前搜索 </p>.将它标记为 ‘只向前搜索’。 
             * 此设置意味着包含在输入源中的图像将只按顺序读取，可能允许 reader 避免缓存包含与以前已经读取的图像关联的数据的那些输入部分。 
             */  
            reader.setInput(iis, true);  
            /* 
             * <p>描述如何对流进行解码的类<p>.用于指定如何在输入时从 Java Image I/O 
             * 框架的上下文中的流转换一幅图像或一组图像。用于特定图像格式的插件 将从其 ImageReader 实现的 
             * getDefaultReadParam 方法中返回 ImageReadParam 的实例。 
             */  
            ImageReadParam param = reader.getDefaultReadParam();  
            /* 
             * 图片裁剪区域。Rectangle 指定了坐标空间中的一个区域，通过 Rectangle 对象 
             * 的左上顶点的坐标（x，y）、宽度和高度可以定义这个区域。 
             */  
            Rectangle rect = new Rectangle(Integer.parseInt(x1), Integer.parseInt(y1), Integer.parseInt(wei), Integer.parseInt(hei));  
            // 提供一个 BufferedImage，将其用作解码像素数据的目标。  
            param.setSourceRegion(rect);  
            /* 
             * 使用所提供的 ImageReadParam 读取通过索引 imageIndex 指定的对象，并将 它作为一个完整的 
             * BufferedImage 返回。 
             */  
            BufferedImage bi = reader.read(0, param);  
            // 创建新的临时文件
    		java.text.SimpleDateFormat dateFormatter = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
    		String operationTime = dateFormatter.format(new java.util.Date());
    		savename = "name_" + operationTime + ".png";
    		String subpath = ServletActionContext.getServletContext().getRealPath(
    				MyTest.saveDir+MyTest.savename);
            // 保存新图片  
            ImageIO.write(bi, "png", new File(subpath));  
        } finally {  
            if (is != null)  
                is.close();
            if (iis != null)
                iis.close();  
        }
	}

	public String getImgData() {
		return imgData;
	}

	public void setImgData(String imgData) {
		this.imgData = imgData;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getX1() {
		return x1;
	}

	public void setX1(String x1) {
		this.x1 = x1;
	}

	public String getY1() {
		return y1;
	}

	public void setY1(String y1) {
		this.y1 = y1;
	}

	public String getX2() {
		return x2;
	}

	public void setX2(String x2) {
		this.x2 = x2;
	}

	public String getY2() {
		return y2;
	}

	public void setY2(String y2) {
		this.y2 = y2;
	}

	public String getWei() {
		return wei;
	}

	public void setWei(String wei) {
		this.wei = wei;
	}

	public String getHei() {
		return hei;
	}

	public void setHei(String hei) {
		this.hei = hei;
	}

	public static String getFileName() {
		return fileName;
	}

	public static void setFileName(String fileName) {
		MyTest.fileName = fileName;
		System.out.println(fileName+"----set");
	}

	public void setDownloadImage(InputStream downloadImage) {
		this.downloadImage = downloadImage;
	}

}
