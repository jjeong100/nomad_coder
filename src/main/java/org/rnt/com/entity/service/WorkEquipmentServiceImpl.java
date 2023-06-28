package org.rnt.com.entity.service;

import javax.annotation.Resource;

import org.rnt.com.entity.dao.WorkEquipmentDao;
import org.rnt.com.entity.vo.WorkEquipmentVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("workEquipmentService")
public class WorkEquipmentServiceImpl extends BaseService implements WorkEquipmentService{

	@Resource(name="workEquipmentDao")
	private WorkEquipmentDao workEquipmentDao;

	@Override
	public RtnVO insert(WorkEquipmentVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workEquipmentDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(WorkEquipmentVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workEquipmentDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO searchList(WorkEquipmentVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workEquipmentDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(WorkEquipmentVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workEquipmentDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(WorkEquipmentVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workEquipmentDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
}
