package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.InspItemVO;
import org.rnt.com.vo.RtnVO;

public interface InspItemService {
	public RtnVO insert(InspItemVO param);
	public RtnVO select(InspItemVO param);
	public RtnVO update(InspItemVO param);
	public RtnVO delete(InspItemVO param);
	public RtnVO searchList(InspItemVO param);
	public RtnVO searchListTotCnt(InspItemVO param);
}
