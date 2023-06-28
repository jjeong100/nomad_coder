package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.ItemStockVO;
import org.rnt.com.vo.RtnVO;

public interface ItemStockService {
	public RtnVO searchItemStockList(ItemStockVO param);
	public RtnVO searchItemStockListTotCnt(ItemStockVO param);
	public RtnVO searchBaseQty(ItemStockVO param);
}
