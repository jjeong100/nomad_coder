package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.ItemOutDtlDao;
import org.rnt.com.entity.vo.ItemOutDtlVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("itemOutDtlService")
public class ItemOutDtlServiceImpl extends BaseService implements ItemOutDtlService{

	@Resource(name="itemOutDtlDao")
	private ItemOutDtlDao itemOutDtlDao;

	@Override
	public RtnVO insert(ItemOutDtlVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemOutDtlDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(ItemOutDtlVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemOutDtlDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(ItemOutDtlVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemOutDtlDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(ItemOutDtlVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemOutDtlDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(ItemOutDtlVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemOutDtlDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(ItemOutDtlVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemOutDtlDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
