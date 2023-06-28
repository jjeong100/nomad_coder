package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.OperAuthDao;
import org.rnt.com.entity.vo.OperAuthVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("operAuthService")
public class OperAuthServiceImpl extends BaseService implements OperAuthService{

	@Resource(name="operAuthDao")
	private OperAuthDao operAuthDao;

	@Override
	public RtnVO insert(OperAuthVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = operAuthDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(OperAuthVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = operAuthDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(OperAuthVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = operAuthDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(OperAuthVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = operAuthDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(OperAuthVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = operAuthDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(OperAuthVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = operAuthDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO selectWorkerCnt(OperAuthVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = operAuthDao.selectWorkerCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
