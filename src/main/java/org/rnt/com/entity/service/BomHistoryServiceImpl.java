package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.BomHistoryDao;
import org.rnt.com.entity.vo.BomHistoryVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("bomHistoryService")
public class BomHistoryServiceImpl extends BaseService implements BomHistoryService{

	@Resource(name="bomHistoryDao")
	private BomHistoryDao bomHistoryDao;

	@Override
	public RtnVO insert(BomHistoryVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = bomHistoryDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(BomHistoryVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = bomHistoryDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(BomHistoryVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = bomHistoryDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(BomHistoryVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = bomHistoryDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(BomHistoryVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = bomHistoryDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(BomHistoryVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = bomHistoryDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
