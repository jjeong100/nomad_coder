package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.ProductionOrderVO;
import org.rnt.com.vo.RtnVO;

public interface ProductionOrderService {
	public RtnVO insert(ProductionOrderVO param);
	public RtnVO select(ProductionOrderVO param);
	public RtnVO selectQmInfo(ProductionOrderVO param);
	public RtnVO update(ProductionOrderVO param);
	public RtnVO updateMstAct(ProductionOrderVO param);
	public RtnVO updateMatRequire(ProductionOrderVO param);
	public RtnVO delete(ProductionOrderVO param);
	public RtnVO searchList(ProductionOrderVO param);
	public RtnVO searchListTotCnt(ProductionOrderVO param);
	public RtnVO searchMonthList(ProductionOrderVO param);
}
