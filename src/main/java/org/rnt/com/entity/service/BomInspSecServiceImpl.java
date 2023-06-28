package org.rnt.com.entity.service;

import javax.annotation.Resource;

import org.rnt.com.entity.dao.BomInspSecDao;
import org.rnt.com.entity.vo.BomInspSecVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("bomInspSecService")
public class BomInspSecServiceImpl extends BaseService implements BomInspSecService{

	@Resource(name="bomInspSecDao")
	private BomInspSecDao bomInspSecDao;

	@Override
	public RtnVO insert(BomInspSecVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = bomInspSecDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(BomInspSecVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = bomInspSecDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(BomInspSecVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = bomInspSecDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(BomInspSecVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = bomInspSecDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(BomInspSecVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = bomInspSecDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
