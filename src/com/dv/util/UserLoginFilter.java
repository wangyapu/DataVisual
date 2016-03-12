package com.dv.util;


import java.io.IOException;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
public class UserLoginFilter extends HttpServlet implements Filter {

    public void doFilter(ServletRequest arg0, ServletResponse arg1,
                         FilterChain arg2) throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) arg0;
        HttpServletResponse response = (HttpServletResponse) arg1;
        HttpSession session = request.getSession();
        String user = (String) session.getAttribute("username");
        if (user != null) {
            arg2.doFilter(arg0, arg1);
        } else {
            session.setAttribute("message", "��¼��ʱ�������µ�¼");
            String contextPath = request.getContextPath();
            response.sendRedirect(contextPath + "/login.jsp");
        }

    }

    public void init(FilterConfig arg0) throws ServletException {
    }

}
