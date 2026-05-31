package com.car4s.servlet;

import com.car4s.entity.Part;
import com.car4s.service.PartService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

/**
 * 配件管理控制器
 * 处理配件的增删改查和搜索请求
 */
@WebServlet("/part")
public class PartServlet extends HttpServlet {
    private static final Logger log = LoggerFactory.getLogger(PartServlet.class);
    private final PartService partService = new PartService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if ("list".equals(action)) {
            listParts(req, resp);
        } else if ("search".equals(action)) {
            searchParts(req, resp);
        } else if ("delete".equals(action)) {
            deletePart(req, resp);
        } else if ("edit".equals(action)) {
            editPart(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if ("add".equals(action)) {
            addPart(req, resp);
        } else if ("update".equals(action)) {
            updatePart(req, resp);
        }
    }

    private void listParts(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Part> parts = partService.getAllParts();
        req.setAttribute("parts", parts);
        req.getRequestDispatcher("/admin/parts.jsp").forward(req, resp);
    }

    private void searchParts(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        List<Part> parts = partService.searchParts(keyword);
        req.setAttribute("parts", parts);
        req.setAttribute("keyword", keyword);
        req.getRequestDispatcher("/admin/parts.jsp").forward(req, resp);
    }

    private void addPart(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String partNo = req.getParameter("partNo");
        String partName = req.getParameter("partName");
        String brand = req.getParameter("brand");
        String model = req.getParameter("model");
        String price = req.getParameter("price");
        String stock = req.getParameter("stock");
        String description = req.getParameter("description");

        Part part = new Part();
        part.setPartNo(partNo);
        part.setPartName(partName);
        part.setBrand(brand);
        part.setModel(model);
        part.setPrice(price != null && !price.isEmpty() ? new BigDecimal(price) : BigDecimal.ZERO);
        part.setStock(stock != null && !stock.isEmpty() ? Integer.parseInt(stock) : 0);
        part.setDescription(description);

        if (partService.addPart(part)) {
            resp.sendRedirect(req.getContextPath() + "/part?action=list");
        } else {
            req.setAttribute("error", "配件编号已存在");
            req.getRequestDispatcher("/admin/part-add.jsp").forward(req, resp);
        }
    }

    private void editPart(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        Part part = partService.getPartById(id);
        req.setAttribute("part", part);
        req.getRequestDispatcher("/admin/part-edit.jsp").forward(req, resp);
    }

    private void updatePart(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        String partName = req.getParameter("partName");
        String brand = req.getParameter("brand");
        String model = req.getParameter("model");
        String price = req.getParameter("price");
        String stock = req.getParameter("stock");
        String description = req.getParameter("description");

        Part part = partService.getPartById(id);
        part.setPartName(partName);
        part.setBrand(brand);
        part.setModel(model);
        part.setPrice(price != null && !price.isEmpty() ? new BigDecimal(price) : BigDecimal.ZERO);
        part.setStock(stock != null && !stock.isEmpty() ? Integer.parseInt(stock) : 0);
        part.setDescription(description);

        partService.updatePart(part);
        resp.sendRedirect(req.getContextPath() + "/part?action=list");
    }

    private void deletePart(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        partService.deletePart(id);
        resp.sendRedirect(req.getContextPath() + "/part?action=list");
    }
}
