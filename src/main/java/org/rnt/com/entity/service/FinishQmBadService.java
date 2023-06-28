package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.FinishQmBadVO;
import org.rnt.com.vo.RtnVO;

public interface FinishQmBadService {
	public RtnVO insert(FinishQmBadVO param);
	public RtnVO select(FinishQmBadVO param);
	public RtnVO update(FinishQmBadVO param);
	public RtnVO delete(FinishQmBadVO param);
	public RtnVO selectList(FinishQmBadVO param);
	public RtnVO updateActbadQty(FinishQmBadVO param);
}
