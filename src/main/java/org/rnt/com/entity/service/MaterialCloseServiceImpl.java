package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.MaterialCloseDao;
import org.rnt.com.entity.vo.MaterialCloseVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("materialCloseService")
public class MaterialCloseServiceImpl extends BaseService implements MaterialCloseService{

	@Resource(name="materialCloseDao")
	private MaterialCloseDao materialCloseDao;

	@Override
	public RtnVO insert(MaterialCloseVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialCloseDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(MaterialCloseVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialCloseDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(MaterialCloseVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialCloseDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(MaterialCloseVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialCloseDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO deleteMonthClose(MaterialCloseVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialCloseDao.deleteMonthClose(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(MaterialCloseVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialCloseDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(MaterialCloseVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialCloseDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
