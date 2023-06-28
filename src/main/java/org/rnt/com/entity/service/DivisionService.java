package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.DivisionVO;
import org.rnt.com.vo.RtnVO;

public interface DivisionService {
	public RtnVO insert(DivisionVO param);
	public RtnVO select(DivisionVO param);
	public RtnVO update(DivisionVO param);
	public RtnVO delete(DivisionVO param);
	public RtnVO searchList(DivisionVO param);
	public RtnVO searchListTotCnt(DivisionVO param);
}
