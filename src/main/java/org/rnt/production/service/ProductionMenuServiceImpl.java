package org.rnt.production.service;

import javax.annotation.Resource;

import org.rnt.com.entity.vo.ProductionMstActVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.rnt.material.vo.MonthCloseInVO;
import org.rnt.material.vo.StockInVO;
import org.rnt.production.dao.ProductionMenuDao;
import org.springframework.stereotype.Service;

@Service("productionMenuService")
public class ProductionMenuServiceImpl extends BaseService implements ProductionMenuService {

	@Resource(name="productionMenuDao")
	private ProductionMenuDao productionMenuDao;

	@Override
	public RtnVO productionOperList(ProductionMstActVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = productionMenuDao.productionOperList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
    public RtnVO searchMonthCloseList(MonthCloseInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = productionMenuDao.searchMonthCloseList(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO searchMonthCloseListTotCnt(MonthCloseInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = productionMenuDao.searchMonthCloseListTotCnt(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO selectMinUnCloseMonth(MonthCloseInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = productionMenuDao.selectMinUnCloseMonth(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO selectMaxCloseMonth(MonthCloseInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = productionMenuDao.selectMaxCloseMonth(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO selectMaxCloseMonthAndDiffMonth(MonthCloseInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = productionMenuDao.selectMaxCloseMonthAndDiffMonth(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
}
