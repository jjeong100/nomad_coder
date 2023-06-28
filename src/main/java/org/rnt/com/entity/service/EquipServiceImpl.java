package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.EquipDao;
import org.rnt.com.entity.vo.EquipVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("equipService")
public class EquipServiceImpl extends BaseService implements EquipService{

	@Resource(name="equipDao")
	private EquipDao equipDao;

	@Override
	public RtnVO insert(EquipVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = equipDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(EquipVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = equipDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(EquipVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = equipDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(EquipVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = equipDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(EquipVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = equipDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO searchListAutoLine(EquipVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = equipDao.searchListAutoLine(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO searchListNotAutoLine(EquipVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = equipDao.searchListNotAutoLine(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(EquipVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = equipDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
