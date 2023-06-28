package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.MaterialDao;
import org.rnt.com.entity.vo.MaterialVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("materialService")
public class MaterialServiceImpl extends BaseService implements MaterialService{

	@Resource(name="materialDao")
	private MaterialDao materialDao;

	@Override
	public RtnVO insert(MaterialVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(MaterialVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(MaterialVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(MaterialVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(MaterialVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(MaterialVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO searchPopBomMatList(MaterialVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialDao.searchPopBomMatList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
