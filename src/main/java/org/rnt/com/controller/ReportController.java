package org.rnt.com.controller;

import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;

@Controller
public class ReportController extends BaseController {
    protected Log log = LogFactory.getLog(this.getClass());
    
    @RequestMapping(value="/sampleReport.do",method = RequestMethod.GET)
    public void sampleReport(@RequestParam("id") String id, HttpServletRequest req, HttpServletResponse resp, HttpSession session) throws Exception{
        
        String contextRootPath=req.getSession().getServletContext().getRealPath("/");
        JasperReport jasperReport=JasperCompileManager.compileReport(contextRootPath+"resource/reports/sample.jrxml");
        
        HashMap<String,Object> map=new HashMap<String,Object>(); 
        map.put("itemCd", id);
        
        Connection connection = null; 
        String url = "jdbc:postgresql://59.12.52.175:5432/NEW_MES"; 
        String username = "rntime";  
        String password = "rntime8630"; 

        connection = DriverManager.getConnection(url, username, password);         
        JasperFillManager.fillReport(jasperReport, map,connection );
        byte[] byteStream=JasperRunManager.runReportToPdf(jasperReport, map,connection); 
        OutputStream outStream = resp.getOutputStream();
        resp.setContentType("application/pdf");
        resp.setContentLength(byteStream.length);
        outStream.write(byteStream,0,byteStream.length);    
    }
}
