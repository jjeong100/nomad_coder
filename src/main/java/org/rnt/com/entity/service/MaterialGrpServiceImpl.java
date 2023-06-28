package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.MaterialGrpDao;
import org.rnt.com.entity.vo.MaterialGrpVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("materialGrpService")
public class MaterialGrpServiceImpl extends BaseService implements MaterialGrpService{

	@Resource(name="materialGrpDao")
	private MaterialGrpDao materialGrpDao;

	@Override
	public RtnVO insert(MaterialGrpVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialGrpDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(MaterialGrpVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialGrpDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(MaterialGrpVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialGrpDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(MaterialGrpVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialGrpDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(MaterialGrpVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialGrpDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(MaterialGrpVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialGrpDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
