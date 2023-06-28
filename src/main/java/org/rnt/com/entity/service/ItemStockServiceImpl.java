package org.rnt.com.entity.service;

import javax.annotation.Resource;

import org.rnt.com.entity.dao.ItemStockDao;
import org.rnt.com.entity.vo.ItemStockVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("itemStockService")
public class ItemStockServiceImpl extends BaseService implements ItemStockService{

	@Resource(name="itemStockDao")
	private ItemStockDao itemStockDao;

	@Override
	public RtnVO searchItemStockList(ItemStockVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemStockDao.searchItemStockList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchItemStockListTotCnt(ItemStockVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemStockDao.searchItemStockListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchBaseQty(ItemStockVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemStockDao.searchBaseQty(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
