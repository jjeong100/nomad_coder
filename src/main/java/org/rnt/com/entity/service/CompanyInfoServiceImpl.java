package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.CompanyInfoDao;
import org.rnt.com.entity.vo.CompanyInfoVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("companyInfoService")
public class CompanyInfoServiceImpl extends BaseService implements CompanyInfoService{

	@Resource(name="companyInfoDao")
	private CompanyInfoDao companyInfoDao;

	@Override
	public RtnVO insert(CompanyInfoVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = companyInfoDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(CompanyInfoVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = companyInfoDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(CompanyInfoVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = companyInfoDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(CompanyInfoVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = companyInfoDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(CompanyInfoVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = companyInfoDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(CompanyInfoVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = companyInfoDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
