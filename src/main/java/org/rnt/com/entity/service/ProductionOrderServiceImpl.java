package org.rnt.com.entity.service;

import javax.annotation.Resource;

import org.rnt.com.GlvConst;
import org.rnt.com.entity.dao.ProductionOrderDao;
import org.rnt.com.entity.vo.ProductionOrderVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.rnt.production.dao.ProductionMenuDao;
import org.springframework.stereotype.Service;

@Service("productionOrderService")
public class ProductionOrderServiceImpl extends BaseService implements ProductionOrderService{

	@Resource(name="productionOrderDao")
	private ProductionOrderDao productionOrderDao;

	@Resource(name="productionMenuDao")
	private ProductionMenuDao productionMenuDao;


	@Override
	public RtnVO insert(ProductionOrderVO param) {
		RtnVO rtn = new RtnVO();
		try {
			param.setProdSeq((String)productionOrderDao.getBomHisSeq().getObj());

			rtn = productionOrderDao.insert(param);
			if (rtn.getRc() == GlvConst.RC_ERROR) {
				setRtnVO(rtn, "작업지시 생성중 오류", "");
				return rtn;
			}
			rtn = productionMenuDao.createMstAct(param);
			if (rtn.getRc() == GlvConst.RC_ERROR) {
				setRtnVO(rtn, "공정마스터 생성중 오류", "");
				return rtn;
			}
//			rtn = productionMenuDao.createMatRequire(param);
//			if (rtn.getRc() == GlvConst.RC_ERROR) {
//				setRtnVO(rtn, "자재 소요량 생성중 오류", "");
//				return rtn;
//			}
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(ProductionOrderVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = productionOrderDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO selectQmInfo(ProductionOrderVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = productionOrderDao.selectQmInfo(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(ProductionOrderVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = productionOrderDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO updateMstAct(ProductionOrderVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = productionMenuDao.deleteMstAct(param);
			if (rtn.getRc() == GlvConst.RC_ERROR) {
				setRtnVO(rtn, "자재 소요량 삭제중 오류", "");
				return rtn;
			}
			rtn = productionMenuDao.createMstAct(param);
			if (rtn.getRc() == GlvConst.RC_ERROR) {
				setRtnVO(rtn, "공정마스터 생성중 오류", "");
				return rtn;
			}
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO updateMatRequire(ProductionOrderVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = productionMenuDao.deleteMatRequire(param);
			if (rtn.getRc() == GlvConst.RC_ERROR) {
				setRtnVO(rtn, "자재 소요량 삭제중 오류", "");
				return rtn;
			}
			rtn = productionMenuDao.createMatRequire(param);
			if (rtn.getRc() == GlvConst.RC_ERROR) {
				setRtnVO(rtn, "자재 소요량 생성중 오류", "");
				return rtn;
			}
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(ProductionOrderVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = productionOrderDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(ProductionOrderVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = productionOrderDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(ProductionOrderVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = productionOrderDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchMonthList(ProductionOrderVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = productionOrderDao.searchMonthList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
