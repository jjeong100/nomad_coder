package org.rnt.com.entity.service;

import javax.annotation.Resource;

import org.rnt.com.entity.dao.CodeDao;
import org.rnt.com.entity.vo.CodeVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;


@Service("codeService")
public class CodeServiceImpl extends BaseService implements CodeService {
	
	@Resource(name="codeDao")
	private CodeDao codeDao;
	
	@Override
    public RtnVO insert(CodeVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = codeDao.insert(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
	
	@Override
	public RtnVO select(CodeVO param) {
	    RtnVO rtn = new RtnVO();
	    try {
	        rtn = codeDao.select(param);
	    } catch (Exception e) {
	        setRtnVO(rtn, null, e.getMessage());
	    }
	    return rtn;
	}
	
	@Override
    public RtnVO update(CodeVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = codeDao.update(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
	
	@Override
    public RtnVO delete(CodeVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = codeDao.delete(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
	
	@Override
    public RtnVO searchList(CodeVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = codeDao.searchList(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
	
	@Override
    public RtnVO searchListTotCnt(CodeVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = codeDao.searchListTotCnt(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
	
}
