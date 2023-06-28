package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.MaterialStockVO;
import org.rnt.com.vo.RtnVO;

public interface MaterialStockService {
	public RtnVO insert(MaterialStockVO param);
	public RtnVO select(MaterialStockVO param);
	public RtnVO update(MaterialStockVO param);
	public RtnVO delete(MaterialStockVO param);
	public RtnVO searchList(MaterialStockVO param);
	public RtnVO searchListTotCnt(MaterialStockVO param);
}
