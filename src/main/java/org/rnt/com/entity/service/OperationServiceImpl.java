package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.OperationDao;
import org.rnt.com.entity.vo.OperationVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("operationService")
public class OperationServiceImpl extends BaseService implements OperationService{

	@Resource(name="operationDao")
	private OperationDao operationDao;

	@Override
	public RtnVO insert(OperationVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = operationDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(OperationVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = operationDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(OperationVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = operationDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(OperationVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = operationDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(OperationVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = operationDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(OperationVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = operationDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
