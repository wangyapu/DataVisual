package com.dv.util;


import java.io.Serializable;

@SuppressWarnings("serial")
public class PageUtil implements Serializable {

    private int totalpage;
    private int pageno;
    private int prepageno;
    private int nextpageno;
    private int pagesize;
    private int totalnum;

    public int getNextpageno() {
        return nextpageno;
    }

    public void setNextpageno(int nextpageno) {
        this.nextpageno = nextpageno;
    }

    public int getPageno() {
        return pageno;
    }

    public void setPageno(int pageno) {
        this.pageno = pageno;
    }

    public int getPagesize() {
        return pagesize;
    }

    public void setPagesize(int pagesize) {
        this.pagesize = pagesize;
    }

    public int getPrepageno() {
        return prepageno;
    }

    public void setPrepageno(int prepageno) {
        this.prepageno = prepageno;
    }

    public int getTotalpage() {
        return totalpage;
    }

    public void setTotalpage(int totalpage) {
        this.totalpage = totalpage;
    }

    public int getTotalnum() {
        return totalnum;
    }

    public void setTotalnum(int totalnum) {
        this.totalnum = totalnum;
    }


    public PageUtil(String spageno, int totalnum, int pagesize) {
        this.pagesize = pagesize;
        this.totalnum = totalnum;


        pageno = 1;
        if (spageno != null)
            pageno = Integer.parseInt(spageno);


        totalpage = totalnum % pagesize == 0 ? (totalnum / pagesize) : (totalnum
                / pagesize + 1);


        if (pageno >= totalpage) {
            pageno = totalpage;
            nextpageno = pageno;
        } else {
            nextpageno = pageno + 1;
        }
        if (pageno <= 1) {
            pageno = 1;
            prepageno = pageno;
        } else {
            prepageno = pageno - 1;
        }

    }
}
