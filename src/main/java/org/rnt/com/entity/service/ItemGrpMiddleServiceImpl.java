package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.ItemGrpMiddleDao;
import org.rnt.com.entity.vo.ItemGrpMiddleVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("itemGrpMiddleService")
public class ItemGrpMiddleServiceImpl extends BaseService implements ItemGrpMiddleService{

	@Resource(name="itemGrpMiddleDao")
	private ItemGrpMiddleDao itemGrpMiddleDao;

	@Override
	public RtnVO insert(ItemGrpMiddleVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemGrpMiddleDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(ItemGrpMiddleVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemGrpMiddleDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(ItemGrpMiddleVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemGrpMiddleDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(ItemGrpMiddleVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemGrpMiddleDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(ItemGrpMiddleVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemGrpMiddleDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(ItemGrpMiddleVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemGrpMiddleDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
