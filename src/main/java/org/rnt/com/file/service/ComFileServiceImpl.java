package org.rnt.com.file.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.rnt.com.GlvConst;
import org.rnt.com.file.dao.ComFileDao;
import org.rnt.com.file.vo.ComFileVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.session.SessionData;
import org.rnt.com.session.SessionManager;
import org.rnt.com.util.FileUtil;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("comFileService")
public class ComFileServiceImpl extends BaseService implements ComFileService {

	@Resource(name="comFileDao")
	private ComFileDao comFileDao;
	
	@Resource(name="proPertyService")
    private ProPertyService proPertyService;
	
	@Resource(name = "fileUtil")
    FileUtil fileUtil;

	@Override
    public RtnVO insert(ComFileVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = comFileDao.insert(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
	
	@Override
	public RtnVO select(ComFileVO param) {
	    RtnVO rtn = new RtnVO();
	    try {
	        rtn = comFileDao.select(param);
	    } catch (Exception e) {
	        setRtnVO(rtn, null, e.getMessage());
	    }
	    return rtn;
	}
	
	@Override
    public RtnVO update(ComFileVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = comFileDao.update(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
	
	@Override
    public RtnVO delete(ComFileVO param) {
        RtnVO rtn = new RtnVO();
        
        try {
        	
        	rtn = comFileDao.select(param);
        	
        	if( rtn.getRc() == 0 ) {
	        	ComFileVO selComFile = (ComFileVO) rtn.getObj();
	        			
	            rtn = comFileDao.delete(param);
	            
	            if( rtn.getRc() == 0 ) {
		            File file = new File(selComFile.getFilePath());
		            
		            if( file.isFile() ) {
		            	file.delete();
		            }
	            }
            } else {
            	rtn.setRc(GlvConst.RC_ERROR);
                rtn.setMsg("파일삭제에 실패하였습니다.");
            }
            
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        
        return rtn;
    }
	
	@Override
    public RtnVO selectList(ComFileVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = comFileDao.selectList(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
	
	@Override
    public RtnVO selectListTotCnt(ComFileVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = comFileDao.selectListTotCnt(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
	
	@Override
	public void setFileUpload(HttpServletRequest request, String fileKey, RtnVO rtnVo) throws ServletException, IOException, Exception {
		List<ComFileVO> fileList = fileUtil.saveFile(request);
		
		String userId = "";
        SessionData sData = SessionManager.getUserData(request);
        if (sData != null) {
            userId = sData.getUserId();
        }
		
        try {
        	
			for(int i = 0; i < fileList.size(); i++) {
				ComFileVO fileVo = fileList.get(i);
				
				fileVo.setFactoryCd(proPertyService.getFactoryCd());
				fileVo.setWriteId(userId);
				fileVo.setUpdateId(userId);
				fileVo.setFileKey(fileKey);
				
				comFileDao.insert(fileVo);
			}
		
        } catch (Exception e) {
        	setRtnVO(rtnVo, "첨부파일 등록 오류.", e.getMessage());
        }
	}

}
