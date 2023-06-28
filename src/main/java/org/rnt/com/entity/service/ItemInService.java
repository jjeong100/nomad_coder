package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.ItemInVO;
import org.rnt.com.vo.RtnVO;

public interface ItemInService {
	public RtnVO insert(ItemInVO param);
	public RtnVO select(ItemInVO param);
	public RtnVO selectProdOrderInfo(ItemInVO param);
	public RtnVO selectByLotId(ItemInVO param);
	public RtnVO update(ItemInVO param);
	public RtnVO delete(ItemInVO param);
	public RtnVO searchList(ItemInVO param);
	public RtnVO searchListTotCnt(ItemInVO param);
	public RtnVO selectPopItemInList(ItemInVO param);
}
