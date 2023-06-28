package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.ItemGrpMiddleVO;
import org.rnt.com.vo.RtnVO;

public interface ItemGrpMiddleService {
	public RtnVO insert(ItemGrpMiddleVO param);
	public RtnVO select(ItemGrpMiddleVO param);
	public RtnVO update(ItemGrpMiddleVO param);
	public RtnVO delete(ItemGrpMiddleVO param);
	public RtnVO searchList(ItemGrpMiddleVO param);
	public RtnVO searchListTotCnt(ItemGrpMiddleVO param);
}
