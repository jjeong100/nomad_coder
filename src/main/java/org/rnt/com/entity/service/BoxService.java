package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.BoxVO;
import org.rnt.com.vo.RtnVO;

public interface BoxService {
	public RtnVO insert(BoxVO param);
	public RtnVO select(BoxVO param);
	public RtnVO update(BoxVO param);
	public RtnVO delete(BoxVO param);
	public RtnVO searchList(BoxVO param);
	public RtnVO searchListTotCnt(BoxVO param);
}
