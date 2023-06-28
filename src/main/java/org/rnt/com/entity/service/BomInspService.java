package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.BomInspVO;
import org.rnt.com.vo.RtnVO;

public interface BomInspService {
	public RtnVO insert(BomInspVO param);
	public RtnVO select(BomInspVO param);
	public RtnVO update(BomInspVO param);
	public RtnVO delete(BomInspVO param);
	public RtnVO searchList(BomInspVO param);
	public RtnVO searchListTotCnt(BomInspVO param);
	public RtnVO selectInspList(BomInspVO param);
}
