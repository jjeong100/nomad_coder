package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.BomInspDao;
import org.rnt.com.entity.vo.BomInspVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("bomInspService")
public class BomInspServiceImpl extends BaseService implements BomInspService{

	@Resource(name="bomInspDao")
	private BomInspDao bomInspDao;

	@Override
	public RtnVO insert(BomInspVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = bomInspDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(BomInspVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = bomInspDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(BomInspVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = bomInspDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(BomInspVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = bomInspDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(BomInspVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = bomInspDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(BomInspVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = bomInspDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
    public RtnVO selectInspList(BomInspVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = bomInspDao.selectInspList(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
}
