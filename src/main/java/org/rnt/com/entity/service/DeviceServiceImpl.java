package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.DeviceDao;
import org.rnt.com.entity.vo.DeviceVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("deviceService")
public class DeviceServiceImpl extends BaseService implements DeviceService{

	@Resource(name="deviceDao")
	private DeviceDao deviceDao;

	@Override
	public RtnVO insert(DeviceVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = deviceDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(DeviceVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = deviceDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(DeviceVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = deviceDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(DeviceVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = deviceDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(DeviceVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = deviceDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(DeviceVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = deviceDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
