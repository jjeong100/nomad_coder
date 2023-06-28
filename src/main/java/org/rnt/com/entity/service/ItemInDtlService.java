package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.ItemInDtlVO;
import org.rnt.com.vo.RtnVO;

public interface ItemInDtlService {
	public RtnVO insert(ItemInDtlVO param);
	public RtnVO select(ItemInDtlVO param);
	public RtnVO update(ItemInDtlVO param);
	public RtnVO delete(ItemInDtlVO param);
	public RtnVO searchList(ItemInDtlVO param);
	public RtnVO searchListTotCnt(ItemInDtlVO param);
	public RtnVO selectByDtlLotId(ItemInDtlVO param);
	public RtnVO searchList2(ItemInDtlVO param);
}
