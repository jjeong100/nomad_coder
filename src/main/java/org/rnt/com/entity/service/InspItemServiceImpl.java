package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.InspItemDao;
import org.rnt.com.entity.vo.InspItemVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("inspItemService")
public class InspItemServiceImpl extends BaseService implements InspItemService{

	@Resource(name="inspItemDao")
	private InspItemDao inspItemDao;

	@Override
	public RtnVO insert(InspItemVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = inspItemDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(InspItemVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = inspItemDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(InspItemVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = inspItemDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(InspItemVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = inspItemDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(InspItemVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = inspItemDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(InspItemVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = inspItemDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
