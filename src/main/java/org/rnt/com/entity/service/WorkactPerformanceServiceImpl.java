package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.WorkactPerformanceDao;
import org.rnt.com.entity.vo.WorkactPerformanceVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("workactPerformanceService")
public class WorkactPerformanceServiceImpl extends BaseService implements WorkactPerformanceService{

	@Resource(name="workactPerformanceDao")
	private WorkactPerformanceDao workactPerformanceDao;

	@Override
	public RtnVO insert(WorkactPerformanceVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workactPerformanceDao.insert(param);
			// 실적 양품수량 수정
			rtn = workactPerformanceDao.updateProductionActokQty(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(WorkactPerformanceVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workactPerformanceDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO update(WorkactPerformanceVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workactPerformanceDao.update(param);
			// 실적 양품수량 수정
			rtn = workactPerformanceDao.updateProductionActokQty(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(WorkactPerformanceVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workactPerformanceDao.delete(param);
			// 실적 양품수량 수정
			rtn = workactPerformanceDao.updateProductionActokQty(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO selectList(WorkactPerformanceVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workactPerformanceDao.selectList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
