package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.ItemOutDtlVO;
import org.rnt.com.vo.RtnVO;

public interface ItemOutDtlService {
	public RtnVO insert(ItemOutDtlVO param);
	public RtnVO select(ItemOutDtlVO param);
	public RtnVO update(ItemOutDtlVO param);
	public RtnVO delete(ItemOutDtlVO param);
	public RtnVO searchList(ItemOutDtlVO param);
	public RtnVO searchListTotCnt(ItemOutDtlVO param);
}
