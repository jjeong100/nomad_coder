package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.BomVO;
import org.rnt.com.vo.RtnVO;

public interface BomService {
	public RtnVO insert(BomVO param);
	public RtnVO select(BomVO param);
	public RtnVO selectByItemCdAndOperSeq(BomVO param);
	public RtnVO update(BomVO param);
	public RtnVO delete(BomVO param);
	public RtnVO searchList(BomVO param);
	public RtnVO searchListTotCnt(BomVO param);
}
