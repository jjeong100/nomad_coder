package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.ItemInDtlDao;
import org.rnt.com.entity.vo.ItemInDtlVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("itemInDtlService")
public class ItemInDtlServiceImpl extends BaseService implements ItemInDtlService{

	@Resource(name="itemInDtlDao")
	private ItemInDtlDao itemInDtlDao;

	@Override
	public RtnVO insert(ItemInDtlVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemInDtlDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(ItemInDtlVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemInDtlDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(ItemInDtlVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemInDtlDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(ItemInDtlVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemInDtlDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(ItemInDtlVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemInDtlDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(ItemInDtlVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemInDtlDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	@Override
	public RtnVO selectByDtlLotId(ItemInDtlVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemInDtlDao.selectByDtlLotId(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO searchList2(ItemInDtlVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemInDtlDao.searchList2(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
