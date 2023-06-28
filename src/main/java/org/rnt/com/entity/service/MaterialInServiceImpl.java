package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.MaterialInDao;
import org.rnt.com.entity.vo.MaterialInVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("materialInService")
public class MaterialInServiceImpl extends BaseService implements MaterialInService{

	@Resource(name="materialInDao")
	private MaterialInDao materialInDao;

	@Override
	public RtnVO insert(MaterialInVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialInDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(MaterialInVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialInDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO selectByLotId(MaterialInVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialInDao.selectByLotId(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(MaterialInVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialInDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(MaterialInVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialInDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(MaterialInVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialInDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(MaterialInVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialInDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
    public RtnVO searchMobileList(MaterialInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = materialInDao.searchMobileList(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
	
	@Override
	public RtnVO selectPopMaterialInList(MaterialInVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialInDao.selectPopMaterialInList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO searchMaterialStockList(MaterialInVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialInDao.searchMaterialStockList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
