package org.rnt.com.file.controller;

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
import org.rnt.com.file.service.ComFileService;
import org.rnt.com.file.vo.ComFileVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.util.FileUtil;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ComFileController extends BaseController {
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Resource(name = "fileUtil")
    FileUtil fileUtil;
	
	@Resource(name="comFileService")
    private ComFileService comFileService;
	
	@Resource(name="proPertyService")
    private ProPertyService proPertyService;
		
	@RequestMapping(value="/downloadComFile.do")
    public void downloadComFile(HttpServletRequest request, HttpServletResponse response, @RequestParam(value="fileSeq", required = true) String fileSeq) throws Exception {
        InputStream input = null;
        OutputStream output = null;
        
        String fileNm = "";
        String filePath = "";
        
        try {
        	
        	ComFileVO comFileVo = new ComFileVO();
        	comFileVo.setFactoryCd(proPertyService.getFactoryCd());
        	comFileVo.setFileSeq(fileSeq);
        	
        	RtnVO rtn = comFileService.select(comFileVo);
        	
        	ComFileVO selComFileVo = (ComFileVO) rtn.getObj();
        	
        	fileNm = selComFileVo.getFileOrgNm();
        	filePath = selComFileVo.getFilePath();
        	
            File file  = new File(filePath);
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
//			script.append("\n		self.history.back();");
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
	
	@RequestMapping(value="/deleteComFile.do")
	public ModelAndView deleteComFile(HttpServletRequest request, HttpServletResponse response, @RequestParam(value="fileSeq", required = true) String fileSeq) throws Exception {
		webStart(request);
        ModelAndView mav = new ModelAndView("jsonView");
        RtnVO rtn = new RtnVO();
        
        ComFileVO comFileVo = new ComFileVO();
    	comFileVo.setFactoryCd(proPertyService.getFactoryCd());
    	comFileVo.setFileSeq(fileSeq);
    	
    	rtn = comFileService.delete(comFileVo);
        
        wedEnd(request, rtn, mav);
        return mav;
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
