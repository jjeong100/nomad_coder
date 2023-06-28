package org.rnt.com.entity.service;

import javax.annotation.Resource;

import org.rnt.com.entity.dao.ProductionStatusDao;
import org.rnt.com.entity.vo.ProductionStatusVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("productionStatusService")
public class ProductionStatusServiceImpl extends BaseService implements ProductionStatusService {

	@Resource(name="productionStatusDao")
	private ProductionStatusDao productionStatusDao;

	@Override
	public RtnVO insert(ProductionStatusVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = productionStatusDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(ProductionStatusVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = productionStatusDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(ProductionStatusVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = productionStatusDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(ProductionStatusVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = productionStatusDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO searchList2(ProductionStatusVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = productionStatusDao.searchList2(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(ProductionStatusVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = productionStatusDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

}
