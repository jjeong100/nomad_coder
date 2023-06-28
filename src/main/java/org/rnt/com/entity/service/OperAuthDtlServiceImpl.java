package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.OperAuthDtlDao;
import org.rnt.com.entity.vo.OperAuthVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("operAuthDtlService")
public class OperAuthDtlServiceImpl extends BaseService implements OperAuthDtlService{

	@Resource(name="operAuthDtlDao")
	private OperAuthDtlDao operAuthDtlDao;

	@Override
	public RtnVO insert(OperAuthVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = operAuthDtlDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(OperAuthVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = operAuthDtlDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(OperAuthVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = operAuthDtlDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(OperAuthVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = operAuthDtlDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(OperAuthVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = operAuthDtlDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(OperAuthVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = operAuthDtlDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
