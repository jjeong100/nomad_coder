package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.WorkGroupDao;
import org.rnt.com.entity.vo.WorkGroupVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("workGroupService")
public class WorkGroupServiceImpl extends BaseService implements WorkGroupService{

	@Resource(name="workGroupDao")
	private WorkGroupDao workGroupDao;

	@Override
	public RtnVO insert(WorkGroupVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workGroupDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(WorkGroupVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workGroupDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(WorkGroupVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workGroupDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(WorkGroupVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workGroupDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(WorkGroupVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workGroupDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(WorkGroupVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workGroupDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
