package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.MaterialInVO;
import org.rnt.com.vo.RtnVO;

public interface MaterialInService {
	public RtnVO insert(MaterialInVO param);
	public RtnVO select(MaterialInVO param);
	public RtnVO selectByLotId(MaterialInVO param);
	public RtnVO update(MaterialInVO param);
	public RtnVO delete(MaterialInVO param);
	public RtnVO searchList(MaterialInVO param);
	public RtnVO searchListTotCnt(MaterialInVO param);
	public RtnVO searchMobileList(MaterialInVO param);
	public RtnVO selectPopMaterialInList(MaterialInVO param);
	public RtnVO searchMaterialStockList(MaterialInVO param);
}
