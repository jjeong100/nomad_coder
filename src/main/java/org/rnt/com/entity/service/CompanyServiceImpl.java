package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.CompanyDao;
import org.rnt.com.entity.vo.CompanyVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("companyService")
public class CompanyServiceImpl extends BaseService implements CompanyService{

	@Resource(name="companyDao")
	private CompanyDao companyDao;

	@Override
	public RtnVO insert(CompanyVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = companyDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(CompanyVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = companyDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(CompanyVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = companyDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(CompanyVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = companyDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(CompanyVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = companyDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(CompanyVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = companyDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
