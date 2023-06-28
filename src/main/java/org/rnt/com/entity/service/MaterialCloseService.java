package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.MaterialCloseVO;
import org.rnt.com.vo.RtnVO;

public interface MaterialCloseService {
	public RtnVO insert(MaterialCloseVO param);
	public RtnVO select(MaterialCloseVO param);
	public RtnVO update(MaterialCloseVO param);
	public RtnVO delete(MaterialCloseVO param);
	public RtnVO deleteMonthClose(MaterialCloseVO param);
	public RtnVO searchList(MaterialCloseVO param);
	public RtnVO searchListTotCnt(MaterialCloseVO param);
}
