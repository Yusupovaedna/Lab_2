package com.example;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class AreaCheckServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        resp.setContentType("text/html;charset=UTF-8");
        List tableRows = (List) session.getAttribute("tableRows");


        if (tableRows == null) {
            tableRows = new ArrayList<>();
            session.setAttribute("tableRows", tableRows);
            tableRows.add("<table id='outputTable'><tr>" +
                    "<th>x</th>" +
                    "<th>y</th>" +
                    "<th>r</th>" +
                    "<th>Точка входит в ОДЗ</th>" +
                    "<th>Текущее время</th></tr>");
        }
        double x = Double.parseDouble(req.getParameter("x"));
        double y = Double.parseDouble(req.getParameter("y"));
        double r = Double.parseDouble(req.getParameter("r"));
        String key = req.getParameter("key");


        PrintWriter writer = resp.getWriter();
        try {
            if (checkData(x, y, r, key)) {
                tableRows.add(new Point(x, y, r).toString());
                for (Object tableRow: tableRows) writer.println(tableRow);
            } else resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
        } finally {
            if (writer != null) writer.close();
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        if(req.getParameter("key").equals("update")){
            updateTable(req, resp);
        }
    }

    private void updateTable(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        List tableRows = (List) session.getAttribute("tableRows");
        if (tableRows == null) {
            tableRows = new ArrayList<String>();
            session.setAttribute("tableRows", tableRows);
            tableRows.add("<table id='outputTable'><tr>" +
                    "<th>x</th>" +
                    "<th>y</th>" +
                    "<th>r</th>" +
                    "<th>Точка входит в ОДЗ</th>" +
                    "<th>Текущее время</th></tr>");
        }
        PrintWriter writer = resp.getWriter();
        try {
            for (Object tableRow: tableRows) writer.println(tableRow);
        } finally {
            if (writer != null) writer.close();
        }
    }

    private boolean checkData(double x, double y, double r, String key) {
        Double[] rInterval = {1.0, 1.5, 2.0, 2.5, 3.0};
        if (key.equals("button"))
            return (Arrays.asList(rInterval).contains(r) && (y >= -5 && y <= 5) && (x > -6 && x < 4));
        else if (key.equals("svg")) return (r > 0 && r <= 3);
        else return false;
    }

    @Override
    public String getServletInfo() {
        return "AreaCheckServlet - осуществляет проверку попадания точки в область на координатной плоскости и " +
                "формирует HTML-страницу с результатами проверки. Должен обрабатывать все запросы, " +
                "содержащие сведения о координатах точки и радиусе области.";
    }
}