package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.WorkactErrorDao;
import org.rnt.com.entity.vo.WorkactErrorVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("workactErrorService")
public class WorkactErrorServiceImpl extends BaseService implements WorkactErrorService{

	@Resource(name="workactErrorDao")
	private WorkactErrorDao workactErrorDao;

	@Override
	public RtnVO insert(WorkactErrorVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workactErrorDao.insert(param);
			// 실적 불량수량 수정
			rtn = workactErrorDao.updateProductionActbadQty(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(WorkactErrorVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workactErrorDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(WorkactErrorVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workactErrorDao.update(param);
			// 실적 불량수량 수정
			rtn = workactErrorDao.updateProductionActbadQty(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(WorkactErrorVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workactErrorDao.delete(param);
			// 실적 불량수량 수정
			rtn = workactErrorDao.updateProductionActbadQty(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO selectList(WorkactErrorVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workactErrorDao.selectList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
