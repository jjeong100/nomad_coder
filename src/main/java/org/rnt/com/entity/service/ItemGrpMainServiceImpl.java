package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.ItemGrpMainDao;
import org.rnt.com.entity.vo.ItemGrpMainVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("itemGrpMainService")
public class ItemGrpMainServiceImpl extends BaseService implements ItemGrpMainService{

	@Resource(name="itemGrpMainDao")
	private ItemGrpMainDao itemGrpMainDao;

	@Override
	public RtnVO insert(ItemGrpMainVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemGrpMainDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(ItemGrpMainVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemGrpMainDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(ItemGrpMainVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemGrpMainDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(ItemGrpMainVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemGrpMainDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(ItemGrpMainVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemGrpMainDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(ItemGrpMainVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemGrpMainDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
