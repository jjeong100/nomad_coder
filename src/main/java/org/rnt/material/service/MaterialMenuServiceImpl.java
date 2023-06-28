package org.rnt.material.service;

import javax.annotation.Resource;

import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.rnt.material.dao.MaterialMenuDao;
import org.rnt.material.vo.MonthCloseInVO;
import org.rnt.material.vo.StockInVO;
import org.rnt.material.vo.SubulInVO;
import org.springframework.stereotype.Service;

@Service("materialMenuService")
public class MaterialMenuServiceImpl extends BaseService implements MaterialMenuService {

	@Resource(name="materialMenuDao")
	private MaterialMenuDao materialMenuDao;

	@Override
	public RtnVO searchStockList(StockInVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialMenuDao.searchStockList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchStockListTotCnt(StockInVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialMenuDao.searchStockListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO selectStockMatQtySum(StockInVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialMenuDao.selectStockMatQtySum(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
    public RtnVO searchSubulList(SubulInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = materialMenuDao.searchSubulList(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO searchSubulListTotCnt(SubulInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = materialMenuDao.searchSubulListTotCnt(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO searchMonthCloseList(MonthCloseInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = materialMenuDao.searchMonthCloseList(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO searchMonthCloseListTotCnt(MonthCloseInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = materialMenuDao.searchMonthCloseListTotCnt(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO selectMinUnCloseMonth(MonthCloseInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = materialMenuDao.selectMinUnCloseMonth(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO selectMaxCloseMonth(MonthCloseInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = materialMenuDao.selectMaxCloseMonth(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO selectMaxCloseMonthAndDiffMonth(MonthCloseInVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = materialMenuDao.selectMaxCloseMonthAndDiffMonth(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

	@Override
	public RtnVO searchBaseQty(StockInVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = materialMenuDao.searchBaseQty(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
