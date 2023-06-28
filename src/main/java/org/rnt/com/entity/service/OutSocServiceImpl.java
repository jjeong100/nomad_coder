package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.OutSocDao;
import org.rnt.com.entity.vo.OutSocVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("outSocService")
public class OutSocServiceImpl extends BaseService implements OutSocService{

	@Resource(name="outSocDao")
	private OutSocDao outSocDao;

	@Override
	public RtnVO insert(OutSocVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = outSocDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(OutSocVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = outSocDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(OutSocVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = outSocDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(OutSocVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = outSocDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(OutSocVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = outSocDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(OutSocVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = outSocDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
