package com.car4s.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;

/**
 * 全局异常处理过滤器
 * 捕获所有未处理的异常，返回友好的错误页面
 */
@WebFilter("/*")
public class GlobalExceptionFilter implements Filter {
    private static final Logger log = LoggerFactory.getLogger(GlobalExceptionFilter.class);

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        try {
            chain.doFilter(request, response);
        } catch (Exception e) {
            log.error("请求异常 [{} {}]: {}", req.getMethod(), req.getRequestURI(), e.getMessage(), e);

            req.setAttribute("error", "系统繁忙，请稍后重试");
            req.setAttribute("errorMessage", e.getMessage());

            if ("XMLHttpRequest".equals(req.getHeader("X-Requested-With"))) {
                resp.setContentType("application/json;charset=UTF-8");
                resp.setStatus(500);
                resp.getWriter().write("{\"code\":500,\"message\":\"系统繁忙，请稍后重试\"}");
            } else {
                resp.setStatus(500);
                req.getRequestDispatcher("/error.jsp").forward(req, resp);
            }
        }
    }
}
