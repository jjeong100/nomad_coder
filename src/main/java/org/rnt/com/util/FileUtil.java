package org.rnt.com.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.rnt.com.file.vo.ComFileVO;
import org.rnt.com.service.ProPertyService;
import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Component(value="fileUtil")
public class FileUtil {
	
	@Resource(name="proPertyService")
    private ProPertyService proPertyService;
	
	public FileUtil() {
		// TODO Auto-generated constructor stub
	}
	
	public List<ComFileVO> saveFile(HttpServletRequest request) throws ServletException, IOException, Exception {
    	List<ComFileVO> savedFiles = new ArrayList<ComFileVO>();
    	
        String filePath = "";
        String fileName = "";
        String rename = "";
        String fullName = "";
        int maxSize = 0;

        try {
//            request.setCharacterEncoding("UTF-8");

            String pathDiv = "";
            String separator = File.separator;
            if("localhost".equals(request.getServerName()) ) {
            	pathDiv = "local";
            } else {
            	pathDiv = "server";
            }

//            if( separator.equals("\\")){
//                separator = File.separator + File.separator;
//            }
            
            filePath = proPertyService.getFilePath(pathDiv) + getTodayString() + separator;
            maxSize = proPertyService.getFileMaxSize();

            File file = new File(filePath);
            if (!file.exists()){
                file.mkdirs();
            }

            List<MultipartFile> fileList = getMultipartFiles(request);

            for(int i = 0; i < fileList.size(); i++) {
                MultipartFile mFile = fileList.get(i);

                // 원본파일명
                fileName = mFile.getOriginalFilename();
                rename = DateUtil.formatCurrentDateTime() + "_" + i;
                fullName = filePath + rename;
                
                ComFileVO fileInfo = new ComFileVO();
                String fileType = mFile.getContentType();

                if(mFile.getSize() > maxSize * 1024 * 1024) {
                    throw new Exception("파일 업로드시 파일의 최대크기는 "+maxSize+"메가로 하여 주십시오.") ;
                }

                int idx = fileName.lastIndexOf(".");
                if(idx < 0) idx = 0;

                fileInfo.setFileNm(rename);
                fileInfo.setFileOrgNm(fileName);
                fileInfo.setFilePath(fullName);
                fileInfo.setFileType(fileType);
                
                if (mFile != null) {
                    fileInfo.setFileSize(mFile.getSize());
                }
                
                // 파일 생성 후 복사
                File finalFile = new File(fullName);
                FileCopyUtils.copy(mFile.getInputStream(), new FileOutputStream(finalFile));
                savedFiles.add(fileInfo);
            }
        } catch (Exception e) {
            throw e;
        }
        return savedFiles;
    }
	
	public static List<MultipartFile> getMultipartFiles(HttpServletRequest request) {
        final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
        final Map<String, MultipartFile> files = multiRequest.getFileMap();

        List<MultipartFile> fileList = new ArrayList<MultipartFile>();

        Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();

        while (itr.hasNext()) {
            Entry<String, MultipartFile> entry = itr.next();

            fileList.add(entry.getValue());
        }

        return fileList;
    }
	
	public static List<MultipartFile> getMultipartFiles(MultipartHttpServletRequest multiRequest) {
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		List<MultipartFile> fileList = new ArrayList<MultipartFile>();
		
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		
		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();
			
			fileList.add(entry.getValue());
		}
		
		return fileList;
	}
	
	public static String getTodayString() {
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());
        return format.format(new Date());
    }
	
}
