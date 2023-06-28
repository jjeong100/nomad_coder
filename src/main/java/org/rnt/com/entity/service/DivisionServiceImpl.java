package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.DivisionDao;
import org.rnt.com.entity.vo.DivisionVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("divisionService")
public class DivisionServiceImpl extends BaseService implements DivisionService{

	@Resource(name="divisionDao")
	private DivisionDao divisionDao;

	@Override
	public RtnVO insert(DivisionVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = divisionDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(DivisionVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = divisionDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(DivisionVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = divisionDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(DivisionVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = divisionDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(DivisionVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = divisionDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(DivisionVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = divisionDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
