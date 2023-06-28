package org.rnt.com.entity.service;

import javax.annotation.Resource;

import org.rnt.com.entity.dao.WorkactInfoDao;
import org.rnt.com.entity.dao.WorkactRsltDao;
import org.rnt.com.entity.vo.WorkactInfoVO;
import org.rnt.com.entity.vo.WorkactRsltVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("workactService")
public class WorkactServiceImpl extends BaseService implements WorkactService {

	@Resource(name="workactInfoDao")
	private WorkactInfoDao workactInfoDao;
	
	@Resource(name="workactRsltDao")
	private WorkactRsltDao workactRsltDao;
	
	@Override
	public RtnVO insertInfo(WorkactInfoVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workactInfoDao.insertInfo(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO selectInfo(WorkactInfoVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workactInfoDao.selectInfo(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO updateInfo(WorkactInfoVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workactInfoDao.updateInfo(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO deleteInfo(WorkactInfoVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workactInfoDao.deleteInfo(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO insertRslt(WorkactRsltVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workactRsltDao.insertRslt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO selectRslt(WorkactRsltVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workactRsltDao.selectRslt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO selectRsltList(WorkactRsltVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workactRsltDao.selectRsltList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO updateRslt(WorkactRsltVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workactRsltDao.updateRslt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO deleteRslt(WorkactRsltVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = workactRsltDao.deleteRslt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
}
