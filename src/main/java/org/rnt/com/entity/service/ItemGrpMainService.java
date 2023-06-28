package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.ItemGrpMainVO;
import org.rnt.com.vo.RtnVO;

public interface ItemGrpMainService {
	public RtnVO insert(ItemGrpMainVO param);
	public RtnVO select(ItemGrpMainVO param);
	public RtnVO update(ItemGrpMainVO param);
	public RtnVO delete(ItemGrpMainVO param);
	public RtnVO searchList(ItemGrpMainVO param);
	public RtnVO searchListTotCnt(ItemGrpMainVO param);
}
