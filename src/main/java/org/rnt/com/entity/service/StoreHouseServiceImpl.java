package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.StoreHouseDao;
import org.rnt.com.entity.vo.StoreHouseVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("storeHouseService")
public class StoreHouseServiceImpl extends BaseService implements StoreHouseService{

	@Resource(name="storeHouseDao")
	private StoreHouseDao storeHouseDao;

	@Override
	public RtnVO insert(StoreHouseVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = storeHouseDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(StoreHouseVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = storeHouseDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(StoreHouseVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = storeHouseDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(StoreHouseVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = storeHouseDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(StoreHouseVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = storeHouseDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(StoreHouseVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = storeHouseDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
