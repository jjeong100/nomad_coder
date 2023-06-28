package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.FinishQmDao;
import org.rnt.com.entity.vo.FinishQmVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("finishQmService")
public class FinishQmServiceImpl extends BaseService implements FinishQmService{

	@Resource(name="finishQmDao")
	private FinishQmDao finishQmDao;

	@Override
	public RtnVO insert(FinishQmVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = finishQmDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(FinishQmVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = finishQmDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(FinishQmVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = finishQmDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(FinishQmVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = finishQmDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(FinishQmVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = finishQmDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(FinishQmVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = finishQmDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO searchJoinList(FinishQmVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = finishQmDao.searchJoinList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchJoinListTotCnt(FinishQmVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = finishQmDao.searchJoinListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	@Override
	public RtnVO getFinishQmListDataTotCnt(FinishQmVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = finishQmDao.getFinishQmListDataTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO getFinishQmListData(FinishQmVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = finishQmDao.getFinishQmListData(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
