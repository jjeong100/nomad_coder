package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.MaterialStockDao;
import org.rnt.com.entity.vo.MaterialStockVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("materialStockService")
public class MaterialStockServiceImpl extends BaseService implements MaterialStockService{

	@Resource(name="materialStockDao")
	private MaterialStockDao materialStockDao;

	@Override
	public RtnVO insert(MaterialStockVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialStockDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(MaterialStockVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialStockDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(MaterialStockVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialStockDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(MaterialStockVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialStockDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(MaterialStockVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialStockDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(MaterialStockVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialStockDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
