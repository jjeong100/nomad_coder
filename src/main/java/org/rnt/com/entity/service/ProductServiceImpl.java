package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.ProductDao;
import org.rnt.com.entity.vo.ProductVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("productService")
public class ProductServiceImpl extends BaseService implements ProductService{

	@Resource(name="productDao")
	private ProductDao productDao;

	@Override
	public RtnVO insert(ProductVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = productDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(ProductVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = productDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(ProductVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = productDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(ProductVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = productDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(ProductVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = productDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(ProductVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = productDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
