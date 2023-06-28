package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.ItemSubulVO;
import org.rnt.com.vo.RtnVO;

public interface ItemSubulService {
	public RtnVO searchItemSubulList(ItemSubulVO param);
	public RtnVO searchItemSubulListTotCnt(ItemSubulVO param);
}
