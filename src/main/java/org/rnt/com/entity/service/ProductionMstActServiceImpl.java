package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.ProductionMstActDao;
import org.rnt.com.entity.vo.ProductionMstActVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("productionMstActService")
public class ProductionMstActServiceImpl extends BaseService implements ProductionMstActService{

	@Resource(name="productionMstActDao")
	private ProductionMstActDao productionMstActDao;

	@Override
	public RtnVO insert(ProductionMstActVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = productionMstActDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(ProductionMstActVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = productionMstActDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(ProductionMstActVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = productionMstActDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO updateAssignQty(ProductionMstActVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = productionMstActDao.updateAssignQty(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
    public RtnVO updateAssignQtyAtMix(ProductionMstActVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = productionMstActDao.updateAssignQtyAtMix(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

	@Override
	public RtnVO delete(ProductionMstActVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = productionMstActDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO selectList(ProductionMstActVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = productionMstActDao.selectList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO searchList(ProductionMstActVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = productionMstActDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(ProductionMstActVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = productionMstActDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	@Override
	public RtnVO deleteProductionOrder(ProductionMstActVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = productionMstActDao.deleteProductionOrder(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
