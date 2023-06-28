package org.rnt.com.entity.service;

import javax.annotation.Resource;

import org.rnt.com.entity.dao.EquipMtnDao;
import org.rnt.com.entity.vo.EquipMtnVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("equipMtnService")
public class EquipMtnServiceImpl extends BaseService implements EquipMtnService{

	@Resource(name="equipMtnDao")
	private EquipMtnDao equipMtnDao;

	@Override
	public RtnVO insert(EquipMtnVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = equipMtnDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(EquipMtnVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = equipMtnDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(EquipMtnVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = equipMtnDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(EquipMtnVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = equipMtnDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(EquipMtnVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = equipMtnDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(EquipMtnVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = equipMtnDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
