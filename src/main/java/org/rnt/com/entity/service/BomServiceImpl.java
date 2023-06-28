package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.BomDao;
import org.rnt.com.entity.vo.BomVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("bomService")
public class BomServiceImpl extends BaseService implements BomService{

	@Resource(name="bomDao")
	private BomDao bomDao;

	@Override
	public RtnVO insert(BomVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = bomDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO selectByItemCdAndOperSeq(BomVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = bomDao.selectByItemCdAndOperSeq(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO select(BomVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = bomDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(BomVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = bomDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(BomVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = bomDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(BomVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = bomDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(BomVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = bomDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
