package org.rnt.com.entity.service;

import javax.annotation.Resource;

import org.rnt.com.GlvConst;
import org.rnt.com.entity.dao.MaterialOutDao;
import org.rnt.com.entity.vo.MaterialOutVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("materialOutService")
public class MaterialOutServiceImpl extends BaseService implements MaterialOutService{

	@Resource(name="materialOutDao")
	private MaterialOutDao materialOutDao;

	@Override
	public RtnVO insert(MaterialOutVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialOutDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(MaterialOutVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialOutDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(MaterialOutVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialOutDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(MaterialOutVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialOutDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(MaterialOutVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialOutDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(MaterialOutVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialOutDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public int checkMaterialOut(MaterialOutVO param) {
		RtnVO rtn = new RtnVO();
		Integer rtnInt = -1;
		rtn = materialOutDao.checkMaterialOut(param);
		
		if (rtn.getRc() == GlvConst.RC_SUCC) {
			rtnInt = (Integer) rtn.getObj();
			return rtnInt;
		} else if (rtn.getRc() == GlvConst.RC_ERROR) {
			rtnInt = -1;
		} else {
			return 0;
		}
		
		return rtnInt;
	}
	
	@Override
	public RtnVO checkMatOutEndYn(MaterialOutVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialOutDao.checkMatOutEndYn(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
