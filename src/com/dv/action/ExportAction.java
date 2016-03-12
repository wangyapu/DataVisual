package com.dv.action;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFCellUtil;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.hssf.util.Region;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Image;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import com.opensymphony.xwork2.ActionSupport;
import com.dv.util.Export_imageBean;
import com.dv.util.Export_excelBean;

@SuppressWarnings("serial")
public class ExportAction extends ActionSupport implements SessionAware {

    private Map<String, Object> session;// 注入依赖
    private static int maxSixe = 1;

    // 文件保存的文件夹名，默认在WEB-INF下
    private String downloadDir;


    public String export_pdf() throws UnsupportedEncodingException, IOException, DocumentException {

        ArrayList<Export_imageBean> exportList = (ArrayList<Export_imageBean>) session.get("imagelist");

        ExportAction.createPdf(exportList, downloadDir);


        HttpServletRequest request = ServletActionContext.getRequest();
        request.setAttribute("mypath", "save.pdf");
        String myfilename = URLEncoder.encode("ClusterResult.pdf", "utf-8");
        request.setAttribute("filename", myfilename);

        return SUCCESS;


    }

    private static void createPdf(ArrayList<Export_imageBean> exportList, String downloadDir) throws DocumentException, IOException {
        // 获取要导出pdf的路径
        String path = ServletActionContext.getServletContext().getRealPath(
                downloadDir);
        File dir = new File(path);
        // 如果这个目录不存在，则创建它
        if (!dir.exists()) {
            dir.mkdir();
        }
        // step 1：创建Document对象
        Document document = new Document(PageSize.A4, 50, 50, 50, 50);
        // step 2：获取PdfWriter实例
        PdfWriter.getInstance(document, new FileOutputStream(new File(dir, "save.pdf")));
        // step 3：打开Document
        document.open();

        // step 4：添加内容

        BaseFont bfChinese = BaseFont.createFont("STSong-Light", "UniGB-UCS2-H", BaseFont.NOT_EMBEDDED);

        // document.add(new Paragraph("中文", new com.lowagie.text.Font(bfChinese,12)));

        PdfPTable table = new PdfPTable(1);//1列
        table.setWidthPercentage(100);


        for (int i = 0; i < exportList.size(); i++) {
            Export_imageBean exportIMG = exportList.get(i);

            PdfPTable mytable = new PdfPTable(1);

  	    	
  	    	/*String ImagePath = ServletActionContext.getServletContext().getRealPath(
  					exportIMG.getImagepath());*/

            Image image = Image.getInstance(exportIMG.getImagepath());

            mytable.addCell(image);
            //mytable.addCell(new Paragraph(exportIMG.getImageinfo(), new com.lowagie.text.Font(bfChinese,12)));
            mytable.setWidthPercentage(80);
            table.addCell(mytable);
        }
        document.add(table);

        // step 5：关闭打开的Document
        document.close();

    }

    /**
     * 导出Excel
     *
     * @return
     * @throws UnsupportedEncodingException
     */
    public String export_excel() throws UnsupportedEncodingException {

        ArrayList<Export_excelBean> exportList = (ArrayList<Export_excelBean>) session
                .get("excellist");

        try {

            //格式化结果集
            ArrayList<ArrayList<String>> myresult = createSingleList(exportList);
            //创建excel
            createExcel_new(myresult, downloadDir);

        } catch (IOException e) {
            e.printStackTrace();
        }

        HttpServletRequest request = ServletActionContext.getRequest();
        request.setAttribute("mypath", "save.xls");
        String myfilename = URLEncoder.encode("ClusterResult.xls", "utf-8");
        request.setAttribute("filename", myfilename);

        return SUCCESS;
    }

    /**
     * poi 操作excel , 合并单元格后加边框
     *
     * @param sheet1
     * @param region
     * @param cellStyle
     */
    @SuppressWarnings("deprecation")
    private static void setRegionStyle(Sheet sheet1, Region region,
                                       CellStyle cellStyle) {
        for (int i = region.getRowFrom(); i <= region.getRowTo(); i++) {
            HSSFRow row = HSSFCellUtil.getRow(i, (HSSFSheet) sheet1);
            for (int j = region.getColumnFrom(); j <= region.getColumnTo(); j++) {
                HSSFCell cell = HSSFCellUtil.getCell(row, (short) j);
                cell.setCellStyle(cellStyle);
            }
        }
    }

    public static void main(String[] args) {

        ArrayList<Export_excelBean> ielist = new ArrayList<Export_excelBean>();
		/*Import_excelBean ie = new Import_excelBean();
		double[] doubleArray = {1.22,3.44,4.33};
		ie.setArraytype("B");
		ie.setArray_B(doubleArray);
		ie.setArrayname("测试数组1");
		ielist.add(ie);
		ielist.add(ie);	*/

        Export_excelBean ie2 = new Export_excelBean();
        double[][] doubleAArray = {{1.22, 1.33, 1.44, 1.77}, {2.11, 2.55, 2.88, 2.44}};
        ie2.setArraytype("D");
        ie2.setArray_D(doubleAArray);
        ie2.setArrayname("测试数组2");
        for (int i = 0; i < 20000; i++) {
            ielist.add(ie2);
        }
        System.out.println("测试开始");
		
		/*try {
			createExcel(ielist,"");
		} catch (IOException e) {
			e.printStackTrace();
		}*/
        ArrayList<ArrayList<String>> myresult = createSingleList(ielist);
		
		/*for (int i = 0; i < myresult.size(); i++) {
			ArrayList<String> list = myresult.get(i);
			for (int j = 0; j < list.size(); j++) {
				System.out.print(list.get(j)+" ");
			}
			System.out.println();
		}*/
        try {
            createExcel_new(myresult, "");
        } catch (IOException e) {
            e.printStackTrace();
        }

        System.out.println("测试结束");

    }

    /**
     * 将要导出excel的结果集转换为统一格式
     *
     * @param exportList
     * @return
     */
    public static ArrayList<ArrayList<String>> createSingleList(ArrayList<Export_excelBean> exportList) {
        ArrayList<ArrayList<String>> singleList = new ArrayList<ArrayList<String>>();

        for (int i = 0; i < exportList.size(); i++) {

            Export_excelBean exportExcel = exportList.get(i);
            if (exportExcel.getArraytype().equals("A")) {  //数组形式为String[]
                String[] myarray = exportExcel.getArray_A();
                String arrayname = exportExcel.getArrayname();
                ArrayList<String> arraynameList = new ArrayList<String>();
                arraynameList.add(arrayname);
                singleList.add(arraynameList); //加入数组标题

                for (int j = 0; j < myarray.length; j++) { //数组中的每个元素为一行存入结果数组

                    ArrayList<String> myList = new ArrayList<String>();
                    myList.add(myarray[j]);
                    singleList.add(myList);

                }

            } else if (exportExcel.getArraytype().equals("B")) { //数组形式为double[]

                double[] myarray = exportExcel.getArray_B();
                String arrayname = exportExcel.getArrayname();
                ArrayList<String> arraynameList = new ArrayList<String>();
                arraynameList.add(arrayname);
                singleList.add(arraynameList); //加入数组标题

                for (int j = 0; j < myarray.length; j++) { //数组中的每个元素为一行存入结果数组

                    ArrayList<String> myList = new ArrayList<String>();
                    myList.add(myarray[j] + "");
                    singleList.add(myList);

                }

            } else if (exportExcel.getArraytype().equals("C")) {  //数组格式为String[][]

                String[][] myarray = exportExcel.getArray_C();
                String arrayname = exportExcel.getArrayname();
                ArrayList<String> arraynameList = new ArrayList<String>();
                arraynameList.add(arrayname);
                singleList.add(arraynameList); //加入数组标题

                for (int j = 0; j < myarray.length; j++) {
                    ArrayList<String> myList = new ArrayList<String>();
                    for (int k = 0; k < myarray[0].length; k++) {//循环将矩阵的每一行作为excel的每一行
                        myList.add(myarray[j][k]);
                    }
                    if (myarray[0].length > maxSixe) {
                        maxSixe = myarray[0].length;
                    }
                    singleList.add(myList);
                }


            } else if (exportExcel.getArraytype().equals("D")) {  //数组格式为double[][]

                double[][] myarray = exportExcel.getArray_D();
                String arrayname = exportExcel.getArrayname();
                ArrayList<String> arraynameList = new ArrayList<String>();
                arraynameList.add(arrayname);
                singleList.add(arraynameList); //加入数组标题

                for (int j = 0; j < myarray.length; j++) {
                    ArrayList<String> myList = new ArrayList<String>();
                    for (int k = 0; k < myarray[0].length; k++) {
                        myList.add(myarray[j][k] + "");
                    }
                    if (myarray[0].length > maxSixe) {
                        maxSixe = myarray[0].length;
                    }
                    singleList.add(myList);
                }

            } else if (exportExcel.getArraytype().equals("E")) {  //数组格式为int[]

                int[] myarray = exportExcel.getArray_E();
                String arrayname = exportExcel.getArrayname();
                ArrayList<String> arraynameList = new ArrayList<String>();
                arraynameList.add(arrayname);
                singleList.add(arraynameList); //加入数组标题

                for (int j = 0; j < myarray.length; j++) { //数组中的每个元素为一行存入结果数组

                    ArrayList<String> myList = new ArrayList<String>();
                    myList.add(myarray[j] + "");
                    singleList.add(myList);

                }

            }

        }

        return singleList;
    }

    /**
     * 最新的导出exel代码
     *
     * @param resultList
     * @param downloadDir
     * @throws IOException
     */
    public static void createExcel_new(ArrayList<ArrayList<String>> resultList,
                                       String downloadDir) throws IOException {

        // 创建一个EXCEL
        HSSFWorkbook wb = new HSSFWorkbook();


        // 设置单元格格式
        HSSFCellStyle cellStyle = (HSSFCellStyle) wb.createCellStyle();
        cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        cellStyle.setBottomBorderColor(HSSFColor.BLACK.index);
        cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        cellStyle.setLeftBorderColor(HSSFColor.BLACK.index);
        cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
        cellStyle.setRightBorderColor(HSSFColor.BLACK.index);
        cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
        cellStyle.setTopBorderColor(HSSFColor.BLACK.index);
        cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 左右居中
        cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中

        HSSFCellStyle cellStyle01 = (HSSFCellStyle) wb.createCellStyle();
        cellStyle01.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 左右居中
        cellStyle01.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中
        HSSFFont font = (HSSFFont) wb.createFont();
        font.setFontName("黑体");
        font.setFontHeightInPoints((short) 20);// 设置字体大小
        cellStyle01.setFont(font);

        HSSFCellStyle cellStyle02 = (HSSFCellStyle) wb.createCellStyle();
        cellStyle02.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        cellStyle02.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        cellStyle02.setBottomBorderColor(HSSFColor.BLACK.index);
        cellStyle02.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        cellStyle02.setLeftBorderColor(HSSFColor.BLACK.index);
        cellStyle02.setBorderRight(HSSFCellStyle.BORDER_THIN);
        cellStyle02.setRightBorderColor(HSSFColor.BLACK.index);
        cellStyle02.setBorderTop(HSSFCellStyle.BORDER_THIN);
        cellStyle02.setTopBorderColor(HSSFColor.BLACK.index);
        cellStyle02.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 左右居中
        cellStyle02.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中
        HSSFFont font1 = (HSSFFont) wb.createFont();
        font1.setFontName("黑体");
        font1.setFontHeightInPoints((short) 15);// 设置字体大小
        cellStyle02.setFont(font1);


        ArrayList<ArrayList<ArrayList<String>>> allList = new ArrayList<ArrayList<ArrayList<String>>>();

        //对传入的结果列表进行分页
        allList = findAllList(resultList);

        //构建分页EXCEL
        for (int m = 0; m < allList.size(); m++) {

            // 创建一个SHEET
            Sheet sheet = wb.createSheet("结果集" + (m + 1));

            for (int i = 1; i < maxSixe + 1; i++) {
                sheet.setColumnWidth(i, 100 * 60);
            }


            //获取分页的结果列表
            ArrayList<ArrayList<String>> myResultList = allList.get(m);


            for (int i = 0; i < myResultList.size(); i++) {
                ArrayList<String> strArray = myResultList.get(i);
                Row myrow = (Row) sheet.createRow(i);
                myrow.setHeightInPoints(20); // 设置行高
                for (int j = 0; j < strArray.size(); j++) {
                    Cell mycell = myrow.createCell(j + 1);
                    mycell.setCellValue(strArray.get(j));
                    mycell.setCellStyle(cellStyle);
                }
            }

        }


        // 获取要导出excel的路径
        String path = ServletActionContext.getServletContext().getRealPath(
                downloadDir);
        //String path = "d:\\outputExcel"; //测试路径
        File dir = new File(path);
        // 如果这个目录不存在，则创建它
        if (!dir.exists()) {
            dir.mkdir();
        }
        // 输出Excel表格
        FileOutputStream fileOut = new FileOutputStream(new File(dir,
                "save.xls"));
        wb.write(fileOut);
        fileOut.close();
    }

    /**
     * 结果集分页处理
     *
     * @param resultList
     * @return
     */
    public static ArrayList<ArrayList<ArrayList<String>>> findAllList(ArrayList<ArrayList<String>> resultList) {

        ArrayList<ArrayList<ArrayList<String>>> allList = new ArrayList<ArrayList<ArrayList<String>>>();
        int allsize = resultList.size();
        if (allsize > 50000) {//这种情况需要分页

            int fenyeNum = allsize / 50000 + 1;
            int index = 0;

            //处理前n-1页的分页结果
            for (int i = 0; i < fenyeNum - 1; i++) {

                //新建一个list对象保存分页结果
                ArrayList<ArrayList<String>> myResultList = new ArrayList<ArrayList<String>>();

                for (int j = 0; j < 50000; j++) { //循环50000次
                    ArrayList<String> strArray = resultList.get(index);
                    myResultList.add(strArray);
                    index++;
                }

                //添加分页结果
                allList.add(myResultList);
            }
            //处理最后一页的分页结果
            ArrayList<ArrayList<String>> myResultList = new ArrayList<ArrayList<String>>();
            for (int i = 0; i < allsize - (fenyeNum - 1) * 50000; i++) {
                ArrayList<String> strArray = resultList.get(index);
                myResultList.add(strArray);
                index++;
            }
            //添加最后一页的分页结果
            allList.add(myResultList);

        } else {
            allList.add(resultList);
        }
        return allList;
    }

    public static void createExcel(ArrayList<Export_excelBean> exportList,
                                   String downloadDir) throws IOException {
        // 创建一个EXCEL
        HSSFWorkbook wb = new HSSFWorkbook();

        // 创建一个SHEET
        Sheet sheet1 = wb.createSheet("分析结果");
        sheet1.setColumnWidth(1, 100 * 80);
        sheet1.setColumnWidth(2, 100 * 200);
        sheet1.setColumnWidth(3, 100 * 200);
        // 设置单元格格式
        HSSFCellStyle cellStyle = (HSSFCellStyle) wb.createCellStyle();
        cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        cellStyle.setBottomBorderColor(HSSFColor.BLACK.index);
        cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        cellStyle.setLeftBorderColor(HSSFColor.BLACK.index);
        cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
        cellStyle.setRightBorderColor(HSSFColor.BLACK.index);
        cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
        cellStyle.setTopBorderColor(HSSFColor.BLACK.index);
        cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 左右居中
        cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中

        HSSFCellStyle cellStyle01 = (HSSFCellStyle) wb.createCellStyle();
        cellStyle01.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 左右居中
        cellStyle01.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中
        HSSFFont font = (HSSFFont) wb.createFont();
        font.setFontName("黑体");
        font.setFontHeightInPoints((short) 20);// 设置字体大小
        cellStyle01.setFont(font);

        HSSFCellStyle cellStyle02 = (HSSFCellStyle) wb.createCellStyle();
        cellStyle02.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        cellStyle02.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        cellStyle02.setBottomBorderColor(HSSFColor.BLACK.index);
        cellStyle02.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        cellStyle02.setLeftBorderColor(HSSFColor.BLACK.index);
        cellStyle02.setBorderRight(HSSFCellStyle.BORDER_THIN);
        cellStyle02.setRightBorderColor(HSSFColor.BLACK.index);
        cellStyle02.setBorderTop(HSSFCellStyle.BORDER_THIN);
        cellStyle02.setTopBorderColor(HSSFColor.BLACK.index);
        cellStyle02.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 左右居中
        cellStyle02.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中
        HSSFFont font1 = (HSSFFont) wb.createFont();
        font1.setFontName("黑体");
        font1.setFontHeightInPoints((short) 15);// 设置字体大小
        cellStyle02.setFont(font1);

        // 创建一行
        Row row01 = (Row) sheet1.createRow((short) 0);
        row01.setHeightInPoints(50); // 设置行高
        Cell cell = row01.createCell(1);
        cell.setCellValue("分析结果");
        cell.setCellStyle(cellStyle01);
        // 合并单元格
        sheet1.addMergedRegion(new CellRangeAddress(0, 0, 1, 3));
        Region region = new Region(0, (short) 1, 0, (short) 3);
        setRegionStyle(sheet1, region, cellStyle01);

        int rowindex = 2;

        for (int i = 0; i < exportList.size(); i++) {
            System.out.println("----------------" + rowindex);

            Export_excelBean exportExcel = exportList.get(i);
            if (exportExcel.getArraytype().equals("A")) {
                // System.out.println("A------------------------");
                String[] myarray = exportExcel.getArray_A();

                Row myrow = (Row) sheet1.createRow(rowindex);
                myrow.setHeightInPoints(20); // 设置行高
                Cell mycell = myrow.createCell(1);
                // System.out.println("!!!!"+exportExcel.getArrayname());
                mycell.setCellValue(exportExcel.getArrayname());
                mycell.setCellStyle(cellStyle);
                rowindex = rowindex + 1;

                // System.out.println("a rowindex" + rowindex);
                Row myrow01 = (Row) sheet1.createRow(rowindex);
                myrow01.setHeightInPoints(20); // 设置行高
                for (int j = 0; j < myarray.length; j++) {
                    Cell mycell01 = myrow01.createCell(j + 1);
                    mycell01.setCellValue(myarray[j]);
                    mycell01.setCellStyle(cellStyle);
                }
                rowindex = rowindex + 2;

                if (rowindex > 60000) {
                    break;
                }

            } else if (exportExcel.getArraytype().equals("B")) {
                // System.out.println("B------------------------");
                double[] myarray = exportExcel.getArray_B();
                Row myrow = (Row) sheet1.createRow(rowindex);
                myrow.setHeightInPoints(20); // 设置行高
                Cell mycell = myrow.createCell(1);
                mycell.setCellValue(exportExcel.getArrayname());
                mycell.setCellStyle(cellStyle);
                rowindex = rowindex + 1;

                for (int j = 0; j < myarray.length; j++) {

                    Row myrow01 = (Row) sheet1.createRow(rowindex);
                    myrow01.setHeightInPoints(20); // 设置行高
                    Cell mycell01 = myrow01.createCell(1);
                    mycell01.setCellValue(myarray[j]);
                    mycell01.setCellStyle(cellStyle);
                    rowindex++;

                    if (rowindex > 60000) {
                        break;
                    }
                }
            } else if (exportExcel.getArraytype().equals("C")) {
                // System.out.println("C------------------------");
                String[][] myarray = exportExcel.getArray_C();
                // System.out.println("C rowindex" + rowindex);
                Row myrow = (Row) sheet1.createRow(rowindex);
                myrow.setHeightInPoints(20); // 设置行高
                Cell mycell = myrow.createCell(1);
                mycell.setCellValue(exportExcel.getArrayname());
                mycell.setCellStyle(cellStyle);
                rowindex++;

                for (int j = 0; j < myarray.length; j++) {
                    // System.out.println("C rowindex" + rowindex);
                    Row myrow01 = (Row) sheet1.createRow(rowindex);
                    myrow01.setHeightInPoints(20); // 设置行高
                    // System.out.println(myarray[0].length);
                    for (int k = 0; k < myarray[0].length; k++) {
                        Cell mycell01 = myrow01.createCell(k + 1);
                        mycell01.setCellValue(myarray[j][k]);
                        mycell01.setCellStyle(cellStyle);
                    }
                    rowindex++;
                    if (rowindex > 60000) {
                        break;
                    }
                }

                rowindex++;

            } else if (exportExcel.getArraytype().equals("D")) {
                // System.out.println("D------------------------");
                double[][] myarray = exportExcel.getArray_D();
                // System.out.println("d rowindex" + rowindex);
                Row myrow = (Row) sheet1.createRow(rowindex);
                myrow.setHeightInPoints(20); // 设置行高
                Cell mycell = myrow.createCell(1);
                mycell.setCellValue(exportExcel.getArrayname());
                mycell.setCellStyle(cellStyle);
                rowindex = rowindex + 1;

                for (int j = 0; j < myarray.length; j++) {
                    // System.out.println("d rowindex" + rowindex);
                    Row myrow01 = (Row) sheet1.createRow(rowindex);
                    myrow01.setHeightInPoints(20); // 设置行高
                    for (int k = 0; k < myarray[0].length; k++) {
                        Cell mycell01 = myrow01.createCell(k + 1);
                        mycell01.setCellValue(myarray[j][k]);
                        mycell01.setCellStyle(cellStyle);
                    }
                    rowindex++;
                    if (rowindex > 60000) {
                        break;
                    }
                }
                rowindex++;
            } else if (exportExcel.getArraytype().equals("E")) {
                int[] myarray = exportExcel.getArray_E();
                Row myrow = (Row) sheet1.createRow(rowindex);
                myrow.setHeightInPoints(20); // 设置行高
                Cell mycell = myrow.createCell(1);
                mycell.setCellValue(exportExcel.getArrayname());
                mycell.setCellStyle(cellStyle);
                rowindex = rowindex + 1;
                Row myrow01 = (Row) sheet1.createRow(rowindex);
                myrow01.setHeightInPoints(20); // 设置行高
                for (int j = 0; j < myarray.length; j++) {
                    Cell mycell01 = myrow01.createCell(j + 1);
                    mycell01.setCellValue(myarray[j]);
                    mycell01.setCellStyle(cellStyle);
                }
                rowindex = rowindex + 2;

                if (rowindex > 60000) {
                    break;
                }

            } else {

            }

        }

        // 获取要导出excel的路径
		/*String path = ServletActionContext.getServletContext().getRealPath(
				downloadDir);*/
        String path = "d:\\outputExcel";
        File dir = new File(path);
        // 如果这个目录不存在，则创建它
        if (!dir.exists()) {
            dir.mkdir();
        }
        // 输出Excel表格
        FileOutputStream fileOut = new FileOutputStream(new File(dir,
                "save.xls"));
        wb.write(fileOut);
        fileOut.close();
    }

    public String getDownloadDir() {
        return downloadDir;
    }

    public void setDownloadDir(String downloadDir) {
        this.downloadDir = downloadDir;
    }

    public void setSession(Map<String, Object> session) {
        this.session = session;
    }

    public Map<String, Object> getSession() {
        return session;
    }

}
