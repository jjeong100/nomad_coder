package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.ProductionStatusVO;
import org.rnt.com.vo.RtnVO;

public interface ProductionStatusService {
	public RtnVO insert(ProductionStatusVO param);
	public RtnVO select(ProductionStatusVO param);
	public RtnVO update(ProductionStatusVO param);
	public RtnVO searchList(ProductionStatusVO param);
	public RtnVO searchList2(ProductionStatusVO param);
	public RtnVO searchListTotCnt(ProductionStatusVO param);
}
