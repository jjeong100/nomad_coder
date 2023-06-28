package org.rnt.system.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;

import javax.activation.MimetypesFileTypeMap;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rnt.com.controller.BaseController;
import org.rnt.com.entity.service.DataBackupService;
import org.rnt.com.entity.vo.DataBackupVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.util.DateUtil;
import org.rnt.com.util.StrUtil;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class DataBackupController extends BaseController {
    
    protected Log log = LogFactory.getLog(this.getClass());
    
    @Resource(name="dataBackupService")
    private DataBackupService dataBackupService;
    
    @Resource(name="proPertyService")
    private ProPertyService proPertyService;
    
    @RequestMapping(value = "/dataBackupListPage.do")
    public String dataBackupListPage(@ModelAttribute("search")DataBackupVO search, HttpServletRequest request, ModelMap model)  throws Exception {
        webStart(request);
        //---------------------------------------------------------------------
        // 날짜 조회 초기 값 처리
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSearchFromDate())) {
        	search.setSearchFromDate(DateUtil.formatCurrent("yyyyMM")+"01");
        	search.setSearchToDate(DateUtil.formatCurrent("yyyyMMdd"));
        } else {
        	search.setSearchFromDate(search.getSearchFromDate().replace("/", ""));
        	search.setSearchToDate(search.getSearchToDate().replace("/", ""));
        }
        
        //---------------------------------------------------------------------
        // paging set
        //---------------------------------------------------------------------
        if (StrUtil.isNull(search.getSortCol())) {
            search.setSortCol("UPDATE_DT");
            search.setSortType("DESC");
        }
        
        search.setPaging(true); // PageIndex >> FirstIndex, LastIndex
        RtnVO rtn = dataBackupService.searchList(search);
        RtnVO rtnTotCnt = dataBackupService.searchListTotCnt(search);
        rtn.setTotCnt((Integer)rtnTotCnt.getObj());
        
        //---------------------------------------------------------------------
        // 날짜 조회 조건  화면 format 변환
        //---------------------------------------------------------------------
        if (!StrUtil.isNull(search.getSearchFromDate())) {
        	search.setSearchFromDate(DateUtil.formatDateAsSlashFormat(search.getSearchFromDate()));
        	search.setSearchToDate(DateUtil.formatDateAsSlashFormat(search.getSearchToDate()));
        }
        
        wedEnd(request, rtn, model);
        return "/system/dataBackupList";
    }
    
    @RequestMapping(value="/downloadBackupFile.do")
    public void downloadBackupFile(HttpServletRequest request, HttpServletResponse response, @RequestParam(value="backupSeq", required = true) String backupSeq) throws Exception {
        InputStream input = null;
        OutputStream output = null;
        
        String fileNm = "";
        String filePath = "";
        
        try {
        	DataBackupVO dataBackupVo = new DataBackupVO();
        	dataBackupVo.setFactoryCd(proPertyService.getFactoryCd());
        	dataBackupVo.setBackupSeq(backupSeq);
        	
        	RtnVO rtn = dataBackupService.select(dataBackupVo);
        	
        	dataBackupVo = (DataBackupVO) rtn.getObj();
        	
        	fileNm = dataBackupVo.getBackupNm();
        	filePath = dataBackupVo.getBackupPath();
        	
            File file  = new File(filePath + File.separator + fileNm);
            log.info("file info ===>"+ file.toString());
            
            input = new FileInputStream(file);
            output = response.getOutputStream();
            
            String contentDisposition = getDisposition(fileNm, getBrowser(request));
            response.addHeader("Content-disposition", contentDisposition);
            response.setHeader("Content-Length", String.valueOf(file.length()));
            response.setContentType(new MimetypesFileTypeMap().getContentType(file));
            FileCopyUtils.copy(input, output);
            
            output.flush();
        } catch (IOException e) {
            e.printStackTrace();
            StringBuffer script = new StringBuffer();
			script.append("\n<html> ");
			script.append("\n	<head> ");
			script.append("\n		<script type=\"text/javascript\"> ");
			script.append("\n		alert(\"파일이 존재하지 않습니다.\");");
			script.append("\n		</script> ");
			script.append("\n	</head> ");
			script.append("\n</html> ");
			response.setContentType("text/html; charset=utf-8");
			response.getWriter().write(script.toString());
        } finally {
            if (input != null) { try { input.close(); } catch (IOException ioe) { /* */ } }
            if (output != null) { try { output.close(); } catch (IOException ioe) { /* */ } }
        }
        
        log.info("FileName ===>" + fileNm);
    }
    
    private String getBrowser(HttpServletRequest request) {
        String header = request.getHeader("User-Agent");
        if (header.indexOf("MSIE") > -1) {
            return "MSIE";
        } else if (header.indexOf("Chrome") > -1) {
            return "Chrome";
        } else if (header.indexOf("Opera") > -1) {
            return "Opera";
        }
        return "Firefox";
    }
    
    // 브라우저 타입에 따라 File Name Encoding을 다르게 구성함.
    private String getDisposition(String filename, String browser) throws Exception {
        String dispositionPrefix = "attachment;filename=";
        String encodedFilename = null;
        if (browser.equals("MSIE")) {
            encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
        } else if (browser.equals("Firefox")) {
            encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
        } else if (browser.equals("Opera")) {
            encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
        } else if (browser.equals("Chrome")) {
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < filename.length(); i++) {
                char c = filename.charAt(i);
                if (c > '~') {
                    sb.append(URLEncoder.encode("" + c, "UTF-8"));
                } else {
                    sb.append(c);
                }
            }
            encodedFilename = sb.toString();
        } else {
            throw new RuntimeException("Not supported browser");
        }
        
        return dispositionPrefix + encodedFilename;
    }
    
}
