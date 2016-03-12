package com.dv.util;

public class QuickSort {
    /**
     * 快速排序
     *
     * @param strDate
     * @param left
     * @param right
     */

    //高到低
    public double[] quickSort(double[] strDate, int left, int right) {
        double middle, tempDate;
        int i, j;
        i = left;
        j = right;
        middle = strDate[(i + j) / 2];
        do {
            while (strDate[i] > middle && i < right)
                i++; //找出左边比中间值大的数
            while (strDate[j] < middle && j > left)
                j--; //找出右边比中间值小的数
            if (i <= j) { //将左边大的数和右边小的数进行替换
                tempDate = strDate[i];
                strDate[i] = strDate[j];
                strDate[j] = tempDate;
                i++;
                j--;
            }
        } while (i <= j); //当两者交错时停止
        /*for(int k=0;k<strDate.length;k++){
			System.out.print(strDate[k]+" ");
		}
		System.out.println();*/
        if (i < right) {
            quickSort(strDate, i, right);
        }
        if (j > left) {
            quickSort(strDate, left, j);
        }
        return strDate;
    }

    //低到高
    public double[] quickSort1(double[] strDate, int left, int right) {
        double middle, tempDate;
        int i, j;
        i = left;
        j = right;
        middle = strDate[(i + j) / 2];
        do {
            while (strDate[i] < middle && i < right)
                i++; //找出左边比中间值大的数
            while (strDate[j] > middle && j > left)
                j--; //找出右边比中间值小的数
            if (i <= j) { //将左边大的数和右边小的数进行替换
                tempDate = strDate[i];
                strDate[i] = strDate[j];
                strDate[j] = tempDate;
                i++;
                j--;
            }
        } while (i <= j); //当两者交错时停止

        if (i < right) {
            quickSort1(strDate, i, right);
        }
        if (j > left) {
            quickSort1(strDate, left, j);
        }
        return strDate;
    }

    public static void main(String[] args) {
        double[] strVoid = new double[]{11, 66, 77, 0, 12.1, 55};
        QuickSort sort = new QuickSort();
        sort.quickSort1(strVoid, 0, strVoid.length - 1);
        for (int i = 0; i < strVoid.length; i++) {
            System.out.println(strVoid[i] + " ");
        }
    }
}