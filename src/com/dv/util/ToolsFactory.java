package com.dv.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

public class ToolsFactory {

    public static boolean isNumeric(String str) {
        int begin = 0;
        boolean once = true;
        if (str == null || str.trim().equals("")) {
            return false;
        }
        str = str.trim();
        if (str.startsWith("+") || str.startsWith("-")) {
            if (str.length() == 1) {
                return false;
            }
            begin = 1;
        }
        for (int i = begin; i < str.length(); i++) {
            if (!Character.isDigit(str.charAt(i))) {
                if (str.charAt(i) == '.' && once) {
                    once = false;
                } else {
                    return false;
                }
            }
        }
        if (str.length() == (begin + 1) && !once) {
            return false;
        }
        return true;
    }


    public static String[] getColType(String filePath, String hasheadline, String separator, String missing, int num) {
        String coltypes[] = new String[num];
        File file = new File(filePath);
        BufferedReader reader = null;
        try {
            reader = new BufferedReader(new FileReader(file));
            String tempString = null;
            if (hasheadline.equals("T")) {
                reader.readLine();
            }
            while ((tempString = reader.readLine()) != null) {
                if (!tempString.contains(missing)) {
                    if (separator.equals("")) {
                        if (ToolsFactory.isNumeric(tempString.trim())) {
                            coltypes[0] = "N";
                        } else {
                            coltypes[0] = "S";
                        }
                    } else {
                        String[] temp = tempString.split(separator);
                        for (int i = 0; i < temp.length; i++) {
                            if (ToolsFactory.isNumeric(temp[i].trim())) {
                                coltypes[i] = "N";
                            } else {
                                coltypes[i] = "S";
                            }
                        }
                    }
                    break;
                }
            }
            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e1) {
                }
            }
        }
        return coltypes;
    }
}
