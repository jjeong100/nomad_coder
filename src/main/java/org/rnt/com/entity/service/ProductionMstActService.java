package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.ProductionMstActVO;
import org.rnt.com.vo.RtnVO;

public interface ProductionMstActService {
	public RtnVO insert(ProductionMstActVO param);
	public RtnVO select(ProductionMstActVO param);
	public RtnVO update(ProductionMstActVO param);
	public RtnVO updateAssignQty(ProductionMstActVO param);
	public RtnVO updateAssignQtyAtMix(ProductionMstActVO param);
	public RtnVO delete(ProductionMstActVO param);
	public RtnVO selectList(ProductionMstActVO param);
	public RtnVO searchList(ProductionMstActVO param);
	public RtnVO searchListTotCnt(ProductionMstActVO param);
	public RtnVO deleteProductionOrder(ProductionMstActVO productonMst);
}
