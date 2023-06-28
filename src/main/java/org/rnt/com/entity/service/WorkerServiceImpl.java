package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.WorkerDao;
import org.rnt.com.entity.vo.WorkerVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("workerService")
public class WorkerServiceImpl extends BaseService implements WorkerService{

	@Resource(name="workerDao")
	private WorkerDao workerDao;

	@Override
	public RtnVO insert(WorkerVO param) {
		RtnVO rtn = new RtnVO();
		try {
			//rntime8630
			param.setPassCd("47499edbb7f7b44de59ba91c5a1ea4f27d4cf5c2b0436a66d11a52c7d4998f74");
			rtn = workerDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(WorkerVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workerDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO selectByShortId(WorkerVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workerDao.selectByShortId(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(WorkerVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workerDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(WorkerVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workerDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(WorkerVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workerDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(WorkerVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workerDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO resetPassWord(WorkerVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workerDao.resetPassWord(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
