package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.CalanderDao;
import org.rnt.com.entity.vo.CalanderVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("calanderService")
public class CalanderServiceImpl extends BaseService implements CalanderService{

	@Resource(name="calanderDao")
	private CalanderDao calanderDao;

	@Override
	public RtnVO insert(CalanderVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = calanderDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(CalanderVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = calanderDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(CalanderVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = calanderDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(CalanderVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = calanderDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(CalanderVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = calanderDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(CalanderVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = calanderDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
