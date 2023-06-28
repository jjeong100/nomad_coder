package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.FinishQmBadDao;
import org.rnt.com.entity.vo.FinishQmBadVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("finishQmBadService")
public class FinishQmBadServiceImpl extends BaseService implements FinishQmBadService {

	@Resource(name="finishQmBadDao")
	private FinishQmBadDao finishQmBadDao;

	@Override
	public RtnVO insert(FinishQmBadVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = finishQmBadDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(FinishQmBadVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = finishQmBadDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(FinishQmBadVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = finishQmBadDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO delete(FinishQmBadVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = finishQmBadDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO selectList(FinishQmBadVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = finishQmBadDao.selectList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO updateActbadQty(FinishQmBadVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = finishQmBadDao.updateActbadQty(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
