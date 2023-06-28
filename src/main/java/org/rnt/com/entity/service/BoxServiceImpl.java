package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.BoxDao;
import org.rnt.com.entity.vo.BoxVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("boxService")
public class BoxServiceImpl extends BaseService implements BoxService{

	@Resource(name="boxDao")
	private BoxDao boxDao;

	@Override
	public RtnVO insert(BoxVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = boxDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(BoxVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = boxDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(BoxVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = boxDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(BoxVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = boxDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(BoxVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = boxDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(BoxVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = boxDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
