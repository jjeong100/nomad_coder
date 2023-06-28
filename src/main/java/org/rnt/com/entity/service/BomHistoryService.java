package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.BomHistoryVO;
import org.rnt.com.vo.RtnVO;

public interface BomHistoryService {
	public RtnVO insert(BomHistoryVO param);
	public RtnVO select(BomHistoryVO param);
	public RtnVO update(BomHistoryVO param);
	public RtnVO delete(BomHistoryVO param);
	public RtnVO searchList(BomHistoryVO param);
	public RtnVO searchListTotCnt(BomHistoryVO param);
}
