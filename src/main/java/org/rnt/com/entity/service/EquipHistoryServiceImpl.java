package org.rnt.com.entity.service;

import javax.annotation.Resource;

import org.rnt.com.entity.dao.EquipHistoryDao;
import org.rnt.com.entity.vo.EquipVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("equipHistoryService")
public class EquipHistoryServiceImpl extends BaseService implements EquipHistoryService{

	@Resource(name="equipHistoryDao")
	private EquipHistoryDao equipHistoryDao;

	@Override
	public RtnVO insert(EquipVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = equipHistoryDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(EquipVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = equipHistoryDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(EquipVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = equipHistoryDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(EquipVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = equipHistoryDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(EquipVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = equipHistoryDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(EquipVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = equipHistoryDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
